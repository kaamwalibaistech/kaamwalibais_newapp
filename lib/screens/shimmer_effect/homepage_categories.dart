import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:shimmer/shimmer.dart';

class HomepageCategoriesShimmer extends StatelessWidget {
  const HomepageCategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 20, crossAxisCount: 3, crossAxisSpacing: 20),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: const BoxDecoration(),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade400,
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
