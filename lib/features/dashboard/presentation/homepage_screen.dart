import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/bloc/homepage_bloc.dart';
import 'package:kaamwalijobs_new/bloc/homepage_event.dart';
import 'package:kaamwalijobs_new/bloc/homepage_state.dart';
import 'package:kaamwalijobs_new/core/local_storage.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_bloc.dart';
import 'package:kaamwalijobs_new/features/auth/bloc/auth_state.dart';
import 'package:kaamwalijobs_new/features/jobs/presentation/alljobsopenings.dart';
import 'package:kaamwalijobs_new/features/onboarding/presantation/onboarding_items.dart';
import 'package:kaamwalijobs_new/screens/category_page.dart';

import '../../../assets/shimmer_effect/homepage_categories.dart';
import '../../../assets/shimmer_effect/jobs_opening_shimmer.dart';
import '../../../models/employer_register_model.dart';
import '../../../models/homepage_model.dart';
import '../../auth/presentation/candidate_register.dart';
import '../../auth/presentation/login_popup.dart';
import '../../navigation/presentation/allcategories.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  // final TextEditingController _controller = TextEditingController();
  final listViewController = ListViewItems();
  final featuredJobsController = FeaturedJobsItems();

  late HomepageBloc _homepageBloc;
  late AuthBloc _authBloc;
  @override
  void initState() {
    super.initState();
    checkPermission();
    // getCurrentLocation();
    _homepageBloc = BlocProvider.of<HomepageBloc>(context, listen: false);
    _authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    _homepageBloc.add(GetHomePageCategoriesEvents());

    EmployerRegisterModel? userProfileData =
        LocalStoragePref.instance?.getUserProfile();
    if (userProfileData == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        checkLoginPopup();
      });
    } else {
      // _authBloc.add(AuthenticationEvent(
      //     password: '',
      //     phoneNumber: userProfileData.mobileNo,
      //     userType: USER.employer));
    }
  }

  checkLoginPopup() async {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(content: LoginPopup()));
  }

  String coordinates = "";
  String address = "";
  bool scanning = false;

  checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print(serviceEnabled);
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }
    permission = await Geolocator.checkPermission();
    print(permission);

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      Fluttertoast.showToast(msg: "Request Denied !");
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: "Denied Forever");
    }
    getLocation();
  }

  getLocation() async {
    setState(() {
      scanning = true;
    });
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      coordinates =
          'Latitude ${position.latitude} \n Longitude ${position.longitude}';
      List<Placemark> result =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (result.isNotEmpty) {
        address =
            '${result[0].name},${result[0].locality},${result[0].administrativeArea}';
      }
    } catch (e) {}
    setState(() {
      scanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
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
                              style:
                                  TextStyle(color: textGreyColor, fontSize: 16),
                            ),
                            Row(
                              children: [
                                Text(
                                  state.userData.name,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
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
                // Padding(
                //   padding: const EdgeInsets.only(top: 15.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Container(
                //         padding: const EdgeInsets.only(left: 10),
                //         height: MediaQuery.of(context).size.height * 0.06,
                //         width: MediaQuery.of(context).size.width * 0.82,
                //         decoration: BoxDecoration(
                //             color: whiteColor,
                //             borderRadius: BorderRadius.circular(10)),
                //         child: TextField(
                //           controller: _controller,
                //           decoration: const InputDecoration(
                //             hintText: "Search a job or position",
                //             hintStyle: TextStyle(color: textGreyColor),
                //             border:
                //                 OutlineInputBorder(borderSide: BorderSide.none),
                //           ),
                //         ),
                //       ),
                //       Container(
                //           height: MediaQuery.of(context).size.height * 0.06,
                //           width: MediaQuery.of(context).size.width * 0.10,
                //           decoration: BoxDecoration(
                //               color: whiteColor,
                //               borderRadius: BorderRadius.circular(10)),
                //           child: const Icon(Icons.tune))
                //     ],
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Our Categories",
                        style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Allcategories()));
                          },
                          child: const Text(
                            "See all",
                            style: TextStyle(color: blackColor),
                          ))
                    ],
                  ),
                ),
                BlocBuilder<HomepageBloc, HomepageState>(
                  bloc: _homepageBloc,
                  buildWhen: (previous, current) =>
                      current is HomePageLoadedState ||
                      current is HomePageLoadingState,
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
                        itemCount: state.homepagemodel.categorylist.length > 6
                            ? state.homepagemodel.categorylist
                                .sublist(0, 6)
                                .length
                            : state.homepagemodel.categorylist.length,
                        itemBuilder: (BuildContext context, int index) {
                          List<Categorylist> categories =
                              state.homepagemodel.categorylist.length > 6
                                  ? state.homepagemodel.categorylist
                                      .sublist(0, 6)
                                  : state.homepagemodel.categorylist;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryPage(
                                          categoryId: state
                                              .homepagemodel
                                              .categorylist[index]
                                              .categoryId)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 200, 197, 197),
                                      // spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(
                                          5, 5), // changes position of shadow
                                    ),
                                  ],
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 243, 243, 245))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.network(
                                    categories[index].image,
                                    // color: const Color.fromARGB(255, 247, 115, 106),
                                    height: 60,
                                  ),
                                  Text(
                                    categories[index].categoryName,
                                    style: const TextStyle(
                                        // color: blueColor,
                                        fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CandidateRegister()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.170,
                      decoration: const BoxDecoration(color: Colors.grey),
                      child: Image.asset(
                        "lib/assets/images/apply_job_banner.jpg",
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Job Openings",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Alljobsopenings()));
                          },
                          child: const Text(
                            "See all",
                            style: TextStyle(color: blackColor),
                          ))
                    ],
                  ),
                ),
                BlocBuilder<HomepageBloc, HomepageState>(
                    bloc: _homepageBloc,
                    buildWhen: (previous, current) =>
                        current is HomePageLoadedState ||
                        current is HomePageLoadingState,
                    builder: (context, state) {
                      if (state is HomePageLoadedState)
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: state.homepagemodel.joblist.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                decoration:
                                    const BoxDecoration(color: whiteColor),
                                child: ListTile(
                                  leading: Image.asset(
                                    featuredJobsController.items[index].images,
                                    height: 30,
                                  ),
                                  title: Text(state
                                      .homepagemodel.joblist[index].jobType),
                                  subtitle: Text(state.homepagemodel
                                      .joblist[index].jobLocation),
                                  trailing: Container(
                                    decoration: const BoxDecoration(),
                                    child: GestureDetector(
                                        onTap: () {
                                          Fluttertoast.showToast(
                                              msg: "Working for this feature");
                                        },
                                        child: const Text(
                                          "Apply Now",
                                          style: TextStyle(fontSize: 14),
                                        )),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      else
                        return JobsOpeningShimmer();
                    })
              ],
            ),
          ),
        ));
  }
}
