import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/bloc/packages_bloc.dart';
import 'package:kaamwalijobs_new/bloc/packages_events.dart';
import 'package:kaamwalijobs_new/bloc/packages_state.dart';
import 'package:kaamwalijobs_new/screens/widgets/packages_image.dart';

class Packages extends StatefulWidget {
  const Packages({super.key});

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  late PackagesBloc _packageBloc;

  @override
  void initState() {
    super.initState();
    _packageBloc = BlocProvider.of<PackagesBloc>(context);
    fetch();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  fetch() {
    _packageBloc.add(GetPackagesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: BlocBuilder<PackagesBloc, PackagesState>(
          buildWhen: (previous, current) {
        if (current is PackagesLoadedState) {
          return true;
        }
        return false;
      }, builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Icon(Icons.arrow_back),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                  child: Text(
                    "Choose a Candidate Plan That's right for you",
                    style: GoogleFonts.poltawskiNowy(
                        fontSize: 18, color: blueColor),
                  ),
                ),
              ),
              if (state is PackagesLoadedState)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                      itemCount:
                          state.candidatePackagesModel.candidatePackage.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: ShapeDecoration(
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              color: whiteColor,
                            ),
                            child: Stack(children: [
                              Image.asset(
                                image[index],
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        state
                                            .candidatePackagesModel
                                            .candidatePackage[index]
                                            .packageName,
                                        style: GoogleFonts.poltawskiNowy(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      "for ${state.candidatePackagesModel.candidatePackage[index].validFor} days",
                                      style: GoogleFonts.poltawskiNowy(
                                          fontSize: 18, color: blueColor),
                                    ),
                                    Text(
                                        "Total Candidate${state.candidatePackagesModel.candidatePackage[index].totalCount}"),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: state
                                                        .candidatePackagesModel
                                                        .candidatePackage[index]
                                                        .description
                                                        .length >
                                                    5
                                                ? 5
                                                : state
                                                    .candidatePackagesModel
                                                    .candidatePackage[index]
                                                    .description
                                                    .length,
                                            itemBuilder: (context, index1) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Center(
                                                  child: Text(
                                                      state
                                                          .candidatePackagesModel
                                                          .candidatePackage[
                                                              index]
                                                          .description[index1],
                                                      style:
                                                          GoogleFonts.quicksand(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  color: blackColor),
                                              children: [
                                            TextSpan(
                                                text:
                                                    "RS. ${state.candidatePackagesModel.candidatePackage[index].price}",
                                                style:
                                                    GoogleFonts.poltawskiNowy(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20)),
                                            const TextSpan(
                                                text: "/",
                                                style: TextStyle(fontSize: 22)),
                                            TextSpan(
                                                text:
                                                    "${state.candidatePackagesModel.candidatePackage[index].validFor} days",
                                                style: const TextStyle(
                                                    color: blackColor))
                                          ])),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: blackColor),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.30,
                                          child: Center(
                                            child: Text(
                                              "Buy Now",
                                              style: GoogleFonts.roboto(
                                                  color: whiteColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]),
                          ),
                        );
                      }),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                  child: Text(
                    "Choose a Job Posting Plan That's right for you",
                    style: GoogleFonts.poltawskiNowy(
                        fontSize: 18, color: blueColor),
                  ),
                ),
              ),
              if (state is PackagesLoadedState)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                      itemCount: state.candidatePackagesModel.jobPackage.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: ShapeDecoration(
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              color: whiteColor,
                            ),
                            child: Stack(children: [
                              Image.asset(
                                image[index],
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        state.candidatePackagesModel
                                            .jobPackage[index].packageName,
                                        style: GoogleFonts.poltawskiNowy(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      "for ${state.candidatePackagesModel.jobPackage[index].validFor} days",
                                      style: GoogleFonts.poltawskiNowy(
                                          fontSize: 18, color: blueColor),
                                    ),
                                    Text(
                                        "Total Candidate${state.candidatePackagesModel.jobPackage[index].totalCount}"),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: state
                                                        .candidatePackagesModel
                                                        .jobPackage[index]
                                                        .description
                                                        .length >
                                                    5
                                                ? 5
                                                : state
                                                    .candidatePackagesModel
                                                    .jobPackage[index]
                                                    .description
                                                    .length,
                                            itemBuilder: (context, index1) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Center(
                                                  child: Text(
                                                      state
                                                          .candidatePackagesModel
                                                          .jobPackage[index]
                                                          .description[index1],
                                                      style:
                                                          GoogleFonts.quicksand(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  color: blackColor),
                                              children: [
                                            TextSpan(
                                                text:
                                                    "RS. ${state.candidatePackagesModel.jobPackage[index].price}",
                                                style:
                                                    GoogleFonts.poltawskiNowy(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20)),
                                            const TextSpan(
                                                text: "/",
                                                style: TextStyle(fontSize: 22)),
                                            TextSpan(
                                                text:
                                                    "${state.candidatePackagesModel.jobPackage[index].validFor} days",
                                                style: const TextStyle(
                                                    color: blackColor))
                                          ])),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: blackColor),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.30,
                                          child: Center(
                                            child: Text(
                                              "Buy Now",
                                              style: GoogleFonts.roboto(
                                                  color: whiteColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]),
                          ),
                        );
                      }),
                ),
            ],
          ),
        );
      }),
    );
  }
}
