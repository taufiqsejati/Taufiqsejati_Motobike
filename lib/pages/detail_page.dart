import 'package:taufiqsejati_motobike/common/info.dart';
import 'package:taufiqsejati_motobike/controllers/detail_controller.dart';
import 'package:taufiqsejati_motobike/models/account.dart';
import 'package:taufiqsejati_motobike/models/bike.dart';
import 'package:taufiqsejati_motobike/models/chat.dart';
import 'package:taufiqsejati_motobike/sources/chat_source.dart';
import 'package:taufiqsejati_motobike/widgets/button_primary.dart';
import 'package:taufiqsejati_motobike/widgets/failed_ui.dart';
import 'package:d_session/d_session.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.bikeId});
  final String bikeId;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final detailController = Get.put(DetailController());

  late final Account account;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      detailController.fetchBike(widget.bikeId);
    });
    DSession.getUser().then((value) {
      account = Account.fromJson(Map.from(value!));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Gap(MediaQuery.of(context).padding.top),
          buildHeader(),
          const Gap(30),
          Obx(() {
            String status = detailController.status;
            if (status == '') return const SizedBox();
            if (status == 'loading') {
              return const Center(child: CircularProgressIndicator());
            }
            if (status != 'success') {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: FailedUI(message: status),
              );
            }
            Bike bike = detailController.bike;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      bike.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff070623),
                      ),
                    ),
                  ),
                  const Gap(10),
                  builStats(bike),
                  const Gap(30),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.asset(
                        'assets/ellipse.png',
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ExtendedImage.network(
                          bike.image,
                          height: 250,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ],
                  ),
                  const Gap(30),
                  const Text(
                    'About',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff070623),
                    ),
                  ),
                  const Gap(10),
                  Text(
                    bike.about,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff070623),
                    ),
                  ),
                  const Gap(40),
                  buildPrice(bike),
                  const Gap(16),
                  buildSendMessage(bike),
                  const Gap(30),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget buildSendMessage(Bike bike) {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: const Color(0xffFFFFFF),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          String uid = account.uid;
          Chat chat = Chat(
            roomId: uid,
            message: 'Ready?',
            receiverId: 'cs',
            senderId: uid,
            bikeDetail: {
              'image': bike.image,
              'name': bike.name,
              'category': bike.category,
              'id': bike.id,
            },
          );
          Info.netral('Loading...');
          ChatSource.openChatRoom(uid, account.name).then((value) {
            ChatSource.send(chat, uid).then((value) {
              Navigator.pushNamed(context, '/chatting', arguments: {
                'uid': uid,
                'userName': account.name,
              });
            });
          });
        },
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/ic_message.png',
                width: 24,
                height: 24,
              ),
              const Gap(10),
              const Text(
                'Send Message',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff070623),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPrice(Bike bike) {
    return Container(
      height: 88,
      decoration: BoxDecoration(
        color: const Color(0xff070623),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  NumberFormat.currency(
                    decimalDigits: 0,
                    locale: 'en_US',
                    symbol: '\$',
                  ).format(bike.price),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffFFFFFF),
                  ),
                ),
                const Text(
                  '/day',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffFFFFFF),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 132,
            child: ButtonPrimary(
              text: 'Book Now',
              onTap: () {
                Navigator.pushNamed(context, '/booking', arguments: bike);
              },
            ),
          ),
        ],
      ),
    );
  }

  Row builStats(Bike bike) {
    final stats = [
      ['assets/ic_beach.png', bike.level],
      [],
      ['assets/ic_downhill.png', bike.category],
      [],
      ['assets/ic_star.png', '${bike.rating}/5'],
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stats.map((e) {
        if (e.isEmpty) return const Gap(20);
        return Row(
          children: [
            Image.asset(e[0], width: 24, height: 24),
            const Gap(4),
            Text(
              e[1],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff070623),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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
              'Details',
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
          //     'assets/ic_favorite.png',
          //     height: 24,
          //     width: 24,
          //   ),
          // ),
        ],
      ),
    );
  }
}
