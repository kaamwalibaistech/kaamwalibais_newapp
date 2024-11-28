import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/screens/candidate_login_signup.dart';
import 'package:kaamwalijobs_new/screens/navigations_Folder/about_us.dart';
import 'package:kaamwalijobs_new/screens/navigations_Folder/employer_login_signup.dart';
import 'package:kaamwalijobs_new/screens/navigations_Folder/privacy_policy.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.asset(
            //   "lib/assets/images/kaamwalijobs.png",
            //   height: 50,
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Row(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.13,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(
                        Icons.person_3_outlined,
                        size: 28,
                        color: scaffoldColor,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 50.0),
                                              child: Text(
                                                "LogIn/Sign-up",
                                                style: TextStyle(
                                                    color: blueColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        color: blueColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: const Icon(
                                                      Icons.close,
                                                      size: 28,
                                                      color: whiteColor,
                                                    )))
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const EmployerLoginSignup()));
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
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // actions: const [],
                                ));
                      },
                      child: const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Login ', style: TextStyle(fontSize: 18)),
                            TextSpan(
                              text: '/',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            TextSpan(
                                text: ' Signup',
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10),
              child: Divider(
                thickness: 2,
              ),
            ),

            const Text(
              "Menu",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          "lib/assets/images/packages.png",
                          color: Colors.grey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Packages",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          "lib/assets/images/become_an_agent.png",
                          color: Colors.grey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Becaome\n an agent",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          "lib/assets/images/my_jobs.png.png",
                          color: Colors.grey,
                          height: 10,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "My Jobs",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutUs()));
                    },
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.25,
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              "lib/assets/images/about.png.png",
                              color: Colors.grey,
                            )),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            "About us",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          "lib/assets/images/contact_us.png",
                          color: Colors.grey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Contact us",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrivacyPolicy()));
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            "lib/assets/images/privacy_policy.png",
                            color: Colors.grey,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Privacy & \n Policy",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(10)),
                child: Image.asset(
                  "lib/assets/images/terms_and_conditions.png",
                  color: Colors.grey,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                "Term & \n Conditions",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: const BoxDecoration(color: blueColor),
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Post job",
                        style: TextStyle(color: whiteColor),
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
