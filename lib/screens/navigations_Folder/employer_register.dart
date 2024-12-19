import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';

import 'employer_register_otpscreen.dart';

class EmployerRegister extends StatefulWidget {
  const EmployerRegister({super.key});

  @override
  State<EmployerRegister> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EmployerRegister> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _obsecureText = true;
  bool _obsecureText2 = true;

  // Otp? otp
  // ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 50),
                child: Image.asset(
                  "lib/assets/images/kaamwalijobs.png",
                  height: 70,
                ),
              ),
            ),
            Container(
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
              height: MediaQuery.of(context).size.height * 0.48,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Employer Register",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      controller: fullNameController,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                        hintText: "Full Name",
                        hintStyle: TextStyle(color: textGreyColor),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                      maxLength: 10,
                      controller: phoneNumberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        counterText: "",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                        hintText: "Mobile No",
                        hintStyle: TextStyle(color: textGreyColor),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                      controller: passwordController,
                      obscureText: _obsecureText,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obsecureText = !_obsecureText;
                              });
                            },
                            child: _obsecureText
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 2),
                        hintText: "Password",
                        hintStyle: const TextStyle(color: textGreyColor),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                      obscureText: _obsecureText2,
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obsecureText2 = !_obsecureText2;
                              });
                            },
                            child: _obsecureText2
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 2),
                        hintText: "Confirm Password",
                        hintStyle: const TextStyle(color: textGreyColor),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (passwordController.text ==
                              confirmPasswordController.text &&
                          phoneNumberController.text.isNotEmpty &&
                          fullNameController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          confirmPasswordController.text.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmolpyerRegisterOtpscreen(
                                      fullName: fullNameController.text,
                                      phoneNumber: phoneNumberController.text,
                                      password: passwordController.text,
                                      confirmPassword:
                                          confirmPasswordController.text,
                                    )));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(10)),
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.77,
                      child: const Center(
                          child: Text(
                        "Register Now ",
                        style: TextStyle(color: whiteColor, fontSize: 16),
                      )),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text("OR"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: blueColor, borderRadius: BorderRadius.circular(10)),
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.85,
                child: const Center(
                    child: Text(
                  "Login",
                  style: TextStyle(color: whiteColor, fontSize: 16),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
