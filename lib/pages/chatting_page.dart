import 'package:flutter/material.dart';

class ChattingPage extends StatefulWidget {
  final String uid;
  final String userName;
  const ChattingPage({super.key, required this.uid, required this.userName});

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
