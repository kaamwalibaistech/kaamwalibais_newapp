import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_bloc.dart';
import 'package:kaamwalijobs_new/features/auth/presentation/login_popup.dart';
import 'package:kaamwalijobs_new/features/navigation/presentation/packages.dart';
import 'package:kaamwalijobs_new/features/navigation/presentation/term_condition.dart';
import 'package:kaamwalijobs_new/features/navigation/presentation/view_job_posted.dart';
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

  void showNoPlanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('No Job Posting Plan'),
        content: Text(
            "You don't have a job posting plan. Please purchase one to continue."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // just dismiss
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // first close the dialog
              Future.delayed(Duration(milliseconds: 1), () {
                // Then navigate after dialog is dismissed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Packages()),
                );
              });
            },
            child: Text('Purchase'),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  void _handlePostJobNavigation(PackageState state) {
    String variable = "P";
    final userLogIn = LocalStoragePref().getUserProfile();

    if (userLogIn == null) {
      checkLoginPopup();
      Fluttertoast.showToast(msg: "Please Login");
      return;
    }

    if (state is PackageLoadedStates) {
      if (state.currentPackagePlan.package.isEmpty) {
        showNoPlanDialog(context);
        return;
      }

      final package = state.currentPackagePlan.package.first;

      // Check if package is expired

      if (package.packageType == variable) {
        final availableCount = int.tryParse(package.avilableCount) ?? 0;
        if (availableCount > 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JobsPost()),
          );
        } else {
          showNoPlanDialog(context);
          // Fluttertoast.showToast(msg: "No More Available counts");
        }
      } else {
        showNoPlanDialog(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
            _buildAuthSection(),
            _buildPackageInfoSection(),
            _buildMenuDivider(),
            _buildMainMenuGrid(),
            _buildBottomMenuGrid(),
            _buildTermsAndConditions(),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthSection() {
    return BlocBuilder(
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
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.13,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(50)),
                          child: GestureDetector(
                            onTap: checkLoginPopup,
                            child: const Icon(
                              Icons.person_3_outlined,
                              size: 28,
                              color: scaffoldColor,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: GestureDetector(
                          onTap: checkLoginPopup,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Login ',
                                  style: GoogleFonts.roboto(fontSize: 18),
                                ),
                                const TextSpan(
                                  text: '/',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                TextSpan(
                                  text: ' Signup',
                                  style: GoogleFonts.roboto(fontSize: 18),
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
    );
  }

  Widget _buildPackageInfoSection() {
    if (count != 0) return const SizedBox.shrink();

    return BlocBuilder<PurchasedPackageDataBloc, PackageState>(
      bloc: _packageBloc,
      buildWhen: (PackageState previous, PackageState current) =>
          current is PackageLoadedStates,
      builder: (context, state) {
        if (state is PackageLoadedStates) {
          if (state.currentPackagePlan.package.isEmpty) {
            return const SizedBox.shrink();
          } else {
            return _buildPackageInfoCards(state);
          }
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPackageInfoCards(PackageLoadedStates state) {
    final package = state.currentPackagePlan.package.first;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoCard(
          "lib/assets/images/icons-package.png",
          "Current Package",
          package.packageName,
        ),
        _buildInfoCard(
          "lib/assets/images/icons-resume.png",
          "Available Count",
          package.avilableCount.toString(),
        ),
        _buildInfoCard(
          "lib/assets/images/icons-calendar.png",
          "Expire Date",
          package.expDate.toString(),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String iconPath, String title, String value) {
    return Column(
      children: [
        Image.asset(iconPath, height: 30),
        sizedBoxH10,
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.25,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuDivider() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        children: <Widget>[
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Menu",
              style: GoogleFonts.poltawskiNowy(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }

  Widget _buildMainMenuGrid() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMenuButton(
            "lib/assets/images/packages.png",
            "Packages",
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Packages()),
            ),
          ),
          BlocBuilder<PurchasedPackageDataBloc, PackageState>(
            bloc: _packageBloc,
            buildWhen: (PackageState previous, PackageState current) =>
                current is PackageLoadedStates,
            builder: (context, state) {
              return _buildMenuButton(
                "lib/assets/images/become_an_agent.png",
                "Post Jobs",
                () => _handlePostJobNavigation(state),
              );
            },
          ),
          _buildMenuButton(
            "lib/assets/images/my_jobs.png.png",
            "My Jobs",
            () {
              final user = LocalStoragePref().getUserProfile();
              if (user == null) {
                checkLoginPopup();
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewJobPosted()),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(String iconPath, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 0.25,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(
              iconPath,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomMenuGrid() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildWebViewButton(
            "lib/assets/images/about.png.png",
            "About us",
            'About Us',
            'https://kaamwalijobs.com/about-us',
          ),
          _buildWebViewButton(
            "lib/assets/images/contact_us.png",
            "Contact us",
            'Contact Us',
            'https://kaamwalijobs.com/contact-us',
          ),
          _buildWebViewButton(
            "lib/assets/images/privacy_policy.png",
            "Privacy & \n Policy",
            'Privacy Policy',
            'https://kaamwalijobs.com/privacy-policy',
          ),
        ],
      ),
    );
  }

  Widget _buildWebViewButton(
      String iconPath, String label, String title, String url) {
    return _buildMenuButton(
      iconPath,
      label,
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebviewWidget(
            appBarTitle: title,
            url: url,
          ),
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TermsAndConditionsPage()),
      ),
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
                borderRadius: BorderRadius.circular(10),
              ),
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
    );
  }

  Widget _buildLogoutButton() {
    return BlocBuilder(
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
                setState(() => count = 1);
                await LocalStoragePref.instance!.clearAllPref();
                BlocProvider.of<AuthBloc>(context, listen: false).add(
                  AuthenticationEvent(
                    phoneNumber: '',
                    password: '',
                    userType: USER.employer,
                  ),
                );
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
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  void checkLoginPopup() {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(content: LoginPopup()),
    );
  }
}
