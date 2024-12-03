import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/api_repository/homepage_api.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
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
  late Homepagemodel data;
  @override
  void initState() {
    super.initState();

    Repositiory().getHomePageData().then((value) {
      setState(() {
        data = value!;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(content: LoginPopup()
              // actions: const [],

              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                        width: MediaQuery.of(context).size.width * 0.75,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: "Search a job or position",
                            hintStyle: TextStyle(color: textGreyColor),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.06,
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
                GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisCount: 3,
                      crossAxisSpacing: 20),
                  itemCount: listViewController.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color.fromARGB(255, 243, 243, 245))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.network(
                            data.categorylist[index].image,
                            height: 60,
                          ),
                          Text(data.categorylist[index].categoryName)
                        ],
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
                        "Featured Jobs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("This will Work soon")));
                          },
                          child: const Text(
                            "See all",
                            style: TextStyle(color: textGreyColor),
                          ))
                    ],
                  ),
                ),

                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: featuredJobsController.items.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        decoration: const BoxDecoration(color: whiteColor),
                        child: ListTile(
                          leading: Image.asset(
                            featuredJobsController.items[index].images,
                            height: 30,
                          ),
                          title: Text(featuredJobsController.items[index].name),
                          subtitle: Text(
                              featuredJobsController.items[index].locations),
                          trailing: Container(
                            decoration: const BoxDecoration(),
                            child: GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Applied Successfully")));
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

                // GridView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),

                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisSpacing: 10,mainAxisSpacing: 10,
                //     crossAxisCount: 2,

                //   ),
                //   itemCount: 4,
                //   itemBuilder: (BuildContext context, int index) {
                //     return Container(decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: const Color.fromARGB(255, 254, 254, 255),
                //       border:Border.all(color: const Color.fromARGB(255, 243, 243, 245))),) ;
                //   },
                // ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ));
  }
}
