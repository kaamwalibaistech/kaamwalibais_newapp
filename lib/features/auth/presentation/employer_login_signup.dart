import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaamwalijobs_new/Client/homepage_api.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_bloc.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_state.dart';
import 'package:kaamwalijobs_new/features/auth/presentation/employer_register.dart';

import '../../navigation/presentation/navigationscreen.dart';
import '../bloc/auth_event.dart';
import 'Employer_forget_password.dart';

class EmployerLoginSignup extends StatefulWidget {
  const EmployerLoginSignup({super.key});

  @override
  State<EmployerLoginSignup> createState() => _EmployerLoginSignupState();
}

class _EmployerLoginSignupState extends State<EmployerLoginSignup> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool _obsecureText = true;

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
                  Fluttertoast.showToast(msg: "Invalid Credentials!");
                }
              } else if (state is AuthLoadedState) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Navigationscreen()));
              }
            },
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
                    // height: MediaQuery.of(context).size.height * 0.37,
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            controller: _mobileNoController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter numbers!";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                              border: const OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              counterText: "",
                              hintText: "Mobile No.",
                              hintStyle: TextStyle(color: textGreyColor),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextFormField(
                            obscureText: _obsecureText,
                            controller: _passwordController,
                            validator: (value) {
                              if (value!.isNotEmpty) return null;
                              return "please enter password!";
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obsecureText = !_obsecureText;
                                    });
                                  },
                                  child: _obsecureText
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility)),
                              hintText: "Password",
                              hintStyle: const TextStyle(color: textGreyColor),
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
                                          const EmployerForgetPassword()));
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
                              BlocProvider.of<AuthBloc>(context, listen: false)
                                  .add(AuthenticationEvent(
                                      phoneNumber: _mobileNoController.text,
                                      password: _passwordController.text,
                                      userType: USER.employer));
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
            )),
      ),
    );
  }
}
