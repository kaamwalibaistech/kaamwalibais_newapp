import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/models/employer_register_model.dart';

import '../../../models/empolyer_registerotp_model.dart';
import '../network/auth_repository.dart';

class EmolpyerRegisterOtpscreen extends StatefulWidget {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String password;
  final String confirmPassword;

  const EmolpyerRegisterOtpscreen({
    super.key,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  State<EmolpyerRegisterOtpscreen> createState() =>
      _EmolpyerRegisterOtpscreenState();
}

class _EmolpyerRegisterOtpscreenState extends State<EmolpyerRegisterOtpscreen> {
  Otp? otp;
  AuthRepository authRepositiory = AuthRepository();
  EmployerRegisterModel? employerRegisterData;

  @override
  void initState() {
    super.initState();
    _sendOtp();
  }

  Future _sendOtp() async {
    final otpData =
        await authRepositiory.getEmployerRegisterOtp(widget.phoneNumber);

    otp = otpData;

    // _otpController.value = TextEditingValue(text: otpData?.otp ?? '');
  }

  Future _registerEmployer() async {
    final registerEmployer = await authRepositiory.getEmployerRegister(
        widget.fullName, widget.phoneNumber, widget.email, widget.password);
    setState(() {
      employerRegisterData = registerEmployer;
    });
  }

  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    widget.phoneNumber.replaceRange(3, 7, "****"),
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: TextFormField(
                  maxLength: 4,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      counterText: "",
                      hintText: " -     -      -      -      -      -",
                      hintStyle: TextStyle(color: textGreyColor)),
                  controller: _otpController,
                )),
            GestureDetector(
              onTap: () async {
                await _registerEmployer();
                if (otp!.otp == _otpController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Register Successfully")));
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Invalid OTP")));
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.50,
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
