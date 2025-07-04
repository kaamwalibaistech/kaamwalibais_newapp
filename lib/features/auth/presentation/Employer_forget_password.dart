import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';

import '../network/auth_repository.dart';
import 'employer_newPassword.dart';

class EmployerForgetPassword extends StatefulWidget {
  const EmployerForgetPassword({super.key});

  @override
  State<EmployerForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<EmployerForgetPassword> {
  String? otp;
  AuthRepository repositiory = AuthRepository();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  bool isVisible = true;
  bool isVisible2 = false;
  // final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Future _sendOtp() async {
    final otpData = await repositiory
        .getEmployerRegisterForgetPasswordOtp(phoneNumberController.text);

    otp = otpData!.otp;

    // _otpController.value = TextEditingValue(text: otpData?.otp ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
      ),
      body: Form(
        // key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              Center(
                child: Image.asset(
                  "lib/assets/images/kaamwalijobs.png",
                  height: 80,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Visibility(
                visible: isVisible,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 200, 197, 197),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ]),
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextFormField(
                          // key: _formKey,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "phone number should be 10 digits!";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            counterText: "",
                            hintText: "Mobile No.",
                            hintStyle: TextStyle(color: textGreyColor),
                          ),
                        ),
                      ),
                      sizedBoxH15,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.010,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (
                              // _formKey.currentState!.validate() &&
                              phoneNumberController.text.isNotEmpty) {
                            _sendOtp();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("OTP Sent Successfully")));
                            setState(() {
                              isVisible = false;
                              isVisible2 = true;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: blueColor,
                              borderRadius: BorderRadius.circular(10)),
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.76,
                          child: const Center(
                              child: Text(
                            "Send OTP",
                            style: TextStyle(color: whiteColor, fontSize: 16),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isVisible2,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 200, 197, 197),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ]),
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          "Reset Password",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.75,
                        decoration: BoxDecoration(
                            border: Border.all(color: blackColor),
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          maxLength: 4,
                          controller: _otpController,
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 2),
                            hintText: "Enter OTP",
                            hintStyle: TextStyle(color: textGreyColor),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      sizedBoxH15,
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.010,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_otpController.text == otp) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmployerNewPassword(
                                        number: phoneNumberController.text)));
                          } else {
                            Fluttertoast.showToast(msg: "Invalid OTP");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: blueColor,
                              borderRadius: BorderRadius.circular(10)),
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.76,
                          child: const Center(
                              child: Text(
                            "Verify OTP",
                            style: TextStyle(color: whiteColor, fontSize: 16),
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
