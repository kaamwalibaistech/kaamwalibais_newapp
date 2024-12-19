import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/core/local_storage.dart';
import 'package:kaamwalijobs_new/models/employer_register_model.dart';
import 'package:kaamwalijobs_new/screens/navigations_Folder/login_popup.dart';
import 'package:kaamwalijobs_new/screens/navigations_Folder/packages.dart';
import 'package:kaamwalijobs_new/screens/webview_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    EmployerRegisterModel? employerRegisterModel =
        LocalStoragePref.instance?.getUserProfile();
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
            if (employerRegisterModel != null)
              const SizedBox(
                height: 60.0,
              )
            else ...[
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
                              builder: (context) =>
                                  const AlertDialog(content: LoginPopup()
                                      // actions: const [],
                                      ));
                        },
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Login ',
                                style: GoogleFonts.roboto(fontSize: 18),
                              ),
                              const TextSpan(
                                text: '/',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              TextSpan(
                                text: ' Signup',
                                style: GoogleFonts.roboto(fontSize: 18),
                              ),
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
            ],
            const SizedBox(
              height: 10,
            ),

            Text(
              "Menu",
              style: GoogleFonts.poltawskiNowy(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Packages()));
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
                  ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text("This Feature is Coming soon")));
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
                              builder: (context) => const WebviewWidget(
                                    appBarTitle: 'About Us',
                                    url: 'https://kaamwalijobs.com/about-us',
                                  )));
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WebviewWidget(
                                    appBarTitle: 'Contact Us',
                                    url: 'https://kaamwalijobs.com/contact-us',
                                  )));
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
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WebviewWidget(
                                    appBarTitle: 'Privacy Policy',
                                    url:
                                        'https://kaamwalijobs.com/privacy-policy',
                                  )));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const PrivacyPolicy()));
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

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WebviewWidget(
                              appBarTitle: 'Terms & Conditions',
                              url: 'https://kaamwalijobs.com/terms-condition',
                            )));
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const TermCondition()));
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10)),
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
                ],
              ),
            ),
            if (employerRegisterModel != null)
              Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: GestureDetector(
                    onTap: () {
                      LocalStoragePref.instance!.clearAllPref();
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: const BoxDecoration(color: blueColor),
                        child: const Center(
                          child: Text(
                            "Log Out",
                            style: TextStyle(color: whiteColor),
                          ),
                        )),
                  )),
          ],
        ),
      ),
    );
  }
}
