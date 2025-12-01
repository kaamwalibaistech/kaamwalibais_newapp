import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';

import '../../packages/packages.dart';

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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
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
