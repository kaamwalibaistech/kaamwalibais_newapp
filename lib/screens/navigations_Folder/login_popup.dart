import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/screens/candidate_login_signup.dart';
import 'package:kaamwalijobs_new/screens/navigations_Folder/employer_login_signup.dart';

class LoginPopup extends StatelessWidget {
  const LoginPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 50.0),
                  child: Text(
                    "LogIn/Sign-up",
                    style: TextStyle(
                        color: blueColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(
                          Icons.close,
                          size: 28,
                          color: whiteColor,
                        )))
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EmployerLoginSignup()));
                  },
                  child: Image.asset(
                    "lib/assets/images/employer_icon.png",
                    cacheHeight: 130,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CandidateLoginSignup()));
                  },
                  child: Image.asset(
                    "lib/assets/images/candidate_icon.png",
                    cacheHeight: 130,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
