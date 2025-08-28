import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:kaamwalijobs_new/bloc/homepage_bloc.dart';
import 'package:kaamwalijobs_new/bloc/homepage_event.dart';
import 'package:kaamwalijobs_new/bloc/homepage_state.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/core/local_storage.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_bloc.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_state.dart';
import 'package:kaamwalijobs_new/features/dashboard/presentation/location/location_select.dart';
import 'package:kaamwalijobs_new/features/jobs/presentation/alljobsopenings.dart';
import 'package:kaamwalijobs_new/features/navigation/bloc/packages_bloc.dart';
import 'package:kaamwalijobs_new/screens/category_page.dart';

import '../../../assets/shimmer_effect/homepage_categories.dart';
import '../../../models/categorylist.dart';
import '../../../models/homepage_model.dart';
import '../../auth/presentation/candidate_register.dart';
import '../../auth/presentation/login_popup.dart';
import '../../jobs/presentation/jobs_apply.dart';
import '../../navigation/presentation/allcategories.dart';
import '../../navigation/presentation/search_candidates.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  String selectedJobName = "Select a job";
  String selecteJobdId = "2";
  String selectedLocation = "Location";
  bool toggleSearch = true;
  double _buttonScale = 1.0;
  double _locationButtonScale = 1.0;

  Categorylistmodel? categorylistmodel;
  List<String> categoriesImages = [
    "lib/assets/images/jhaduPocha.png",
    "lib/assets/images/maid.png",
    "lib/assets/images/babysitter.png",
    "lib/assets/images/cook.png",
    "lib/assets/images/nanny.png",
    "lib/assets/images/elderlyCare.png",
    "lib/assets/images/patient_care.png",
    "lib/assets/images/japa_maid2.png",
    "lib/assets/images/nurse.png",
    "lib/assets/images/chef.png",
    "lib/assets/images/baby_massage.png",
    "lib/assets/images/house-keeper.png",
    "lib/assets/images/driver.png",
    "lib/assets/images/security_gaurd.png",
    "lib/assets/images/delivery_boy.png",
    "lib/assets/images/office_boy.png"
  ];

  Future<void> checkForUpdate() async {
    try {
      AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          await InAppUpdate.performImmediateUpdate();
        } else if (updateInfo.flexibleUpdateAllowed) {
          await InAppUpdate.startFlexibleUpdate();
          await InAppUpdate.completeFlexibleUpdate();
        } else {
          print("Update available, but no method allowed.");
        }
      }
    } catch (e) {
      print("Error checking for update: $e");
    }
  }

  late HomepageBloc _homepageBloc;
  late AuthBloc _authBloc;
  @override
  void initState() {
    super.initState();

    checkForUpdate();

    _homepageBloc = BlocProvider.of<HomepageBloc>(context, listen: false);
    _authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    _homepageBloc.add(GetHomePageCategoriesEvents());
    BlocProvider.of<PurchasedPackageDataBloc>(context);
  }

  checkLoginPopup() async {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(content: LoginPopup()));
  }

  String coordinates = "";
  double latitude = 0.0;
  double longitude = 0.0;
  String address = "";
  bool scanning = false;
  String addressData = "";

  Future<void> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      latitude = locations.first.latitude;
      longitude = locations.first.longitude;
      print("Latitude: $latitude, Longitude: $longitude");
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  BlocBuilder(
                      bloc: _authBloc,
                      buildWhen: (previous, current) =>
                          current is AuthLoadedState ||
                          current is AuthLoadFailedState ||
                          current is AuthLoadingState,
                      builder: (context, state) {
                        if (state is AuthLoadedState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Welcome Back!",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 220, 7, 78),
                                    fontSize: 16),
                              ),
                              Row(
                                children: [
                                  Text(
                                    state.userData.name,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        color:
                                            Color.fromARGB(255, 35, 104, 209),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Image.asset(
                                      "lib/assets/images/hello.png",
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          return Image.asset(
                            "lib/assets/images/kaamwalijobs.png",
                            height: 40,
                          );
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: BlocBuilder(
                      bloc: _homepageBloc,
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTapDown: (_) {
                                HapticFeedback.lightImpact(); // vibration
                                setState(() =>
                                    _buttonScale = 0.95); // shrink on press
                              },
                              onTapUp: (_) => setState(
                                  () => _buttonScale = 1.0), // release back
                              onTapCancel: () =>
                                  setState(() => _buttonScale = 1.0),
                              onTap: () async {
                                EasyLoading.show();
                                HomepageBloc data = HomepageBloc();
                                categorylistmodel =
                                    await data.loadCategoryUpload();
                                EasyLoading.dismiss();
                                data.selectCategoryDropdown(
                                  context,
                                  categorylistmodel!,
                                  (selectedName, selectedId) {
                                    setState(() {
                                      selectedJobName = selectedName;
                                      selecteJobdId = selectedId;
                                    });
                                  },
                                );
                              },
                              child: AnimatedScale(
                                scale: _buttonScale,
                                duration: const Duration(milliseconds: 120),
                                curve: Curves.easeOut,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.52,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        selectedJobName,
                                        style: TextStyle(
                                          color:
                                              selectedJobName == "Select a job"
                                                  ? Colors.grey
                                                  : Colors.black,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 14),
                                        child: Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTapDown: (_) {
                                HapticFeedback.lightImpact(); // light vibration
                                setState(() => _locationButtonScale =
                                    0.95); // shrink on press
                              },
                              onTapUp: (_) => setState(() =>
                                  _locationButtonScale = 1.0), // release back
                              onTapCancel: () =>
                                  setState(() => _locationButtonScale = 1.0),
                              onTap: () async {
                                final city = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        LocationSelectScreen(),
                                  ),
                                );
                                if (city != null && city is String) {
                                  setState(() {
                                    selectedLocation = city;
                                  });
                                }
                                getCoordinatesFromAddress(selectedLocation);
                              },
                              child: AnimatedScale(
                                scale: _locationButtonScale,
                                duration: const Duration(milliseconds: 120),
                                curve: Curves.easeOut,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            selectedLocation,
                                            style: TextStyle(
                                              color:
                                                  selectedLocation == "Location"
                                                      ? Colors.grey
                                                      : Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Center(
                    child: Visibility(
                      visible: selectedJobName != "Select a job" &&
                              selectedLocation != "Location"
                          ? true
                          : false,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchCandidates(
                                      latitude,
                                      longitude,
                                      selecteJobdId,
                                      selectedJobName,
                                      selectedLocation)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(218, 13, 72, 161),
                              borderRadius: BorderRadius.circular(6)),
                          child: Center(
                              child: Text(
                            "SEARCH",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Our categories",
                          style: GoogleFonts.robotoFlex(
                              color: textBlackColor3,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Allcategories(
                                          image: categoriesImages)));
                            },
                            child: Row(
                              children: [
                                Text(
                                  "See all",
                                  style: GoogleFonts.robotoFlex(
                                      color: blueColor2,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                sizedBoxW5,
                                Icon(
                                  size: 18,
                                  Icons.arrow_circle_right,
                                  color: blueColor2,
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  BlocBuilder<HomepageBloc, HomepageState>(
                    bloc: _homepageBloc,
                    buildWhen: (previous, current) =>
                        current is HomePageLoadedState ||
                        current is HomePageLoadingState ||
                        current is HomePageFailedState,
                    builder: (context, state) {
                      if (state is HomePageLoadedState)
                        return GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 20,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 20),
                          itemCount: (state.homepagemodel.categorylist !=
                                      null &&
                                  state.homepagemodel.categorylist!.length > 6)
                              ? state.homepagemodel.categorylist!
                                  .sublist(0, 6)
                                  .length
                              : state.homepagemodel.categorylist?.length,
                          itemBuilder: (BuildContext context, int index) {
                            List<Categorylist> categories =
                                (state.homepagemodel.categorylist != null &&
                                        state.homepagemodel.categorylist!
                                                .length >
                                            6)
                                    ? state.homepagemodel.categorylist!
                                        .sublist(0, 6)
                                    : state.homepagemodel.categorylist ?? [];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CategoryPage(
                                            categoryId: state
                                                    .homepagemodel
                                                    .categorylist?[index]
                                                    .categoryId ??
                                                "")));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 245, 243, 243),
                                        blurRadius: 1,
                                      ),
                                    ],
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 243, 243, 245))),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      categoriesImages[index],
                                      height: 60,
                                    ),
                                    Text(
                                      categories[index].categoryName ?? "",
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      else
                        return const HomepageCategoriesShimmer();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CandidateRegister()));
                      },
                      child: Image.asset(
                          "lib/assets/images/homepage_banner (2).jpg"

                          // width: MediaQuery.of(context).size.width,
                          ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Job Openings",
                        style: GoogleFonts.robotoFlex(
                            color: textBlackColor3,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Alljobsopenings()));
                          },
                          child: Row(
                            children: [
                              Text(
                                "See all",
                                style: GoogleFonts.robotoFlex(
                                    color: blueColor2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              sizedBoxW5,
                              Icon(
                                size: 18,
                                Icons.arrow_circle_right,
                                color: blueColor2,
                              )
                            ],
                          ))
                    ],
                  ),
                  sizedBoxH15,
                  BlocBuilder<HomepageBloc, HomepageState>(
                      bloc: _homepageBloc,
                      buildWhen: (previous, current) =>
                          current is HomePageLoadedState ||
                          current is HomePageLoadingState,
                      builder: (context, state) {
                        if (state is HomePageLoadedState) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisExtent: 300,
                                    mainAxisSpacing: 10),
                            itemCount: state.homepagemodel.joblist?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 200, 197, 197),
                                        // spreadRadius: 1,
                                        blurRadius: 3,
                                        // offset: Offset(
                                        //     5, 5), // changes position of shadow
                                      ),
                                    ],
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 243, 243, 245))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            state.homepagemodel.joblist?[index]
                                                    .postedBy ??
                                                "",
                                            style:
                                                TextStyle(color: textGreyColor),
                                          ),
                                        ),
                                        Container(
                                            height: 25,
                                            width: 65,
                                            decoration: const ShapeDecoration(
                                              color: Color.fromARGB(
                                                  255, 228, 21, 45),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5),
                                                  topLeft: Radius.circular(5),
                                                  bottomLeft:
                                                      Radius.circular(7),
                                                ),
                                              ),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Pay Adv',
                                                style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10),
                                      child: Text(state.homepagemodel
                                              .joblist?[index].jobType ??
                                          ""),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        state.homepagemodel.joblist?[index]
                                                .jobLocation ??
                                            "",
                                        style: TextStyle(color: textGreyColor),
                                      ),
                                    ),
                                    sizedBoxH5,
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "lib/assets/images/calendar_logo.png",
                                            height: 12,
                                          ),
                                          Text(
                                            " Age:",
                                            style:
                                                TextStyle(color: iconGreyColor),
                                          ),
                                          Text(
                                            " ${state.homepagemodel.joblist?[index].age} Yrs",
                                            style:
                                                TextStyle(color: iconGreyColor),
                                          )
                                        ],
                                      ),
                                    ),
                                    sizedBoxH5,
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "lib/assets/images/gender_icon.png",
                                            height: 13,
                                          ),
                                          Text(
                                            " Gender:",
                                            style:
                                                TextStyle(color: iconGreyColor),
                                          ),
                                          Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            " ${state.homepagemodel.joblist?[index].gender}",
                                            style:
                                                TextStyle(color: iconGreyColor),
                                          )
                                        ],
                                      ),
                                    ),
                                    sizedBoxH5,
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "lib/assets/images/exp_icon.png",
                                            height: 12,
                                          ),
                                          Text(
                                            " Experience:",
                                            style:
                                                TextStyle(color: iconGreyColor),
                                          ),
                                          Text(
                                            " ${state.homepagemodel.joblist?[index].experience}",
                                            style:
                                                TextStyle(color: iconGreyColor),
                                          )
                                        ],
                                      ),
                                    ),
                                    sizedBoxH5,
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "lib/assets/images/religion_icon.png",
                                            height: 12,
                                          ),
                                          Text(
                                            " Religion:",
                                            style:
                                                TextStyle(color: iconGreyColor),
                                          ),
                                          Text(
                                            " ${state.homepagemodel.joblist?[index].religion}",
                                            style:
                                                TextStyle(color: iconGreyColor),
                                          )
                                        ],
                                      ),
                                    ),
                                    sizedBoxH5,
                                    Padding(
                                      padding: const EdgeInsets.only(left: 6.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "lib/assets/images/work_icon.png",
                                            height: 12,
                                          ),
                                          Text(
                                            " Working hrs:",
                                            style:
                                                TextStyle(color: iconGreyColor),
                                          ),
                                          Expanded(
                                            child: Text(
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              " ${state.homepagemodel.joblist?[index].workingHours}",
                                              style: TextStyle(
                                                  color: iconGreyColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    sizedBoxH10,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        "Rs. ${state.homepagemodel.joblist?[index].monthPrice}/monthly",
                                        style: TextStyle(
                                            color: blueColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    sizedBoxH10,
                                    Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          final userLogIn = LocalStoragePref()
                                              .getUserProfile();
                                          if (userLogIn == null) {
                                            checkLoginPopup();
                                          } else {
                                            if (userLogIn.flag == "1") {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => JobsApply(
                                                          jobsLocation: state
                                                                  .homepagemodel
                                                                  .joblist?[
                                                                      index]
                                                                  .jobLocation ??
                                                              "",
                                                          jobsType: state
                                                                  .homepagemodel
                                                                  .joblist?[
                                                                      index]
                                                                  .jobType ??
                                                              "",
                                                          jobsId: state
                                                                  .homepagemodel
                                                                  .joblist?[
                                                                      index]
                                                                  .jobpostId ??
                                                              "")));
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: Text(
                                                      'candidates eligibility'),
                                                  content: Text(
                                                      "Only candidates are eligible to apply for the jobs!"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: Text('Cancel'),
                                                    ),
                                                  ],
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 100,
                                          decoration:
                                              BoxDecoration(color: blueColor),
                                          child: Center(
                                            child: Text(
                                              "Apply",
                                              style:
                                                  TextStyle(color: whiteColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        } else
                          return Center(child: CircularProgressIndicator());
                      }),
                  sizedBoxH10
                ],
              ),
            ),
          ),
        ));
  }
}
