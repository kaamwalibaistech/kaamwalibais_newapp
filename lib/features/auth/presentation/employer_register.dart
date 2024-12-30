import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/features/auth/network/auth_repository.dart';

import '../../../models/empolyer_registerotp_model.dart';
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
  TextEditingController emailController = TextEditingController();
  bool _obsecureText = true;
  bool _obsecureText2 = true;
  var _formKey = GlobalKey<FormState>();

  // Otp? otp
  // ;

  String? validateEmail(String? email) {
    RegExp emailRegEx = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegEx.hasMatch(email ?? "");
    if (!isEmailValid) return "please  Enter a valid email";
    return null;
  }

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
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
                // height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Employer Register",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Full Name";
                          }
                          return null;
                        },
                        controller: fullNameController,
                        decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          hintText: "Full Name",
                          hintStyle: TextStyle(color: textGreyColor),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextFormField(
                        expands: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone Number Should Be 10";
                          }
                          return null;
                        },
                        maxLength: 10,
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          counterText: "",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          hintText: "Mobile No",
                          hintStyle: TextStyle(color: textGreyColor),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextFormField(
                        controller: emailController,
                        validator: validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          hintText: "Enter Email",
                          hintStyle: TextStyle(color: textGreyColor),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Password";
                          }
                          return null;
                        },
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          hintText: "Password",
                          hintStyle: const TextStyle(color: textGreyColor),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Confirm Password";
                          }
                          return null;
                        },
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
                          border: const OutlineInputBorder(),
                          hintText: "Confirm Password",
                          hintStyle: const TextStyle(color: textGreyColor),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate() &&
                            passwordController.text ==
                                confirmPasswordController.text &&
                            phoneNumberController.text.isNotEmpty &&
                            fullNameController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty &&
                            confirmPasswordController.text.isNotEmpty &&
                            emailController.text.isNotEmpty &&
                            passwordController.text ==
                                confirmPasswordController.text) {
                          Otp? otpp = await AuthRepository()
                              .getEmployerRegisterOtp(
                                  phoneNumberController.text);

                          if (otpp != null && otpp.status == '200') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EmolpyerRegisterOtpscreen(
                                          fullName: fullNameController.text,
                                          phoneNumber:
                                              phoneNumberController.text,
                                          password: passwordController.text,
                                          confirmPassword:
                                              confirmPasswordController.text,
                                          email: emailController.text,
                                          otp: otpp,
                                        )));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Mobile Number is Already Registered')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: blueColor,
                              content: Text('Password must be same')));
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
                    ),
                    sizedBoxH15
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
                      color: blueColor,
                      borderRadius: BorderRadius.circular(10)),
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
      ),
    );
  }
}
