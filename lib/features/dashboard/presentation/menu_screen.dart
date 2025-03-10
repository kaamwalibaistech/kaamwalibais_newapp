import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_bloc.dart';
import 'package:kaamwalijobs_new/features/auth/presentation/login_popup.dart';
import 'package:kaamwalijobs_new/features/navigation/presentation/packages.dart';
import 'package:kaamwalijobs_new/screens/webview_widget.dart';

import '../../../Client/homepage_api.dart';
import '../../../core/local_storage.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';
import '../../jobs/presentation/jobs_post.dart';
import '../../navigation/bloc/packages.state.dart';
import '../../navigation/bloc/packages_bloc.dart';
import '../../navigation/bloc/packages_event.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late AuthBloc _authBloc;
  late PurchasedPackageDataBloc _packageBloc;
  int count = 0;
  // CurrentPackagePlan? currentPackagePlan;
  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    _packageBloc = BlocProvider.of<PurchasedPackageDataBloc>(context);

    _packageBloc.add(PurchasedPackageEvent());

    // test();
  }

  // test() async {
  //   LocalStoragePref localStoragePref = LocalStoragePref();
  //   String userId = localStoragePref.getUserProfile()!.userId;
  //   CurrentPackagePlan currentPackagePlan =
  //       await Repositiory().getCurrentPackages(userId);
  //   localStoragePref
  //       .storeCurrentPackage(jsonEncode(currentPackagePlan.toJson()));
  // }

  @override
  Widget build(BuildContext context) {
    String variable = "P";
    // LocalStoragePref localStoragePref = LocalStoragePref();

    // CurrentPackagePlan? planData = localStoragePref.currentPackageData();

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.asset(
            //   "lib/assets/images/kaamwalijobs.png",
            //   height: 50,
            // ),
            BlocBuilder(
              bloc: _authBloc,
              buildWhen: (previous, current) =>
                  current is AuthLoadedState ||
                  current is AuthLoadFailedState ||
                  current is AuthLoadingState,
              builder: (context, state) {
                if (state is AuthLoadedState) {
                  return const SizedBox(
                    height: 60.0,
                  );
                } else
                  return Column(
                    children: [
                      ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Row(
                            children: [
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.13,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: GestureDetector(
                                    onTap: () {
                                      checkLoginPopup();
                                    },
                                    child: const Icon(
                                      Icons.person_3_outlined,
                                      size: 28,
                                      color: scaffoldColor,
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    checkLoginPopup();
                                  },
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Login ',
                                          style:
                                              GoogleFonts.roboto(fontSize: 18),
                                        ),
                                        const TextSpan(
                                          text: '/',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        TextSpan(
                                          text: ' Signup',
                                          style:
                                              GoogleFonts.roboto(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // const Padding(
                        //   padding: EdgeInsets.only(top: 10.0, bottom: 10),
                        //   child: Divider(
                        //     thickness: 2,
                        //   ),
                        // ),
                      ],
                    ],
                  );
              },
            ),

// if(count>0){
//   api call count --

//   if sucessfull

//   event new count data+
// }

            count == 0
                ? BlocBuilder<PurchasedPackageDataBloc, PackageState>(
                    bloc: _packageBloc,
                    buildWhen: (PackageState previous, PackageState current) =>
                        current is PackageLoadedStates,
                    builder: (context, state) {
                      if (state is PackageLoadedStates) {
                        if (state.currentPackagePlan.package.isEmpty) {
                          return SizedBox.shrink();
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    "lib/assets/images/icons-package.png",
                                    height: 30,
                                  ),
                                  sizedBoxH5,
                                  Container(
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              "Current Packge",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              state.currentPackagePlan.package
                                                  .first.packageName,
                                              style: TextStyle(
                                                  color: blackColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "lib/assets/images/icons-resume.png",
                                    height: 30,
                                  ),
                                  sizedBoxH10,
                                  Container(
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              "Available Count",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              state.currentPackagePlan.package
                                                  .first.avilableCount
                                                  .toString(),
                                              style: TextStyle(
                                                  color: blackColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "lib/assets/images/icons-calendar.png",
                                    height: 30,
                                  ),
                                  sizedBoxH10,
                                  Container(
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Expire Date",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            state.currentPackagePlan.package
                                                .first.expDate
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ],
                          );
                        }
                      }
                      return SizedBox.shrink();
                    })
                : SizedBox.shrink(),
            sizedBoxH15,
            Row(children: <Widget>[
              Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Menu",
                  style: GoogleFonts.poltawskiNowy(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Expanded(child: Divider()),
            ]),

            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Packages()));
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            "lib/assets/images/packages.png",
                            color: Colors.grey,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Packages",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  BlocBuilder<PurchasedPackageDataBloc, PackageState>(
                      bloc: _packageBloc,
                      buildWhen:
                          (PackageState previous, PackageState current) =>
                              current is PackageLoadedStates,
                      builder: (context, state) {
                        return GestureDetector(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  final userLogIn =
                                      LocalStoragePref().getUserProfile();
                                  if (state is PackageLoadedStates) {
                                    if (userLogIn != null) {
                                      if (state.currentPackagePlan.package
                                          .isNotEmpty) {
                                        if (state.currentPackagePlan.package[0]
                                                .packageType ==
                                            variable) {
                                          int count = int.parse(state
                                              .currentPackagePlan
                                              .package[0]
                                              .avilableCount);
                                          if (count > 0) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        JobsPost()));
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "No More Availabe counts");
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Buy Job Posting Plan");
                                        }
                                      }
                                      ;
                                    } else {
                                      checkLoginPopup();
                                      Fluttertoast.showToast(
                                          msg: "Please LogIn ");
                                    }
                                  } else {
                                    checkLoginPopup();
                                    Fluttertoast.showToast(
                                        msg: "Please LogIn ");
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.asset(
                                    "lib/assets/images/become_an_agent.png",
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "Post Jobs",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                  GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(msg: "Not Posted Any Job !");
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            "lib/assets/images/my_jobs.png.png",
                            color: Colors.grey,
                            height: 10,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            "My Jobs",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WebviewWidget(
                                    appBarTitle: 'About Us',
                                    url: 'https://kaamwalijobs.com/about-us',
                                  )));
                    },
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.25,
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              "lib/assets/images/about.png.png",
                              color: Colors.grey,
                            )),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            "About us",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WebviewWidget(
                                    appBarTitle: 'Contact Us',
                                    url: 'https://kaamwalijobs.com/contact-us',
                                  )));
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            "lib/assets/images/contact_us.png",
                            color: Colors.grey,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Contact us",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WebviewWidget(
                                    appBarTitle: 'Privacy Policy',
                                    url:
                                        'https://kaamwalijobs.com/privacy-policy',
                                  )));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const PrivacyPolicy()));
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            "lib/assets/images/privacy_policy.png",
                            color: Colors.grey,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Privacy & \n Policy",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WebviewWidget(
                              appBarTitle: 'Terms & Conditions',
                              url: 'https://kaamwalijobs.com/terms-condition',
                            )));
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const TermCondition()));
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        "lib/assets/images/terms_and_conditions.png",
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Term & \n Conditions",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            BlocBuilder(
                bloc: _authBloc,
                buildWhen: (previous, current) =>
                    current is AuthLoadedState ||
                    current is AuthLoadFailedState ||
                    current is AuthLoadingState,
                builder: (context, state) {
                  if (state is AuthLoadedState) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              count = 1;
                            });
                            await LocalStoragePref.instance!.clearAllPref();
                            BlocProvider.of<AuthBloc>(context, listen: false)
                                .add(AuthenticationEvent(
                                    phoneNumber: '',
                                    password: '',
                                    userType: USER.employer));
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.25,
                              decoration: const BoxDecoration(color: blueColor),
                              child: const Center(
                                child: Text(
                                  "Log Out",
                                  style: TextStyle(color: whiteColor),
                                ),
                              )),
                        ));
                  }
                  return SizedBox();
                }),
          ],
        ),
      ),
    );
  }

  checkLoginPopup() async {
    // String isLogin = await LocalStoragePref.instance?.isLogin() ?? 'false';
    // if (!(bool.tryParse(isLogin) ?? false)) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(content: LoginPopup()));
    // }
  }
}
