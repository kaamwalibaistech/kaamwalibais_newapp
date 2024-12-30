import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';

import '../../navigation/presentation/packages.dart';

class PackagesPurchasePopup extends StatelessWidget {
  const PackagesPurchasePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.13,
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Buy Package",
              style: TextStyle(
                  color: blueColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // GestureDetector(
            //     onTap: () {
            //       Navigator.pop(context);
            //     },
            //     child: Container(
            //         decoration: BoxDecoration(
            //             color: blueColor,
            //             borderRadius: BorderRadius.circular(15)),
            //         child: const Icon(
            //           Icons.close,
            //           size: 28,
            //           color: whiteColor,
            //         )))

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => const EmployerLoginSignup()));
            //       },
            //       child: Image.asset(
            //         "lib/assets/images/employer_icon.png",
            //         cacheHeight: 130,
            //       ),
            //     ),
            //     GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>
            //                     const CandidateLoginSignup()));
            //       },
            //       child: Image.asset(
            //         "lib/assets/images/candidate_icon.png",
            //         cacheHeight: 130,
            //       ),
            //     ),
            //   ],
            // )
            Text("You do not have any active plan!"),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel ",
                      style: GoogleFonts.poltawskiNowy(
                          color: Colors.red, fontSize: 16),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Packages()));
                    },
                    child: Text(
                      "Buy Now",
                      style: GoogleFonts.poltawskiNowy(
                          color: blueColor, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
