import 'package:flutter/material.dart';

class SearchCandidates extends StatelessWidget {
  final String searchLocation = "Location search";
  final double latitude;
  final double longitude;
  final String categoryName;
  final String categoryId;
  SearchCandidates(
      this.latitude, this.longitude, this.categoryId, this.categoryName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 160,
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.only(top: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 0.5),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Row(children: [
                                    const Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        searchLocation,
                                        maxLines: 1,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.clear,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ]))),
                          Padding(
                            padding: const EdgeInsets.only(top: 13),
                            child: Column(
                              children: [
                                Image.asset(
                                  'lib/assets/images/advance_options.png',
                                  height: 16,
                                ),
                                Text(
                                  'Filter',
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.sort,
                                  size: 20,
                                ),
                                Text(
                                  'Sort',
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ]),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Text(
                        "Maid - Showing 123 results",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: double.minPositive,
            ),
            Text(latitude.toString()),
            Text(longitude.toString()),
            Text(categoryId.toString()),
            Text(categoryName.toString()),
          ],
        ),
      ),
    );
  }
}
