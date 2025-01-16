import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/Client/homepage_api.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_bloc.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_event.dart';
import 'package:kaamwalijobs_new/features/auth/network/auth_repository.dart';

import '../../../core/local_storage.dart';
import '../../../models/employer_register_model.dart';

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
  String? validateEmail(String? email) {
    RegExp emailRegEx = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegEx.hasMatch(email ?? "");
    if (!isEmailValid) return "please  Enter a valid email";
    return null;
  }

  final _formKey = GlobalKey<FormState>();

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
                  keyboardType: TextInputType.number,
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
                    counterText: "",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    hintText: "Enter Phone Number",
                    hintStyle: TextStyle(color: textGreyColor),
                    border: OutlineInputBorder(),
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
                  keyboardType: TextInputType.number,
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
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      EmployerRegisterModel? localUserProfileData =
                          LocalStoragePref.instance?.getUserProfile();
                      AuthRepository()
                          .updateUserProfile(
                              nameController.text,
                              phoneNoController.text,
                              emailController.text,
                              localUserProfileData!.flag,
                              localUserProfileData.userId)
                          .then((_) {
                        BlocProvider.of<AuthBloc>(context, listen: false).add(
                            AuthenticationEvent(
                                phoneNumber: '',
                                password: '',
                                userType: localUserProfileData.flag == '0'
                                    ? USER.employer
                                    : USER.candidates));
                      });
                      Navigator.pop(context);

                      Fluttertoast.showToast(msg: "Updated Successfully");
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
    );
  }
}
