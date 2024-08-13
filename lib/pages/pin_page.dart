import 'package:flutter/material.dart';

import '../models/bike.dart';

class PinPage extends StatefulWidget {
  final Bike bike;
  const PinPage({super.key, required this.bike});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
