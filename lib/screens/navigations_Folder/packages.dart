import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';

class Packages extends StatelessWidget {
  const Packages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(Icons.arrow_back),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Center(
                child: Text(
                  "Choose a Candidate Plan That's right for you",
                  style:
                      GoogleFonts.poltawskiNowy(fontSize: 18, color: blueColor),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: ShapeDecoration(
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 10,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: whiteColor,
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Center(
                child: Text(
                  "Choose a Job Posting Plan That's right for you",
                  style:
                      GoogleFonts.poltawskiNowy(fontSize: 18, color: blueColor),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: ShapeDecoration(
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 10,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: whiteColor,
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
