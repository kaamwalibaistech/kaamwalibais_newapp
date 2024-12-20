import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:shimmer/shimmer.dart';

import '../../assets/colors.dart';

class PackageLoader extends StatelessWidget {
  const PackageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          sizedBoxH20,
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //   child: Shimmer.fromColors(
          //     baseColor: Colors.grey.shade300,
          //     highlightColor: Colors.grey.shade400,
          //     child: Container(
          //         width: MediaQuery.of(context).size.width,
          //         height: 20,
          //         decoration: BoxDecoration(
          //             color: Colors.grey.shade300,
          //             borderRadius: BorderRadius.circular(00))),
          //   ),
          // ),
          // sizedBoxH10,
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.9,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: ShapeDecoration(
                        color: whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 10,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Positioned.fill(
                                  top: 55,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade400,
                                      child: Container(
                                          width: 100,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                          )),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 22.0),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade400,
                                    child: Container(
                                        width: 50,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          sizedBoxH10,
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 22.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  )),
                            ),
                          ),
                          sizedBoxH10,
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  )),
                            ),
                          ),
                          sizedBoxH10,
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  )),
                            ),
                          ),
                          sizedBoxH10,
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  )),
                            ),
                          ),
                          sizedBoxH10,
                          Padding(
                            padding: const EdgeInsets.only(left: 35, right: 35),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  )),
                            ),
                          ),
                          sizedBoxH10,
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  width: 100,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  )),
                            ),
                          ),
                          sizedBoxH20,
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 15),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  width: 200,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          sizedBoxH20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade400,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(00))),
            ),
          ),
          sizedBoxH10,
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.9,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: ShapeDecoration(
                        color: whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 10,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Positioned.fill(
                                  top: 55,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade400,
                                      child: Container(
                                          width: 100,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                          )),
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 22.0),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade400,
                                    child: Container(
                                        width: 50,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          sizedBoxH10,
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 22.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  )),
                            ),
                          ),
                          sizedBoxH10,
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  )),
                            ),
                          ),
                          sizedBoxH10,
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  )),
                            ),
                          ),
                          sizedBoxH10,
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  )),
                            ),
                          ),
                          sizedBoxH10,
                          Padding(
                            padding: const EdgeInsets.only(left: 35, right: 35),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  )),
                            ),
                          ),
                          sizedBoxH10,
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  width: 100,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  )),
                            ),
                          ),
                          sizedBoxH20,
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 15),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade400,
                              child: Container(
                                  width: 200,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
