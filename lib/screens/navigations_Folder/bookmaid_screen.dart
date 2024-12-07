import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        // title: Image.asset(
        //   "lib/assets/images/kaamwalijobs.png",
        //   height: 50,
        // ),

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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      height: MediaQuery.of(context).size.height * 0.43,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AnimatedRatingStars(
                                  initialRating: 5,
                                  onChanged: (_) {
                                    // setState(() {});
                                  },
                                  displayRatingValue:
                                      true, // Display the rating value
                                  interactiveTooltips:
                                      true, // Allow toggling half-star state
                                  customFilledIcon: Icons.star,
                                  customHalfFilledIcon: Icons.star_half,
                                  customEmptyIcon: Icons.star_border,
                                  starSize: 15.0,
                                  animationDuration:
                                      const Duration(milliseconds: 500),
                                  animationCurve: Curves.easeInOut,
                                ),
                                Container(
                                  decoration:
                                      const BoxDecoration(color: blueColor),
                                  height: 30,
                                  width: 80,
                                  child: Center(
                                    child: Text(
                                      "Babysitter",
                                      style:
                                          GoogleFonts.roboto(color: whiteColor),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 158, 153, 153)),
                              child: const Icon(
                                Icons.person_add_alt_1_rounded,
                                size: 28,
                              ),
                            ),
                            title: Text(
                              "Ritesh Dixit",
                              style: GoogleFonts.roboto(),
                            ),
                            subtitle: Text(
                              "Kalyan , Maharashtra",
                              style: GoogleFonts.roboto(),
                            ),
                            trailing: Image.asset(
                              "lib/assets/images/verified_2x.gif",
                              height: 30,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(

                                        // textAlign: TextAlign.start,
                                        text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black),
                                            children: [
                                          TextSpan(
                                            text: "Age: ",
                                            style: GoogleFonts.roboto(),
                                          ),
                                          TextSpan(
                                            text: "21 yrs",
                                            style: GoogleFonts.roboto(),
                                          )
                                        ])),
                                    RichText(

                                        // textAlign: TextAlign.start,
                                        text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black),
                                            children: [
                                          TextSpan(
                                            text: "gender: ",
                                            style: GoogleFonts.roboto(),
                                          ),
                                          TextSpan(
                                            text: "Male",
                                            style: GoogleFonts.roboto(),
                                          )
                                        ])),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(

                                        // textAlign: TextAlign.start,
                                        text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black),
                                            children: [
                                          TextSpan(
                                            text: "Maritial Status: ",
                                            style: GoogleFonts.roboto(),
                                          ),
                                          TextSpan(
                                            text: "Unmarried",
                                            style: GoogleFonts.roboto(),
                                          )
                                        ])),
                                    RichText(

                                        // textAlign: TextAlign.start,
                                        text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black),
                                            children: [
                                          TextSpan(
                                            text: "Education: ",
                                            style: GoogleFonts.roboto(),
                                          ),
                                          TextSpan(
                                            text: "< 5TH",
                                            style: GoogleFonts.roboto(),
                                          )
                                        ])),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(

                                        // textAlign: TextAlign.start,
                                        text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black),
                                            children: [
                                          TextSpan(
                                            text: "Religion: ",
                                            style: GoogleFonts.roboto(),
                                          ),
                                          TextSpan(
                                            text: "Hindu",
                                            style: GoogleFonts.roboto(),
                                          )
                                        ])),
                                    RichText(

                                        // textAlign: TextAlign.start,
                                        text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black),
                                            children: [
                                          TextSpan(
                                            text: "Working Hours: ",
                                            style: GoogleFonts.roboto(),
                                          ),
                                          TextSpan(
                                            text: "8 hours",
                                            style: GoogleFonts.roboto(),
                                          )
                                        ])),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black),
                                            children: [
                                          TextSpan(
                                            text: "Total Experience: ",
                                            style: GoogleFonts.roboto(),
                                          ),
                                          TextSpan(
                                            text: "3 Years",
                                            style: GoogleFonts.roboto(),
                                          )
                                        ])),
                                    RichText(

                                        // textAlign: TextAlign.start,
                                        text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black),
                                            children: [
                                          TextSpan(
                                            text: "Language: ",
                                            style: GoogleFonts.roboto(),
                                          ),
                                          TextSpan(
                                            text: "Hindi",
                                            style: GoogleFonts.roboto(),
                                          )
                                        ])),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black),
                                            children: [
                                          TextSpan(
                                            text: "Expected Salary: ",
                                            style: GoogleFonts.roboto(),
                                          ),
                                          TextSpan(
                                            text: "Rs 30000",
                                            style: GoogleFonts.roboto(),
                                          )
                                        ])),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    width: 174,
                                    decoration:
                                        const BoxDecoration(color: blueColor),
                                    child: const Center(
                                      child: Text(
                                        "Profile",
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    width: 174,
                                    decoration: const BoxDecoration(
                                        color: selectionGreenColor),
                                    child: const Center(
                                      child: Text(
                                        "8169669043",
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration:
                                    const BoxDecoration(color: textGreyColor),
                                child: const Center(
                                  child: Text(
                                    "Select Option",
                                    style: TextStyle(color: whiteColor),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
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
