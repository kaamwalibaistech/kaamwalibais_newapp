import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/features/auth/presentation/candidate_register.dart';

import '../../../Client/homepage_api.dart';
import '../../navigation/presentation/navigationscreen.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class CandidateLoginSignup extends StatefulWidget {
  const CandidateLoginSignup({super.key});

  @override
  State<CandidateLoginSignup> createState() => _CandidateLoginSignupState();
}

class _CandidateLoginSignupState extends State<CandidateLoginSignup> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
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
        child: BlocListener<AuthBloc, AuthBlocState>(
            listenWhen: (previous, current) =>
                current is AuthLoadFailedState || current is AuthLoadedState,
            listener: (context, state) {
              if (state is AuthLoadFailedState) {
                if (state.userfailed == USERFAILED.unregister) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("incorrect credentials")));
                }
              }
              if (state is AuthLoadedState) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Navigationscreen()),
                  (Route<dynamic> route) => false,
                );
              }
            },
            child: Form(
              key: _formKey,
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
                    height: MediaQuery.of(context).size.height * 0.42,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            "Candidate Login",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Phone Number should be 10 in digits";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            controller: phoneNumberController,
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              hintText: "Mobile No.",
                              hintStyle: TextStyle(color: textGreyColor),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter password";
                              }
                              return null;
                            },
                            obscureText: obscureText,
                            controller: passwordController,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  child: obscureText
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              hintText: "Password",
                              hintStyle: TextStyle(color: textGreyColor),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(left: 180.0, top: 5),
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   const CandidateForgotPassword()));
                        //     },
                        //     child: Text(
                        //       "Forgot Password?",
                        //       style: TextStyle(color: blueColor),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<AuthBloc>(context, listen: false)
                                  .add(AuthenticationEvent(
                                      phoneNumber: phoneNumberController.text,
                                      password: passwordController.text,
                                      userType: USER.candidates));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: blueColor,
                                borderRadius: BorderRadius.circular(10)),
                            height: MediaQuery.of(context).size.height * 0.06,
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: const Center(
                                child: Text(
                              "Login",
                              style: TextStyle(color: whiteColor, fontSize: 16),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CandidateRegister()));
                          },
                          child: const Text(
                            "रजिस्टर करने के लिए यहां क्लिक करें",
                            style: TextStyle(
                              fontSize: 15,
                              color: blueColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
