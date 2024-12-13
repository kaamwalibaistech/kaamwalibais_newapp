import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/Client/homepage_api.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';

import '../../models/empolyer_register_modelotp.dart';

class EmolpyerRegisterOtpscreen extends StatefulWidget {
  final String fullName;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  const EmolpyerRegisterOtpscreen(
      {super.key,
      required this.fullName,
      required this.phoneNumber,
      required this.password,
      required this.confirmPassword});

  @override
  State<EmolpyerRegisterOtpscreen> createState() =>
      _EmolpyerRegisterOtpscreenState();
}

class _EmolpyerRegisterOtpscreenState extends State<EmolpyerRegisterOtpscreen> {
  Otp? otpp;
  @override
  void initState() {
    super.initState();
    _sendOtp();
  }

  Future _sendOtp() async {
    final otp = await Repositiory().getEmployerRegisterOtp(widget.phoneNumber);
    setState(() {
      otpp = otp;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Verification code",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Text(
              "We have send the Verification code to",
              style: TextStyle(fontSize: 13, color: textGreyColor),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Row(
                children: [
                  Text(
                    widget.phoneNumber,
                    style: const TextStyle(color: blackColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Change Phone number?",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: blueColor,
                            color: blueColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: TextFormField(
                  controller: otpController,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.50,
                  decoration: BoxDecoration(
                      color: blueColor, borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                      child: Text(
                    "Confirm",
                    style: TextStyle(color: whiteColor),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
