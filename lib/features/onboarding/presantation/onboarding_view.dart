import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/features/navigation/presentation/navigationscreen.dart';
import 'package:kaamwalijobs_new/features/onboarding/presantation/onboarding_items.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../screens/webview_widget.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingView> {
  bool isLastPage = false;

  final controller = OnboardingItems();
  final pageController = PageController();
  bool? checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        color: whiteColor,
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => pageController
                          .jumpToPage(controller.items.length - 1),
                      child: const Text(
                        "Skip",
                        style: TextStyle(color: textGreyColor),
                      )),
                  SmoothPageIndicator(
                    controller: pageController,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn),
                    count: controller.items.length,
                    effect: const WormEffect(
                        activeDotColor: Color(0xff2C557D),
                        dotHeight: 12,
                        dotWidth: 12),
                  ),
                  GestureDetector(
                      onTap: () {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeIn);
                      },
                      child: Container(
                          height: screenHeight * 0.05,
                          width: screenwidth * 0.30,
                          decoration:
                              const BoxDecoration(color: Color(0xff2C557D)),
                          child: const Center(
                              child: Text(
                            "Next",
                            style: TextStyle(color: whiteColor),
                          )))),
                ],
              ),
      ),
      body: PageView.builder(
        onPageChanged: (index) => setState(() {
          isLastPage = controller.items.length - 1 == index;
        }),
        itemCount: controller.items.length,
        controller: pageController,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
              ),
              Image.asset(
                controller.items[index].images,
                height: 300,
              ),
              Text(
                controller.items[index].title,
                style: GoogleFonts.poppins(
                    fontSize: 28,
                    color: textBlackColor4,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  textAlign: TextAlign.center,
                  controller.items[index].descriptions,
                  style: GoogleFonts.poltawskiNowy(color: textBlackColor4),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              isLastPage
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: checkBoxValue,
                            onChanged: (newValue) {
                              setState(() {
                                checkBoxValue = newValue;
                              });
                            }),
                        Text(
                          "I agree to ",
                          style: TextStyle(fontSize: 12),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const WebviewWidget(
                                            appBarTitle: 'Terms & Conditions',
                                            url:
                                                'https://kaamwalijobs.com/terms-condition',
                                          )));
                            },
                            child: Text(
                              "Terms of Services ",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue),
                            )),
                        Text(
                          "and ",
                          style: TextStyle(fontSize: 12),
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
                          },
                          child: Text(
                            "Privacy Policy.",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue),
                          ),
                        )
                      ],
                    )
                  : SizedBox()
            ],
          );
        },
      ),
    );
  }

  Widget getStarted() {
    return Container(
        width: MediaQuery.of(context).size.width * .9,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: const BoxDecoration(color: Color(0xff2C557D)),
        child: TextButton(
            onPressed: () async {
              final pres = await SharedPreferences.getInstance();
              pres.setBool("onboarrding", true);
              // if (!mounted) return;
              if (checkBoxValue == true) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Navigationscreen()));
              } else {
                Fluttertoast.showToast(msg: "Accept all Privacy and Policy");
              }
            },
            child: const Text(
              "Get Started",
              style: TextStyle(color: Colors.white),
            )));
  }
}
