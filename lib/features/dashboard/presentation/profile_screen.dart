import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/Client/homepage_api.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/core/local_storage.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_event.dart';
import 'package:kaamwalijobs_new/features/dashboard/presentation/location/bloc/select_location_bloc.dart';
import 'package:kaamwalijobs_new/models/employer_register_model.dart';

import '../../../constant/colors.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_state.dart';
import '../../auth/presentation/login_popup.dart';
import '../../navigation/presentation/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late AuthBloc _authBloc;
  EmployerRegisterModel? userProfileData;
  int count = 0;

  @override
  void initState() {
    super.initState();
    userProfileData = LocalStoragePref.instance?.getUserProfile();

    if (userProfileData == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        checkLoginPopup();
      });
    }

    _authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: userProfileData != null
            ? Text(
                "Profile",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              )
            : const SizedBox.shrink(),
        backgroundColor: scaffoldColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: BlocBuilder<AuthBloc, AuthBlocState>(
            bloc: _authBloc,
            buildWhen: (previous, current) =>
                current is AuthLoadedState ||
                current is AuthLoadFailedState ||
                current is AuthLoadingState,
            builder: (context, state) {
              if (state is AuthLoadedState) {
                return AnimationLimiter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 600),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        verticalOffset: 30.0,
                        child: FadeInAnimation(child: widget),
                      ),
                      children: [
                        // _buildAnimatedHeader(state.userData.name),
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: blueColor.withOpacity(0.1),
                          child: Icon(Icons.person,
                              size: 50, color: blueColor.withOpacity(0.9)),
                        ),
                        sizedBoxH10,
                        _buildAnimatedHeader(state.userData.name),
                        sizedBoxH5,
                        _buildAnimatedHeaderEmail(state.userData.emailId),
                        sizedBoxH20,
                        Card(
                          elevation: 4,
                          shadowColor: Colors.black26,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                _buildInfoRow(
                                    icon: Icons.phone,
                                    label: "Contact",
                                    value: state.userData.mobileNo),
                                const Divider(),
                                BlocBuilder<SelectLocationBloc,
                                    SelectLocationState>(
                                  builder: (context, snapshot) {
                                    String location = "---";
                                    if (snapshot
                                        is SelectLocationSuccessState) {
                                      location = snapshot.currentAddress
                                          .split(",")
                                          .first;
                                    }
                                    return _buildInfoRow(
                                        icon: Icons.location_on,
                                        label: "Location",
                                        value: location);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        sizedBoxH20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 12),
                                backgroundColor: Colors.blue.shade100,
                                foregroundColor: Colors.blue.shade900,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.blue.shade500,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                // elevation: 5,
                              ),
                              icon: const Icon(
                                Icons.edit,
                              ),
                              label: Text(
                                "   Edit Profile",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile()),
                                );
                              },
                            ),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 12),
                                backgroundColor: Colors.red.shade100,
                                foregroundColor: Colors.red.shade900,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.red.shade500,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                // elevation: 5,
                              ),
                              icon: const Icon(
                                Icons.logout,
                              ),
                              label: Text(
                                "Log out",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () async {
                                setState(() => count = 1);
                                await LocalStoragePref.instance!.clearAllPref();
                                BlocProvider.of<AuthBloc>(context,
                                        listen: false)
                                    .add(
                                  AuthenticationEvent(
                                    phoneNumber: '',
                                    password: '',
                                    userType: USER.employer,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        userProfileData?.mobileNo == "8169669043"
                            ? ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 12),
                                  backgroundColor: blueColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 5,
                                ),
                                // icon:
                                //     const Icon(Icons.edit, color: Colors.white),
                                label: Text(
                                  "Delete Account",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, color: Colors.white),
                                ),
                                onPressed: () async {
                                  final confirmed = await showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text('Delete Account?'),
                                      content: Text(
                                        'This action will permanently delete your account and data.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (confirmed) {
                                    await LocalStoragePref.instance!
                                        .clearAllPref();

                                    setState(() => count = 1);
                                    await LocalStoragePref.instance!
                                        .clearAllPref();
                                    BlocProvider.of<AuthBloc>(context,
                                            listen: false)
                                        .add(
                                      AuthenticationEvent(
                                        phoneNumber: '',
                                        password: '',
                                        userType: USER.employer,
                                      ),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          "Your Account has deleted Successfully",
                                        ),
                                      ),
                                    );
                                    await LocalStoragePref.instance!
                                        .temproraryAccDelete();

                                    // await LocalStoragePref.instance!
                                    //     .temproraryAccDelete();
                                    // await deleteUserAccount(); // your API call
                                    // redirect to login or home
                                  }
                                },
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Column(
                    children: [
                      AnimationConfiguration.staggeredList(
                        position: 0,
                        duration: const Duration(milliseconds: 600),
                        child: ScaleAnimation(
                          child: Image.asset(
                            "lib/assets/images/kaamwalijobs.png",
                            cacheHeight: 105,
                          ),
                        ),
                      ),
                      sizedBoxH20,
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Welcome to Kaamwali Jobs',
                            textStyle: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                            speed: const Duration(milliseconds: 80),
                          ),
                        ],
                        totalRepeatCount: 1,
                      ),
                      sizedBoxH10,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Please Login >",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          checkLoginPopup();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // / 🖋️ Animated greeting header
  Widget _buildAnimatedHeader(String name) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          '$name',
          textStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          speed: const Duration(milliseconds: 80),
        ),
      ],
      totalRepeatCount: 1,
      pause: const Duration(milliseconds: 300),
    );
  }

  Widget _buildAnimatedHeaderEmail(String name) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          '$name',
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            // fontWeight: FontWeight.w600,
            // color: Colors.black87,
          ),
          speed: const Duration(milliseconds: 80),
        ),
      ],
      totalRepeatCount: 1,
      pause: const Duration(milliseconds: 300),
    );
  }

  Widget _buildInfoRow(
      {required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: blueColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }

  checkLoginPopup() async {
    showDialog(
      context: context,
      builder: (context) => const Dialog(
        child: LoginPopup(),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
