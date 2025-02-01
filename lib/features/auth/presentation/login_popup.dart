import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';

import 'candidate_login_signup.dart';
import 'employer_login_signup.dart';

class LoginPopup extends StatelessWidget {
  const LoginPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EmployerLoginSignup()));
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "lib/assets/images/employer_icon.png",
                        cacheHeight: 110,
                      ),
                      Text(
                        "मुझे लोग काम पे रखना है",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: blueColor),
                      ),
                    ],
                  ),
                ),
                sizedBoxH10,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CandidateLoginSignup()));
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "lib/assets/images/candidate_icon.png",
                        cacheHeight: 110,
                      ),
                      sizedBoxH5,
                      Text(
                        "मुझे नौकरी चाहिए",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: blueColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
