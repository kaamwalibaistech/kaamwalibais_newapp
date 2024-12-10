import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/bloc/homepage_bloc.dart';
import 'package:kaamwalijobs_new/bloc/homepage_event.dart';
import 'package:kaamwalijobs_new/bloc/homepage_state.dart';
import 'package:kaamwalijobs_new/screens/navigations_Folder/alljobsopenings.dart';
import 'package:kaamwalijobs_new/screens/navigations_Folder/login_popup.dart';
import 'package:kaamwalijobs_new/screens/onboardingScreen/onboarding_items.dart';

import '../../models/homepage_model.dart';
import 'allcategories.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final TextEditingController _controller = TextEditingController();
  final listViewController = ListViewItems();
  final featuredJobsController = FeaturedJobsItems();
  // Homepagemodel? data;
  late HomepageBloc _homepageBloc;
  @override
  void initState() {
    super.initState();
    _homepageBloc = BlocProvider.of<HomepageBloc>(context);
    fetch();

    // Repositiory().getHomePageData().then((value) {
    //   setState(() {
    //     data = value;
    //   });
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(content: LoginPopup()));
    });
  }

  fetch() {
    _homepageBloc.add(GetHomePageCategoriesEvents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldColor,
        body: BlocConsumer<HomepageBloc, HomepageState>(
            buildWhen: (previous, current) {
              if (current is HomePageLoadedState) {
                return true;
              }
              return false;
            },
            listener: (context, state) {},
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      const Text(
                        "Welcome Back!",
                        style: TextStyle(color: textGreyColor, fontSize: 16),
                      ),
                      Row(
                        children: [
                          const Text(
                            "Ritesh Dixit",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.82,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: _controller,
                                decoration: const InputDecoration(
                                  hintText: "Search a job or position",
                                  hintStyle: TextStyle(color: textGreyColor),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.10,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Icon(Icons.tune))
                          ],
                        ),
                      ),
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
                                  style: TextStyle(color: textGreyColor),
                                ))
                          ],
                        ),
                      ),
                      if (state is HomePageLoadedState)
                        GridView.builder(
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
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(255, 200, 197, 197),
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
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
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
                                  style: TextStyle(color: textGreyColor),
                                ))
                          ],
                        ),
                      ),
                      if (state is HomePageLoadedState)
                        ListView.builder(
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
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Applied Successfully")));
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
                        ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
