import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../colors.dart';

class JobsOpeningShimmer extends StatelessWidget {
  const JobsOpeningShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // backgroundColor: scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                // height: MediaQuery.of(context).size.height * .08,
                // width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: whiteColor),
                child: ListTile(
                  leading: Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 238, 236, 236),
                    highlightColor: const Color.fromARGB(255, 222, 221, 221),
                    child: Container(
                        height: 40,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        )),
                  ),
                  title: Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 238, 236, 236),
                    highlightColor: const Color.fromARGB(255, 222, 221, 221),
                    child: Container(
                        height: 10,
                        width: 2,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        )),
                  ),
                  subtitle: Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 238, 236, 236),
                    highlightColor: const Color.fromARGB(255, 222, 221, 221),
                    child: Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        )),
                  ),
                  trailing: Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 238, 236, 236),
                    highlightColor: const Color.fromARGB(255, 222, 221, 221),
                    child: Container(
                        height: 20,
                        width: 10,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        )),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
