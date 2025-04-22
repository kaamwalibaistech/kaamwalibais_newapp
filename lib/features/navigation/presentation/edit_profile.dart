import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_bloc.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_event.dart';
import 'package:kaamwalijobs_new/features/auth/network/auth_repository.dart';

import '../../../core/local_storage.dart';
import '../../../models/employer_register_model.dart';
import '../../../models/empolyer_registerotp_model.dart';

class EditProfile extends StatefulWidget {
  EditProfile({
    super.key,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isVisible = false;
  String? validateEmail(String? email) {
    RegExp emailRegEx = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegEx.hasMatch(email ?? "");
    if (!isEmailValid) return "please  Enter a valid email";
    return null;
  }

  final _formKey = GlobalKey<FormState>();
  Otp? otpdata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name *",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                sizedBoxH10,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Name";
                      }
                      return null;
                    },

                    // maxLength: 10,
                    controller: nameController,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      hintText: "Enter your name",
                      hintStyle: TextStyle(color: textGreyColor),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                sizedBoxH10,
                Text(
                  "Phone Number *",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                sizedBoxH10,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.length < 10) {
                        return "Phone Number Should be 10 Digits";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: phoneNoController,
                    decoration: InputDecoration(
                      suffix: GestureDetector(
                          onTap: () async {
                            if (phoneNoController.text.length == 10) {
                              Otp? otpp = await AuthRepository()
                                  .getEmployerRegisterOtp(
                                      phoneNoController.text);
                              setState(() {
                                otpdata = otpp;
                                isVisible = true;
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Phone Number Should be 10 digits");
                            }
                          },
                          child: Text(
                            "Get OTP",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )),
                      counterText: "",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      hintText: "Enter Phone Number",
                      hintStyle: TextStyle(color: textGreyColor),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                // sizedBoxH10,
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Visibility(
                    visible: isVisible,
                    child: Text(
                      "OTP*",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // sizedBoxH10,
                Visibility(
                  visible: isVisible,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.length < 4) {
                          return "Enter OTP";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      controller: otpController,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        hintText: "Enter OTP",
                        hintStyle: TextStyle(color: textGreyColor),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                sizedBoxH10,
                Text(
                  "Email Address *",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                sizedBoxH10,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    validator: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    // maxLength: 10,
                    controller: emailController,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      hintText: "Enter Email Address",
                      hintStyle: TextStyle(color: textGreyColor),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate() &&
                          otpController.text == otpdata!.otp.toString()) {
                        try {
                          EmployerRegisterModel? localUserProfileData =
                              LocalStoragePref.instance?.getUserProfile();
                          await AuthRepository()
                              .updateUserProfile(
                                  nameController.text,
                                  phoneNoController.text,
                                  emailController.text,
                                  localUserProfileData!.flag,
                                  localUserProfileData.userId)
                              .then((_) {
                            BlocProvider.of<AuthBloc>(context, listen: false)
                                .add(GetUserProfile(
                                    userId: localUserProfileData.userId,
                                    flag: localUserProfileData.flag));
                          });

                          Navigator.pop(context);

                          Fluttertoast.showToast(msg: "Updated Successfully");
                        } catch (e) {
                          Fluttertoast.showToast(
                              msg: "Mobile Number is Already Existed");
                        }
                      } else {
                        Fluttertoast.showToast(msg: "Please Enter Valid OTP");
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.40,
                      decoration: BoxDecoration(color: blueColor),
                      child: Center(
                        child: Text(
                          "Update Profile",
                          style: GoogleFonts.poltawskiNowy(
                              color: whiteColor, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
