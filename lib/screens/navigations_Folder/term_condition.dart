import 'package:flutter/material.dart';

class TermCondition extends StatelessWidget {
  const TermCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Terms & Conditions",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: const Icon(Icons.arrow_back),
      ),
    );
  }
}
