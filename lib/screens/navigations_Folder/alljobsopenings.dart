import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/bloc/homepage_bloc.dart';
import 'package:kaamwalijobs_new/bloc/homepage_state.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';

class Alljobsopenings extends StatefulWidget {
  const Alljobsopenings({super.key});

  @override
  State<Alljobsopenings> createState() => _AlljobsopeningsState();
}

class _AlljobsopeningsState extends State<Alljobsopenings> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<HomepageBloc, HomepageState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomePageLoadedState)
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.homepagemodel.joblist.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  state.homepagemodel.joblist[index].postedBy,
                                  style: TextStyle(color: textGreyColor),
                                ),
                              ],
                            ),
                            Text(state.homepagemodel.joblist[index].jobType),
                            Text(
                              state.homepagemodel.joblist[index].jobLocation,
                              style: TextStyle(color: textGreyColor),
                            ),
                            sizedBoxH10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Center(
                                    child: RichText(
                                        text: TextSpan(
                                            style: TextStyle(color: blackColor),
                                            children: [
                                          TextSpan(text: "Age "),
                                          TextSpan(
                                              text: state.homepagemodel
                                                  .joblist[index].age),
                                          TextSpan(text: " Yrs"),
                                        ])),
                                  ),
                                  height: 32,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                          255, 230, 234, 245)),
                                ),
                                Container(
                                  child: Center(
                                      child: Text(state.homepagemodel
                                          .joblist[index].gender)),
                                  height: 32,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                          255, 230, 234, 245)),
                                ),
                                Container(
                                  child: Center(
                                      child: Text(state.homepagemodel
                                          .joblist[index].religion)),
                                  height: 32,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                          255, 230, 234, 245)),
                                )
                              ],
                            ),
                            sizedBoxH15,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Center(
                                    child: RichText(
                                        text: TextSpan(
                                            style: TextStyle(color: blackColor),
                                            children: [
                                          TextSpan(text: "Experience - "),
                                          TextSpan(
                                              text: state.homepagemodel
                                                  .joblist[index].experience),
                                          TextSpan(text: " Years"),
                                        ])),
                                  ),
                                  height: 32,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                          255, 230, 234, 245)),
                                ),
                                Container(
                                  child: Center(
                                    child: RichText(
                                        text: TextSpan(
                                            style: TextStyle(color: blackColor),
                                            children: [
                                          TextSpan(text: "Working - "),
                                          TextSpan(
                                              text: state.homepagemodel
                                                  .joblist[index].workingHours),
                                        ])),
                                  ),
                                  height: 32,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                          255, 230, 234, 245)),
                                ),
                              ],
                            ),
                            sizedBoxH15,
                            Container(
                              child: Center(
                                child: RichText(
                                    text: TextSpan(
                                        style: TextStyle(color: blackColor),
                                        children: [
                                      TextSpan(text: "Maritial status - "),
                                      TextSpan(
                                          text: state.homepagemodel
                                              .joblist[index].maritalStatus),
                                    ])),
                              ),
                              height: 32,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(255, 230, 234, 245)),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 3.0, top: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Working for this feature")));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: blueColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      height: 32,
                                      width: 100,
                                      child: Center(
                                        child: Text(
                                          "Apply",
                                          style: TextStyle(color: whiteColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                      "Rs. ${state.homepagemodel.joblist[index].monthPrice} / month")
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 200, 197, 197),
                              // spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(5, 5), // changes position of shadow
                            ),
                          ],
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color.fromARGB(255, 243, 243, 245))),
                    ),
                  );
                },
              );
            return CircularProgressIndicator();
          }),
    );
  }
}
