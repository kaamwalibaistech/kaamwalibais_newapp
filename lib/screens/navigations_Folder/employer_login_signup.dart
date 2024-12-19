import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/Client/homepage_api.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/core/local_storage.dart';
import 'package:kaamwalijobs_new/screens/navigations_Folder/employer_register.dart';
import 'package:kaamwalijobs_new/screens/navigations_Folder/navigationscreen.dart';

import '../../models/employer_register_model.dart';
import 'forgot_password.dart';

class EmployerLoginSignup extends StatefulWidget {
  const EmployerLoginSignup({super.key});

  @override
  State<EmployerLoginSignup> createState() => _EmployerLoginSignupState();
}

class _EmployerLoginSignupState extends State<EmployerLoginSignup> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final formkey = GlobalKey<FormState>();

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
          key: formkey,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 50),
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
                height: MediaQuery.of(context).size.height * 0.37,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        "Employer Login",
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
                      child: TextFormField(
                        controller: _mobileNoController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter numbers!";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                          hintText: "Mobile No.",
                          hintStyle: TextStyle(color: textGreyColor),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.75,
                      decoration: BoxDecoration(
                          border: Border.all(color: blackColor),
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value!.isNotEmpty) return null;
                          return "please enter password!";
                        },
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                          hintText: "Password",
                          hintStyle: TextStyle(color: textGreyColor),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 180.0, top: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPassword()));
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: blueColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    InkWell(
                      onTap: () async {
                        if (formkey.currentState?.validate() ?? false) {
                          EmployerRegisterModel? employerDetails =
                              await Repositiory().userLogin(
                                  _mobileNoController.text,
                                  _passwordController.text,
                                  USER.employer);

                          if (employerDetails != null) {
                            // store locally
                            LocalStoragePref.instance?.storeUserProfile(
                                jsonEncode(employerDetails.toJson()));

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Navigationscreen()));
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(10)),
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.80,
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text("OR"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EmployerRegister()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(10)),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: const Center(
                      child: Text(
                    "Register",
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
