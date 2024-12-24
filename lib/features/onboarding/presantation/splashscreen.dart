import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/core/local_storage.dart';
import 'package:kaamwalijobs_new/features/onboarding/presantation/onboarding_view.dart';
import 'package:kaamwalijobs_new/models/employer_register_model.dart';

import '../../../Client/homepage_api.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../navigation/presentation/navigationscreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({
    super.key,
  });
  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    // final prefs =await SharedPreferences.getInstance();
    // final onboarding = prefs.getBool("onboarding")??false;
    Timer(const Duration(seconds: 1), () {
      EmployerRegisterModel? employerRegisterModel =
          LocalStoragePref.instance?.getUserProfile();
      if (employerRegisterModel != null) {
        BlocProvider.of<AuthBloc>(context, listen: false).add(
            AuthenticationEvent(
                password: '',
                phoneNumber: employerRegisterModel.mobileNo,
                userType: USER.employer));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Navigationscreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const OnboardingView()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            "lib/assets/images/kaamwalijobs.png",
            height: 80,
          )),
        ],
      ),
    );
  }
}
