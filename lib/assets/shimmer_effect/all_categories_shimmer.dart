import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:shimmer/shimmer.dart';

class allCategoriesShimmer extends StatelessWidget {
  const allCategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // backgroundColor: scaffoldColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 15,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 20, crossAxisCount: 3, crossAxisSpacing: 20),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: const BoxDecoration(color: whiteColor),
              child: Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 213, 210, 210),
                highlightColor: const Color.fromARGB(255, 241, 241, 241),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10))),
              ),
            );
          },
        ),
      ),
    );
  }
}
