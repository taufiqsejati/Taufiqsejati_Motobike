import 'package:flutter/material.dart';
import 'package:taufiqsejati_motobike/models/bike.dart';

class CheckoutPage extends StatefulWidget {
  final Bike bike;
  final String startDate;
  final String endDate;
  const CheckoutPage(
      {super.key,
      required this.bike,
      required this.startDate,
      required this.endDate});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
