import 'package:taufiqsejati_motobike/models/account.dart';
import 'package:taufiqsejati_motobike/models/bike.dart';
import 'package:taufiqsejati_motobike/widgets/button_primary.dart';
import 'package:d_session/d_session.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage(
      {super.key,
      required this.bike,
      required this.startDate,
      required this.endDate});
  final Bike bike;
  final String startDate;
  final String endDate;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  num balance = 9500900;
  // num balance = 0;
  double grandTotal = 9200345;
  int? _selectedIndex;

  FToast fToast = FToast();

  checkoutNow() {
    if (balance < grandTotal) {
      Widget notifUI = Transform.translate(
        offset: const Offset(0, -50),
        child: Container(
          height: 96,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffFF2055),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                offset: const Offset(0, 16),
                color: const Color(0xffFF2055).withOpacity(0.25),
              ),
            ],
          ),
          child: const Text(
            'Failed to checkout. Your wallet has no enough balance at this moment.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.5,
              color: Color(0xffFFFFFF),
            ),
          ),
        ),
      );
      fToast.showToast(
        child: notifUI,
        gravity: ToastGravity.TOP,
        toastDuration: const Duration(milliseconds: 2500),
      );
      return;
    }

    Navigator.pushNamed(context, '/pin', arguments: widget.bike);
  }

  @override
  void initState() {
    fToast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Gap(20 + MediaQuery.of(context).padding.top),
          buildHeader(),
          const Gap(24),
          buildSnippetBike(),
          const Gap(24),
          buildDetails(),
          const Gap(24),
          buildPaymentMethod(),
          const Gap(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ButtonPrimary(
              text: 'Checkout Now',
              onTap: () => checkoutNow(),
            ),
          ),
          const Gap(30),
        ],
      ),
    );
  }

  Widget buildPaymentMethod() {
    final payments = [
      ['My Wallet', 'assets/wallet.png'],
      ['Credit Card', 'assets/cards.png'],
      ['Cash', 'assets/cash.png'],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff070623),
            ),
          ),
        ),
        const Gap(12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: payments.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  debugPrint(index.toString());
                  setState(() {
                    if (_selectedIndex == index) {
                      // <-- HERE
                      _selectedIndex = null;
                    } else {
                      _selectedIndex = index;
                    }
                  });
                },
                child: Container(
                  width: 130,
                  margin: EdgeInsets.only(
                    left: index == 0 ? 24 : 8,
                    right: index == payments.length - 1 ? 24 : 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: _selectedIndex == index
                        ? Border.all(
                            width: 3,
                            color: const Color(0xff4A1DFF),
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        payments[index][1],
                        width: 38,
                        height: 38,
                      ),
                      const Gap(10),
                      Text(
                        payments[index][0],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff070623),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        _selectedIndex == 0
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                margin: const EdgeInsets.only(top: 24),
                child: FutureBuilder(
                  future: DSession.getUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                          height: 220,
                          child: Center(child: CircularProgressIndicator()));
                    }
                    Account account =
                        Account.fromJson(Map.from(snapshot.data!));
                    return Stack(
                      children: [
                        Image.asset(
                          'assets/bg_wallet.png',
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                        Positioned(
                          left: 20,
                          right: 20,
                          bottom: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                account.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                              const Text(
                                '02/30',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Balance',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                              const Gap(6),
                              Text(
                                NumberFormat.currency(
                                  decimalDigits: 0,
                                  locale: 'en_US',
                                  symbol: '\$',
                                ).format(balance),
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xffFFFFFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget buildDetails() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 16,
      ),
      child: Column(
        children: [
          buildItemDetail1('Price', '\$50,000', '/day'),
          const Gap(14),
          buildItemDetail2('Start Date', widget.startDate),
          const Gap(14),
          buildItemDetail2('End Date', widget.endDate),
          const Gap(14),
          buildItemDetail1('Duration', '15', ' day'),
          const Gap(14),
          buildItemDetail2('Sub Total Price', '\$250,490'),
          const Gap(14),
          buildItemDetail2('Insurance 20%', '\$14,394'),
          const Gap(14),
          buildItemDetail2('Tax 20%', '\$3,394'),
          const Gap(14),
          buildItemDetail3(
            'Grand Total',
            NumberFormat.currency(
              decimalDigits: 0,
              locale: 'en_US',
              symbol: '\$',
            ).format(grandTotal),
          ),
        ],
      ),
    );
  }

  Widget buildItemDetail1(String title, String data, String unit) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff838384),
          ),
        ),
        const Spacer(),
        Text(
          data,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff070623),
          ),
        ),
        Text(
          unit,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff070623),
          ),
        ),
      ],
    );
  }

  Widget buildItemDetail2(String title, String data) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff838384),
          ),
        ),
        const Spacer(),
        Text(
          data,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff070623),
          ),
        ),
      ],
    );
  }

  Widget buildItemDetail3(String title, String data) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff838384),
          ),
        ),
        const Spacer(),
        Text(
          data,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff4A1DFF),
          ),
        ),
      ],
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 46,
              width: 46,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/ic_arrow_back.png',
                height: 24,
                width: 24,
              ),
            ),
          ),
          const Expanded(
            child: Text(
              'Checkout',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff070623),
              ),
            ),
          ),
          const SizedBox(
            height: 46,
            width: 46,
          )
          // Container(
          //   height: 46,
          //   width: 46,
          //   decoration: const BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Colors.white,
          //   ),
          //   alignment: Alignment.center,
          //   child: Image.asset(
          //     'assets/ic_more.png',
          //     height: 24,
          //     width: 24,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildSnippetBike() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 16,
      ),
      height: 98,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Row(
        children: [
          ExtendedImage.network(
            widget.bike.image,
            width: 90,
            height: 70,
            fit: BoxFit.contain,
          ),
          const Gap(10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.bike.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff070623),
                  ),
                ),
                Text(
                  widget.bike.category,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff838384),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                '${widget.bike.rating}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff070623),
                ),
              ),
              const Gap(4),
              const Icon(
                Icons.star,
                size: 20,
                color: Color(0xffFFBC1C),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
