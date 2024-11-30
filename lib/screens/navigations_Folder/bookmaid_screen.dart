import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';

class BookmaidScreen extends StatefulWidget {
  const BookmaidScreen({super.key});

  @override
  State<BookmaidScreen> createState() => _BookmaidScreenState();
}

class _BookmaidScreenState extends State<BookmaidScreen> {
  bool isloading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,

        title: Container(
          padding: const EdgeInsets.only(left: 10),
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(255, 222, 219, 219)),
              color: whiteColor,
              borderRadius: BorderRadius.circular(10)),
          child: const TextField(
            // controller: _controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 2),
              hintText: "Search",
              hintStyle: TextStyle(color: textGreyColor),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 50,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 222, 219, 219)),
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      height: MediaQuery.of(context).size.height * 0.38,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
