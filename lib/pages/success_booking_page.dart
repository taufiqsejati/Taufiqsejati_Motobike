import 'package:taufiqsejati_motobike/models/bike.dart';
import 'package:taufiqsejati_motobike/widgets/button_primary.dart';
import 'package:taufiqsejati_motobike/widgets/button_secondary.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SuccessBookingPage extends StatelessWidget {
  const SuccessBookingPage({super.key, required this.bike});
  final Bike bike;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const Gap(80),
          const Text(
            'Success Booking\nHave a Great Ride!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 32,
              color: Color(0xff070623),
            ),
          ),
          const Gap(50),
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
          const Gap(50),
          Text(
            bike.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: Color(0xff070623),
            ),
          ),
          Text(
            bike.category,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Color(0xff838384),
            ),
          ),
          const Gap(50),
          ButtonPrimary(
            text: 'Booking Order Bike',
            onTap: () {
              Navigator.restorablePushNamedAndRemoveUntil(
                context,
                '/discover',
                (route) => route.settings.name == '/detail',
              );
            },
          ),
          const Gap(12),
          ButtonSecondary(
            text: 'View My Orders',
            onTap: () {
              Navigator.restorablePushNamedAndRemoveUntil(
                context,
                '/discover',
                (route) => route.settings.name == '/detail',
              );
            },
          ),
        ],
      ),
    );
  }
}
