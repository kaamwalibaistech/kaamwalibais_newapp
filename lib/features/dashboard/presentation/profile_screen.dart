import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/core/local_storage.dart';
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: blueColor.withOpacity(0.1),
                      child: Icon(Icons.person,
                          size: 50, color: blueColor.withOpacity(0.9)),
                    ),
                    sizedBoxH10,
                    Text(
                      state.userData.name,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    sizedBoxH5,
                    Text(
                      state.userData.emailId,
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.grey[600]),
                    ),
                    sizedBoxH20,
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
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
                                if (snapshot is SelectLocationSuccessState) {
                                  location =
                                      snapshot.currentAddress.split(",").first;
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
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 12),
                        backgroundColor: blueColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: Text(
                        "Edit Profile",
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()),
                        );
                      },
                    )
                  ],
                );
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "lib/assets/images/kaamwalijobs.png",
                        cacheHeight: 105,
                      ),
                      sizedBoxH20,
                      Text(
                        "Kaamwalijobs",
                        style: const TextStyle(fontSize: 22),
                      ),
                      sizedBoxH5,
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
