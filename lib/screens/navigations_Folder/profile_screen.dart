import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../assets/colors.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/bloc/auth_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AuthBloc _authBloc;
  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        title: Image.asset(
          "lib/assets/images/kaamwalijobs.png",
          cacheHeight: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: BlocBuilder(
              bloc: _authBloc,
              buildWhen: (previous, current) =>
                  current is AuthLoadedState ||
                  current is AuthLoadFailedState ||
                  current is AuthLoadingState,
              builder: (context, state) {
                if (state is AuthLoadedState) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Text(
                        "Personal Details",
                        style: GoogleFonts.poltawskiNowy(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: whiteColor,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 200, 197, 197),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Name",
                                      style: GoogleFonts.poltawskiNowy(),
                                    ),
                                    Text(
                                      state.userData.name ?? "----",
                                      style: GoogleFonts.poltawskiNowy(),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Contact",
                                      style: GoogleFonts.poltawskiNowy(),
                                    ),
                                    Text(
                                      state.userData.mobileNo ?? "----",
                                      style: GoogleFonts.poltawskiNowy(),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Location",
                                      style: GoogleFonts.poltawskiNowy(),
                                    ),
                                    Text(
                                      "----",
                                      style: GoogleFonts.poltawskiNowy(),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Email",
                                      style: GoogleFonts.poltawskiNowy(),
                                    ),
                                    Text(
                                      state.userData.emailId ?? "",
                                      style: GoogleFonts.poltawskiNowy(),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.042,
                                width: MediaQuery.of(context).size.width * 0.28,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: blueColor)),
                                child: Center(
                                  child: Text(
                                    "Edit profile",
                                    style: GoogleFonts.poltawskiNowy(
                                        color: blueColor),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return SizedBox.shrink();
              }),
        ),
      ),
    );
  }
}
