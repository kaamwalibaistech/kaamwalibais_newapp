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
  EditProfile({super.key});

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
    if (!isEmailValid) return "Please enter a valid email";
    return null;
  }

  final _formKey = GlobalKey<FormState>();
  Otp? otpdata;

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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    if (value!.length < 10) {
                      return "Phone number should be 10 digits";
                    }
                    return null;
                  },
                  suffix: GestureDetector(
                    onTap: () async {
                      if (phoneNoController.text.length == 10) {
                        Otp? otpp = await AuthRepository()
                            .getEmployerRegisterOtp(phoneNoController.text);
                        setState(() {
                          otpdata = otpp;
                          isVisible = true;
                        });
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
                    validator: (value) =>
                        value!.length < 4 ? "Enter OTP" : null,
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blueColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      onPressed: () async {
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
                                msg: "Mobile number already exists");
                          }
                        } else {
                          Fluttertoast.showToast(msg: "Please enter valid OTP");
                        }
                      },
                      child: Text(
                        "Update Profile",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Custom Label
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: GoogleFonts.poppins(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
      ),
    );
  }

  /// Custom TextField
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
