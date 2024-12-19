import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../assets/colors.dart';
import '../../core/local_storage.dart';
import '../../models/employer_register_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    EmployerRegisterModel? employerRegisterModel =
        LocalStoragePref.instance?.getUserProfile();
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        title: Image.asset(
          "lib/assets/images/kaamwalijobs.png",
          cacheHeight: 40,
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10.0),
        //     child: Container(
        //         height: MediaQuery.of(context).size.height * 0.05,
        //         width: MediaQuery.of(context).size.width * 0.25,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(10), color: blueColor),
        //         child: TextButton(
        //             onPressed: () {},
        //             child: Text(
        //               "Post job",
        //               style: GoogleFonts.poltawskiNowy(color: whiteColor),
        //             ))),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Text(
                "Personal Details",
                style: GoogleFonts.poltawskiNowy(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: whiteColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 200, 197, 197),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Name",
                              style: GoogleFonts.poltawskiNowy(),
                            ),
                            Text(
                              employerRegisterModel?.name ?? "----",
                              style: GoogleFonts.poltawskiNowy(),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Contact",
                              style: GoogleFonts.poltawskiNowy(),
                            ),
                            Text(
                              employerRegisterModel?.mobileNo ?? "----",
                              style: GoogleFonts.poltawskiNowy(),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Location",
                              style: GoogleFonts.poltawskiNowy(),
                            ),
                            Text(
                              "----",
                              style: GoogleFonts.poltawskiNowy(),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Email",
                              style: GoogleFonts.poltawskiNowy(),
                            ),
                            Text(
                              employerRegisterModel?.emailId ?? "",
                              style: GoogleFonts.poltawskiNowy(),
                            )
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 15.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         "GST No.",
                      //         style: GoogleFonts.poltawskiNowy(),
                      //       ),
                      //       Text(
                      //         "----",
                      //         style: GoogleFonts.poltawskiNowy(),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.042,
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: blueColor)),
                        child: Center(
                          child: Text(
                            "Edit profile",
                            style: GoogleFonts.poltawskiNowy(color: blueColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
