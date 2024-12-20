import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/Client/homepage_api.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/models/employer_register_model.dart';

import '../../../models/empolyer_registerotp_model.dart';
import '../network/auth_repository.dart';

class CandidateRegisterOtpScreen extends StatefulWidget {
  final String name;
  final mobileNo;
  final password;
  final category;
  final maritalStatus;
  final age;
  final religion;
  final gender;
  final passport;
  final education;
  final timing;
  final workingHrs;
  final address;
  final location;
  final expectedSalary;
  final totalExperience;
  final launguage;
  CandidateRegisterOtpScreen(
      {super.key,
      required this.name,
      required this.mobileNo,
      required this.password,
      required this.category,
      required this.maritalStatus,
      required this.age,
      required this.religion,
      required this.gender,
      required this.passport,
      required this.education,
      required this.timing,
      required this.workingHrs,
      required this.address,
      required this.location,
      required this.expectedSalary,
      required this.totalExperience,
      required this.launguage});

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
    _sendOtp();
  }

  Future _sendOtp() async {
    final otpData = await repositiory.getEmployerRegisterOtp(widget.mobileNo);

    otp = otpData;

    // _otpController.value = TextEditingValue(text: otpData?.otp ?? '');
  }

  Future _registerCandidate() async {
    final postCandidateData = await authRepository.postCandidateFormData(
        widget.name,
        widget.mobileNo,
        widget.password,
        widget.category,
        widget.maritalStatus,
        widget.age,
        widget.religion,
        widget.gender,
        widget.passport.toString(),
        widget.education,
        widget.timing,
        widget.workingHrs,
        widget.address,
        widget.location,
        widget.totalExperience,
        widget.expectedSalary,
        widget.launguage.toString());
    setState(() {
      candidateRegisterData = postCandidateData;
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
                    widget.mobileNo.replaceRange(3, 7, "****"),
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
                await _registerCandidate();

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
