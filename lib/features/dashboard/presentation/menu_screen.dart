import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/Client/homepage_api.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_bloc.dart';
import 'package:kaamwalijobs_new/features/auth/presentation/login_popup.dart';
import 'package:kaamwalijobs_new/features/navigation/presentation/packages.dart';
import 'package:kaamwalijobs_new/features/navigation/presentation/term_condition.dart';
import 'package:kaamwalijobs_new/features/navigation/presentation/view_job_posted.dart';
import 'package:kaamwalijobs_new/screens/webview_widget.dart';

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

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    _packageBloc = BlocProvider.of<PurchasedPackageDataBloc>(context);
    _packageBloc.add(PurchasedPackageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: AnimationLimiter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 600),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 40.0,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  // _buildAnimatedHeader(),
                  _buildAuthSection(),
                  _buildPackageInfoSection(),
                  sizedBoxH20,
                  _buildSectionTitle("Main Menu"),
                  sizedBoxH20,
                  _buildMainMenuGrid(),
                  sizedBoxH15,
                  _buildSectionTitle("More Options"),
                  sizedBoxH20,
                  _buildBottomMenuGrid(),
                  sizedBoxH20,
                  _buildTermsAndConditions(),
                  sizedBoxH20,
                  _buildLogoutButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🖋️ Animated Header with Typewriter
  // Widget _buildAnimatedHeader() {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 10.0),
  //     child: Center(
  //       child: AnimatedTextKit(
  //         animatedTexts: [
  //           TypewriterAnimatedText(
  //             'Welcome to Kaamwali Jobs',
  //             textStyle: GoogleFonts.poppins(
  //               fontSize: 22,
  //               fontWeight: FontWeight.w600,
  //               color: Colors.black87,
  //             ),
  //             speed: const Duration(milliseconds: 80),
  //           ),
  //         ],
  //         totalRepeatCount: 1,
  //         pause: const Duration(milliseconds: 500),
  //         displayFullTextOnTap: true,
  //         stopPauseOnTap: true,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade400)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade400)),
      ],
    );
  }

  Widget _buildMenuButton(String iconPath, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Image.asset(
              iconPath,
              height: 35,
              width: 35,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(List<Widget> items) {
    return AnimationLimiter(
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 0.85,
        mainAxisSpacing: 18,
        crossAxisSpacing: 18,
        children: List.generate(
          items.length,
          (index) => AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 400),
            columnCount: 3,
            child: ScaleAnimation(
              child: FadeInAnimation(child: items[index]),
            ),
          ),
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
          return const SizedBox.shrink();
        } else {
          return Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: GestureDetector(
                  onTap: checkLoginPopup,
                  child: const Icon(Icons.person_3_outlined,
                      size: 28, color: scaffoldColor),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
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
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      TextSpan(
                        text: ' Signup',
                        style: GoogleFonts.roboto(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
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
          if (state.currentPackagePlan.package?.isEmpty ?? false) {
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
    final package = state.currentPackagePlan.package!.first;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoCard("lib/assets/images/icons-package.png", "Current Package",
            package.packageName.toString()),
        _buildInfoCard("lib/assets/images/icons-resume.png", "Available Count",
            package.avilableCount.toString()),
        _buildInfoCard("lib/assets/images/icons-calendar.png", "Expire Date",
            package.expDate.toString()),
      ],
    );
  }

  Widget _buildInfoCard(String iconPath, String title, String value) {
    return Column(
      children: [
        Image.asset(iconPath, height: 28),
        sizedBoxH10,
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                    fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: blackColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainMenuGrid() {
    return _buildGrid([
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
    ]);
  }

  Widget _buildBottomMenuGrid() {
    return _buildGrid([
      _buildWebViewButton("lib/assets/images/about.png.png", "About us",
          'About Us', 'https://kaamwalijobs.com/about-us'),
      _buildWebViewButton("lib/assets/images/contact_us.png", "Contact us",
          'Contact Us', 'https://kaamwalijobs.com/contact-us'),
      _buildWebViewButton(
          "lib/assets/images/privacy_policy.png",
          "Privacy & \n Policy",
          'Privacy Policy',
          'https://kaamwalijobs.com/privacy-policy'),
    ]);
  }

  Widget _buildWebViewButton(
      String iconPath, String label, String title, String url) {
    return _buildMenuButton(
      iconPath,
      label,
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebviewWidget(appBarTitle: title, url: url),
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TermsAndConditionsPage()),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Image.asset(
                "lib/assets/images/terms_and_conditions.png",
                height: 35,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Term & \n Conditions",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ],
        ),
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
          return Center(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  "Log Out",
                  style: GoogleFonts.poppins(
                      color: whiteColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  void showNoPlanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('No Job Posting Plan'),
        content: const Text(
            "You don't have a job posting plan. Please purchase one to continue."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 1), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Packages()),
                );
              });
            },
            child: const Text('Purchase'),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  void _handlePostJobNavigation(PackageState state) {
    String postCount = "P";
    final userLogIn = LocalStoragePref().getUserProfile();

    if (userLogIn == null) {
      checkLoginPopup();
      return;
    }

    if (state is PackageLoadedStates) {
      if (state.currentPackagePlan.package?.isEmpty ?? false) {
        showNoPlanDialog(context);
        return;
      }

      final package = state.currentPackagePlan.package!.last;

      if (package.packageType == postCount) {
        final availableCount =
            int.tryParse(package.avilableCount.toString()) ?? 0;
        if (availableCount > 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JobsPost()),
          );
        } else {
          showNoPlanDialog(context);
        }
      } else {
        showNoPlanDialog(context);
      }
    }
  }

  void checkLoginPopup() {
    showDialog(
      context: context,
      builder: (context) => const Dialog(
          backgroundColor: Colors.transparent, child: LoginPopup()),
    );
  }
}
