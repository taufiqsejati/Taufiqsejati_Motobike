import 'package:taufiqsejati_motobike/controllers/booking_status_controller.dart';
import 'package:taufiqsejati_motobike/models/bike.dart';
import 'package:taufiqsejati_motobike/widgets/button_primary.dart';
import 'package:taufiqsejati_motobike/widgets/button_secondary.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PINPage extends StatefulWidget {
  const PINPage({super.key, required this.bike});
  final Bike bike;

  @override
  State<PINPage> createState() => _PINPageState();
}

class _PINPageState extends State<PINPage> {
  final bookingStatusController = Get.find<BookingStatusController>();
  final pin1 = TextEditingController();
  final pin2 = TextEditingController();
  final pin3 = TextEditingController();
  final pin4 = TextEditingController();

  final isComplete = false.obs;

  tapPin(int number) {
    if (pin1.text == '') {
      pin1.text = number.toString();
      return;
    }
    if (pin2.text == '') {
      pin2.text = number.toString();
      return;
    }
    if (pin3.text == '') {
      pin3.text = number.toString();
      return;
    }
    if (pin4.text == '') {
      pin4.text = number.toString();
      isComplete.value = true;
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gap(20 + MediaQuery.of(context).padding.top),
          buildHeader(),
          const Gap(24),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    inputPIN(pin1),
                    const Gap(24),
                    inputPIN(pin2),
                    const Gap(24),
                    inputPIN(pin3),
                    const Gap(24),
                    inputPIN(pin4),
                  ],
                ),
                const Gap(50),
                buildNumberInput(),
              ],
            ),
          ),
          const Gap(50),
          Obx(() {
            if (!isComplete.value) return const SizedBox();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ButtonPrimary(
                text: 'Pay Now',
                onTap: () {
                  bookingStatusController.bike = {
                    'id': widget.bike.id,
                    'name': widget.bike.name,
                    'image': widget.bike.image,
                    'category': widget.bike.category,
                  };
                  Navigator.pushNamed(
                    context,
                    '/success-booking',
                    arguments: widget.bike,
                  );
                },
              ),
            );
          }),
          const Gap(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ButtonSecondary(
              text: 'Cancel Payment',
              onTap: () => Navigator.pop(context),
            ),
          ),
          const Gap(30),
        ],
      ),
    );
  }

  Widget buildNumberInput() {
    return SizedBox(
      width: 300,
      child: GridView.count(
        crossAxisCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        children: [1, 2, 3, 4, 5, 6, 7, 8, 9].map((number) {
          return Center(
            child: IconButton(
              onPressed: () => tapPin(number),
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white),
              ),
              constraints: const BoxConstraints(
                minHeight: 60,
                maxHeight: 60,
                maxWidth: 60,
                minWidth: 60,
              ),
              icon: Text(
                '$number',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Color(0xff070623),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget inputPIN(TextEditingController editingController) {
    InputBorder inputBorder = const UnderlineInputBorder(
        borderSide: BorderSide(
      color: Color(0xff070623),
      width: 3,
    ));
    return SizedBox(
      width: 30,
      child: TextField(
        controller: editingController,
        obscureText: true,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 32,
          color: Color(0xff070623),
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          enabled: false,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          border: inputBorder,
          disabledBorder: inputBorder,
        ),
      ),
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
              'Wallet Security',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff070623),
              ),
            ),
          ),
          Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/ic_more.png',
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
    );
  }
}
