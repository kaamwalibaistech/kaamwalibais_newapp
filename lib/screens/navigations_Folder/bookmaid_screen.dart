import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/screens/shimmer_effect/book_maid_shimmer.dart';

class BookmaidScreen extends StatefulWidget {
  const BookmaidScreen({super.key});

  @override
  State<BookmaidScreen> createState() => _BookmaidScreenState();
}

class _BookmaidScreenState extends State<BookmaidScreen> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: isloading ? const Text("data") : const BookMaidShimmer()),
    );
  }
}
