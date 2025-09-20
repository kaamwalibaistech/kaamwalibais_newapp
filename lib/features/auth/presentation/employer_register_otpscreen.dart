import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/models/employer_register_model.dart';

import '../../../models/empolyer_registerotp_model.dart';
import '../network/auth_repository.dart';

class EmolpyerRegisterOtpscreen extends StatefulWidget {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String password;
  final String confirmPassword;
  final Otp otp;

  const EmolpyerRegisterOtpscreen(
      {super.key,
      required this.fullName,
      required this.phoneNumber,
      required this.email,
      required this.password,
      required this.confirmPassword,
      required this.otp});

  @override
  State<EmolpyerRegisterOtpscreen> createState() =>
      _EmolpyerRegisterOtpscreenState();
}

class _EmolpyerRegisterOtpscreenState extends State<EmolpyerRegisterOtpscreen> {
  EmployerRegisterModel? employerRegisterData;

  // @override
  // void initState() {
  //   super.initState();
  //   _sendOtp();
  // }

  // Future _sendOtp() async {
  //   // _otpController.value = TextEditingValue(text: otpData?.otp ?? '');
  // }

  Future _registerEmployer() async {
    final registerEmployer = await AuthRepository().getEmployerRegister(
        widget.fullName, widget.phoneNumber, widget.email, widget.password);
    setState(() {
      employerRegisterData = registerEmployer;
    });
  }

  // TextEditingController _otpController = TextEditingController();
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              fit: BoxFit.fitHeight,
              "lib/assets/images/mobile_otp.png",
              cacheHeight: 220,
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
            //         widget.phoneNumber.replaceRange(3, 7, "****"),
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
              onTap: () async {
                if (widget.otp.otp == otpcontroller) {
                  await _registerEmployer();
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
