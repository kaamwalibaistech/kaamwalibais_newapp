import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/core/local_storage.dart';
import 'package:kaamwalijobs_new/models/employer_register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    Timer(const Duration(seconds: 1), () async {
      await LocalStoragePref.instance?.initPrefBox();
      EmployerRegisterModel? employerRegisterModel =
          LocalStoragePref.instance?.getUserProfile();
      final pres = await SharedPreferences.getInstance();

      // final onboarding = pres.getBool("onboarrding") ?? false;

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
            MaterialPageRoute(builder: (context) => const Navigationscreen()));
      }
      //  else {
      //   Navigator.pushReplacement(context,
      //       MaterialPageRoute(builder: (context) => const Navigationscreen()));
      // }
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
