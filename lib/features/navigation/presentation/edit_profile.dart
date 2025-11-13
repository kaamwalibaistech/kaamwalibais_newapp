import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_bloc.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_event.dart';
import 'package:kaamwalijobs_new/features/auth/network/auth_repository.dart';

import '../../../core/local_storage.dart';
import '../../../models/empolyer_registerotp_model.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isVisible = false;
  Otp? otpData;

  String? validateEmail(String? email) {
    final emailRegEx = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    if (email == null || email.isEmpty) return "Please enter email";
    if (!emailRegEx.hasMatch(email)) return "Please enter a valid email";
    return null;
  }

  @override
  void initState() {
    super.initState();
    final profile = LocalStoragePref.instance?.getUserProfile();
    if (profile != null) {
      nameController.text = profile.name;
      phoneNoController.text = profile.mobileNo;
      emailController.text = profile.emailId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: scaffoldColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Edit Profile",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: AnimationLimiter(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 500),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    _buildLabel("Name *"),
                    _buildTextField(
                      controller: nameController,
                      hint: "Enter your name",
                      validator: (value) =>
                          value!.isEmpty ? "Please enter name" : null,
                    ),
                    sizedBoxH20,
                    _buildLabel("Phone Number *"),
                    _buildTextField(
                      controller: phoneNoController,
                      hint: "Enter phone number",
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter phone number";
                        }
                        if (value.length != 10) {
                          return "Phone number should be 10 digits";
                        }
                        return null;
                      },
                      suffix: GestureDetector(
                        onTap: () async {
                          if (phoneNoController.text.length == 10) {
                            try {
                              final otpResponse =
                                  await AuthRepository().getEmployerRegisterOtp(
                                phoneNoController.text,
                              );
                              setState(() {
                                otpData = otpResponse;
                                isVisible = true;
                              });
                              Fluttertoast.showToast(
                                  msg: "OTP sent successfully");
                            } catch (e) {
                              Fluttertoast.showToast(msg: "Failed to send OTP");
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Phone number should be 10 digits");
                          }
                        },
                        child: Text(
                          "Get OTP",
                          style: GoogleFonts.poppins(
                            color: blueColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    sizedBoxH10,
                    if (isVisible) ...[
                      _buildLabel("OTP *"),
                      _buildTextField(
                        controller: otpController,
                        hint: "Enter OTP",
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter OTP";
                          }
                          if (value.length < 4) return "Invalid OTP";
                          return null;
                        },
                      ),
                      sizedBoxH20,
                    ],
                    _buildLabel("Email Address *"),
                    _buildTextField(
                      controller: emailController,
                      hint: "Enter email address",
                      keyboardType: TextInputType.emailAddress,
                      validator: validateEmail,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 48,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.save, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blueColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 3,
                          ),
                          onPressed: _updateProfile,
                          label: Text(
                            "Update Profile",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    if (isVisible &&
        (otpData == null || otpController.text != otpData!.otp.toString())) {
      Fluttertoast.showToast(msg: "Please enter valid OTP");
      return;
    }

    try {
      final localUserProfileData = LocalStoragePref.instance?.getUserProfile();
      if (localUserProfileData == null) {
        Fluttertoast.showToast(msg: "User data not found");
        return;
      }

      await AuthRepository().updateUserProfile(
        nameController.text,
        phoneNoController.text,
        emailController.text,
        localUserProfileData.flag,
        localUserProfileData.userId,
      );

      BlocProvider.of<AuthBloc>(context, listen: false).add(
        GetUserProfile(
          userId: localUserProfileData.userId,
          flag: localUserProfileData.flag,
        ),
      );

      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Profile Updated Successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Widget _buildLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      );

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int? maxLength,
    Widget? suffix,
  }) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        maxLength: maxLength,
        style: GoogleFonts.poppins(fontSize: 14),
        decoration: InputDecoration(
          suffix: suffix,
          counterText: "",
          hintText: hint,
          hintStyle: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 14),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: blueColor, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
