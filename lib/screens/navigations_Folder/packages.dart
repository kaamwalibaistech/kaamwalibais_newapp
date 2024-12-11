import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/screens/widgets/packages_image.dart';

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
                        child: Stack(children: [
                          Image.asset(
                            image[index],
                            height: 131,
                          ),
                          Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "Wallet Plan",
                                    style: GoogleFonts.poltawskiNowy(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "for 30 days",
                                  style: GoogleFonts.poltawskiNowy(
                                      fontSize: 18, color: blueColor),
                                ),
                                const Text("Total Candidate 100"),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.10,
                                ),
                                Text(
                                  "Unlimited Response.",
                                  style: GoogleFonts.roboto(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    "Dedicated account Executive.",
                                    style: GoogleFonts.roboto(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    "1 Job Post Free.",
                                    style: GoogleFonts.roboto(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    "100% Secure!",
                                    style: GoogleFonts.roboto(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    "18% GST Included.",
                                    style: GoogleFonts.roboto(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "View More",
                                    style: GoogleFonts.poltawskiNowy(
                                        decoration: TextDecoration.underline,
                                        color: blueColor),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: RichText(
                                      text: TextSpan(
                                          style: const TextStyle(
                                              color: blackColor),
                                          children: [
                                        TextSpan(
                                            text: "RS. 1",
                                            style: GoogleFonts.poltawskiNowy(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                        const TextSpan(
                                            text: "/",
                                            style: TextStyle(fontSize: 22)),
                                        const TextSpan(
                                            text: "30 days",
                                            style: TextStyle(color: blackColor))
                                      ])),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: blackColor),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      width: MediaQuery.of(context).size.width *
                                          0.30,
                                      child: Center(
                                        child: Text(
                                          "Buy Now",
                                          style: GoogleFonts.roboto(
                                              color: whiteColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ]),
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
                  itemCount: 3,
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
                        child: Column(
                          children: [Image.asset(image[index])],
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
