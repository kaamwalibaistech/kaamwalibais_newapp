import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';

import '../network/auth_repository.dart';

class EmployerNewPassword extends StatefulWidget {
  final number;

  const EmployerNewPassword({super.key, required this.number});

  @override
  State<EmployerNewPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<EmployerNewPassword> {
  bool _obsecureText = true;
  bool _obsecureText2 = true;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  AuthRepository repositiory = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
      ),
      body: Form(
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
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Change Password",
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
                    child: TextFormField(
                      obscureText: _obsecureText,
                      // keyboardType: TextInputType.phone,
                      controller: newPasswordController,
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
                        counterText: "",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                        hintText: "Enter New Password",
                        hintStyle: TextStyle(color: textGreyColor),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  sizedBoxH15,
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
                      // keyboardType: TextInputType.phone,
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
                        counterText: "",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                        hintText: "Confirm New Password",
                        hintStyle: TextStyle(color: textGreyColor),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  sizedBoxH15,
                  GestureDetector(
                    onTap: () {
                      repositiory.getEmployerRegisterNewPassword(
                          widget.number.toString(), newPasswordController.text);
                      if (newPasswordController.text ==
                              confirmPasswordController.text &&
                          newPasswordController.text.isNotEmpty &&
                          confirmPasswordController.text.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Password Change Successfully")));
                        Navigator.pop(context);
                        Navigator.pop(context);
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
                        "Change Password",
                        style: TextStyle(color: whiteColor, fontSize: 16),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
