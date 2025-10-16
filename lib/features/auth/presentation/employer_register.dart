import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
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
  Otp? otpp;

  String? validateEmail(String? email) {
    RegExp emailRegEx = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegEx.hasMatch(email ?? "");
    if (!isEmailValid) return "Please enter a valid email";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Logo
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Image.asset(
                    "lib/assets/images/kaamwalijobs.png",
                    height: 70,
                  ),
                ),
              ),

              // Registration Form Card
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                shadowColor: Colors.grey.shade300,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Employer Register",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5),
                        ),
                        const SizedBox(height: 20),

                        // Full Name
                        _buildTextField(fullNameController, "Full Name",
                            validator: (value) {
                          if (value!.isEmpty) return "Enter Full Name";
                          return null;
                        }),

                        const SizedBox(height: 15),

                        // Mobile
                        _buildTextField(phoneNumberController, "Mobile No",
                            keyboardType: TextInputType.number,
                            maxLength: 10, validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter phone number";
                          } else if (value.length != 10) {
                            return "Phone number must be 10 digits";
                          }
                          return null;
                        }),

                        const SizedBox(height: 15),

                        // Email
                        _buildTextField(emailController, "Email",
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail),

                        const SizedBox(height: 15),

                        // Password
                        _buildPasswordField(
                            passwordController, "Password", _obsecureText, () {
                          setState(() => _obsecureText = !_obsecureText);
                        }),

                        const SizedBox(height: 15),

                        // Confirm Password
                        _buildPasswordField(confirmPasswordController,
                            "Confirm Password", _obsecureText2, () {
                          setState(() => _obsecureText2 = !_obsecureText2);
                        }),

                        const SizedBox(height: 25),

                        // Register Button
                        _buildButton("Register Now", width * 0.8, () async {
                          if (_formKey.currentState!.validate()) {
                            if (passwordController.text ==
                                confirmPasswordController.text) {
                              try {
                                EasyLoading.show();

                                otpp = await AuthRepository()
                                    .getEmployerRegisterOtp(
                                        phoneNumberController.text);

                                if (otpp != null && otpp!.status == '200') {
                                  EasyLoading.dismiss();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EmolpyerRegisterOtpscreen(
                                        fullName: fullNameController.text,
                                        phoneNumber: phoneNumberController.text,
                                        password: passwordController.text,
                                        confirmPassword:
                                            confirmPasswordController.text,
                                        email: emailController.text,
                                        otp: otpp!,
                                      ),
                                    ),
                                  );
                                } else {
                                  EasyLoading.dismiss();
                                  _showSnackBar(otpp?.msg ??
                                      "Something went wrong, please try again.");
                                }
                              } catch (e) {
                                EasyLoading.dismiss();
                                _showSnackBar("Error: ${e.toString()}");
                              }
                            } else {
                              EasyLoading.dismiss();
                              _showSnackBar('Passwords must be the same');
                            }
                          }
                        })
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),
              const Text("OR",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 20),

              // Login Button
              _buildButton("Login", width * 0.85, () {
                Navigator.pop(context);
              },
                  color: Colors.white,
                  textColor: blueColor,
                  border: Border.all(color: blueColor)),

              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  // Text Field Builder
  Widget _buildTextField(TextEditingController controller, String hint,
      {int? maxLength,
      TextInputType? keyboardType,
      String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        counterText: "",
        hintText: hint,
        hintStyle: const TextStyle(color: textGreyColor),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
    );
  }

  // Password Field Builder
  Widget _buildPasswordField(TextEditingController controller, String hint,
      bool obscureText, VoidCallback toggleVisibility) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (value) {
        if (value!.isEmpty) return "Enter $hint";
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey.shade100,
        suffixIcon: GestureDetector(
          onTap: toggleVisibility,
          child: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }

  // Button Builder
  Widget _buildButton(String text, double width, VoidCallback onTap,
      {Color color = blueColor, Color textColor = whiteColor, Border? border}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: border,
          boxShadow: color == blueColor
              ? [
                  BoxShadow(
                      color: Colors.blue.shade200,
                      blurRadius: 6,
                      offset: const Offset(0, 3))
                ]
              : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // SnackBar Helper
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
                child: Text(message, style: const TextStyle(fontSize: 16))),
          ],
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
