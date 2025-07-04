import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/Client/homepage_api.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/models/employer_register_model.dart';

import '../../../constant/sizebox.dart';
import '../../../models/empolyer_registerotp_model.dart';
import '../network/auth_repository.dart';

class CandidateRegisterOtpScreen extends StatefulWidget {
  final String name;
  final mobileNo;
  final String? email;
  final password;
  final category;
  final maritalStatus;
  final age;
  final religion;
  final gender;
  final passport;
  final education;

  final workingHrs;

  final location;
  final expectedSalary;
  final totalExperience;
  final launguage;
  final Otp? otp;
  CandidateRegisterOtpScreen(
      {super.key,
      required this.name,
      required this.mobileNo,
      this.email,
      required this.password,
      required this.category,
      required this.maritalStatus,
      required this.age,
      required this.religion,
      required this.gender,
      required this.passport,
      required this.education,
      required this.workingHrs,
      required this.location,
      required this.expectedSalary,
      required this.totalExperience,
      required this.launguage,
      this.otp});

  @override
  State<CandidateRegisterOtpScreen> createState() =>
      _CandidateRegisterOtpScreenState();
}

class _CandidateRegisterOtpScreenState
    extends State<CandidateRegisterOtpScreen> {
  Otp? otp;
  Repositiory repositiory = Repositiory();
  AuthRepository authRepository = AuthRepository();
  EmployerRegisterModel? employerRegisterData;
  AuthRepository? candidateRegisterData;
  @override
  void initState() {
    super.initState();
    // _sendOtp();
  }

  // Future _sendOtp() async {
  //   final otpData =
  //       await authRepository.getEmployerRegisterOtp(widget.mobileNo);

  //   otp = otpData;

  //   // _otpController.value = TextEditingValue(text: otpData?.otp ?? '');
  // }

  Future _registerCandidate() async {
    final postCandidateData = await authRepository.postCandidateFormData(
        widget.name,
        widget.mobileNo,
        widget.email ?? "",
        widget.password,
        widget.category,
        widget.maritalStatus,
        widget.age,
        widget.religion,
        widget.gender,
        widget.passport.toString(),
        widget.education,
        widget.workingHrs,
        widget.location,
        widget.expectedSalary,
        widget.totalExperience,
        widget.launguage.toString());
    setState(() {
      candidateRegisterData = postCandidateData;
    });
  }

  String otpcontroller = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "lib/assets/images/mobile_otp.png",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Verification",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const Text(
              "Enter 4 digit number sent to your registered number",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 6.0),
            //   child: Row(
            //     children: [
            //       Text(
            //         widget.mobileNo.replaceRange(3, 7, "****"),
            //         style: const TextStyle(color: blackColor),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(left: 8.0),
            //         child: GestureDetector(
            //           onTap: () {
            //             Navigator.pop(context);
            //           },
            //           child: const Text(
            //             "Change Phone number?",
            //             style: TextStyle(
            //                 decoration: TextDecoration.underline,
            //                 decorationColor: blueColor,
            //                 color: blueColor),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            OtpTextField(
              fieldHeight: 40,
              numberOfFields: 4,
              showCursor: true,
              keyboardType: TextInputType.number,
              cursorColor: blueColor,
              onSubmit: (value) {
                setState(() {
                  otpcontroller = value;
                });
              },
              // onCodeChanged: (String value) {

              // },
            ),
            sizedBoxH20,
            GestureDetector(
              onTap: () {
                if (widget.otp!.otp == otpcontroller) {
                  _registerCandidate();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Register Successfully")));
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(msg: "Invalid OTP");
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.80,
                    decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                        child: Text(
                      "Confirm",
                      style: TextStyle(color: whiteColor),
                    )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
