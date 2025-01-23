import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/features/auth/network/auth_repository.dart';
import 'package:kaamwalijobs_new/features/dashboard/presentation/Filter_Sort/filter_control_model.dart';
import 'package:kaamwalijobs_new/models/categorylist.dart';

class SearchCandidatesFilter extends StatefulWidget {
  @override
  State<SearchCandidatesFilter> createState() => _SearchCandidatesFilterState();
}

class _SearchCandidatesFilterState extends State<SearchCandidatesFilter> {
  Categorylistmodel? categorylistmodel;

  int kmRange = 3;
  int selectedIndex = 0;
  bool visibilityTag = false;

  List<FilterListWithCountModel> filterText = [
    FilterListWithCountModel(title: 'Category', count: ''), // 0
    FilterListWithCountModel(title: 'Salary', count: ''), // 1
    FilterListWithCountModel(title: 'Passport', count: ''), // 2
    FilterListWithCountModel(title: 'Age', count: ''), // 3
    FilterListWithCountModel(title: 'Experience', count: ''), // 4
    FilterListWithCountModel(title: 'Gender', count: ''), // 5
    FilterListWithCountModel(title: 'Working Hours', count: ''), // 6
    FilterListWithCountModel(title: 'Religion', count: ''), // 7
    FilterListWithCountModel(title: 'Language', count: ''), // 8
    FilterListWithCountModel(title: 'KM', count: ''), // 9
  ];

  List<String> passportList = ["Yes", "No"];
  List<String> genderList = ["Male", "Female"];
  List<String> workingHoursList = [
    '1 Hour',
    '2 Hours',
    '3 Hours',
    '4 Hours',
    '5 Hours',
    '6 Hours',
    '7 Hours',
    '8 Hours',
    '9 Hours',
    '10 Hours',
    '11 Hours',
    '12 Hours',
    '24 Hours',
  ];
  List<String> religionList = ["Hindu", "Muslim", "Catholic"];
  List<String> languageList = ["Hindi", "English", "Marathi"];

  String categoryId = "",
      categoryName = "",
      minSalary = "",
      maxSalary = "",
      passportValue = "",
      minAge = "",
      maxAge = "",
      minExperience = "",
      maxExperience = "",
      km = "";

  List<String> genderValue = [];
  List<String> workingHoursValue = [];
  List<String> religionValue = [];
  List<String> languageValue = [];

  RangeValues salaryRange = const RangeValues(0, 30000);
  RangeValues ageRange = const RangeValues(18, 60);
  RangeValues experienceRange = const RangeValues(0, 20);

  @override
  void initState() {
    super.initState();
    loadCategoryUpload();
  }

  Future loadCategoryUpload() async {
    final categorylist = await AuthRepository().getcategorynameid();
    setState(() {
      categorylistmodel = categorylist;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        iconTheme: IconThemeData(
          color: whiteColor,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  categoryId = "";
                  categoryName = "";
                  minSalary = "";
                  maxSalary = "";
                  passportValue = "";
                  minAge = "";
                  maxAge = "";
                  minExperience = "";
                  maxExperience = "";
                  km = "";
                  // selectedIndex = 0;
                  for (int i = 0; i < filterText.length; i++) {
                    filterText[i].count = '';
                  }
                  genderValue = [];
                  workingHoursValue = [];
                  religionValue = [];
                  languageValue = [];
                  kmRange = 3;
                  ageRange = const RangeValues(18, 60);
                  salaryRange = const RangeValues(0, 30000);
                  experienceRange = const RangeValues(0, 20);
                });
              },
              child: Text(
                "Clear filter",
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Filter",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 1.5,
                  color: const Color.fromARGB(255, 233, 241, 255),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filterText.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            selectedIndex = index;
                            setState(() {});
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            color: selectedIndex != index
                                ? const Color.fromARGB(255, 233, 241, 255)
                                : Color.fromARGB(255, 201, 220, 252),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    filterText[index].title!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF5C5C5C),
                                    ),
                                  ),
                                ),
                                if (filterText[index].count != '')
                                  Icon(
                                    Icons.circle,
                                    color: Colors.blue,
                                    size: 7,
                                  ),
                                // Text(
                                //   filterText[index].count! ,
                                //   style: TextStyle(
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.w400,
                                //     color: blueColor,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Expanded(
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      if (categorylistmodel != null)
                        selectedIndex == 0
                            ? categoryWidget(categorylistmodel!)
                            : selectedIndex == 1
                                ? salaryWidget()
                                : selectedIndex == 2
                                    ? passportWidget()
                                    : selectedIndex == 3
                                        ? ageWidget()
                                        : selectedIndex == 4
                                            ? experienceWidget()
                                            : selectedIndex == 5
                                                ? genderWidget()
                                                : selectedIndex == 6
                                                    ? workingHoursWidget()
                                                    : selectedIndex == 7
                                                        ? religionWidget()
                                                        : selectedIndex == 8
                                                            ? languageWidget()
                                                            : kmWidget()
                    ],
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              final values = {
                'categoryId': categoryId,
                'categoryName': categoryName,
                'minSalary': minSalary,
                'maxSalary': maxSalary,
                'passportValue': passportValue,
                'minAge': minAge,
                'maxAge': maxAge,
                'minExperience': minExperience,
                'maxExperience': maxExperience,
                'km': km,
                'genderValue': genderValue,
                'workingHoursValue': workingHoursValue,
                'religionValue': religionValue,
                'languageValue': languageValue
              };
              Navigator.pop(context, values);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 8, 65, 134),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Text(
                "Continue",
                style: TextStyle(color: whiteColor),
              )),
            ),
          )
        ],
      ),
    );
  }

  Widget categoryWidget(Categorylistmodel categoryListModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: categoryListModel.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (categoryId ==
                              categoryListModel.data[index].categoryId) {
                            categoryId = "";
                            categoryName = "";
                            filterText[0].count = "";
                          } else {
                            categoryId =
                                categoryListModel.data[index].categoryId;
                            categoryName =
                                categoryListModel.data[index].categoryName;

                            filterText[0].count = "1";
                          }
                        });
                      },
                      child: Icon(
                        categoryId == categoryListModel.data[index].categoryId
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        size: 25,
                        color: categoryId ==
                                categoryListModel.data[index].categoryId
                            ? Colors.blueAccent
                            : Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      categoryListModel.data[index].categoryName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF5C5C5C),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget salaryWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Salary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent),
            child: Column(
              children: [
                RangeSlider(
                  values: salaryRange,
                  max: 30000,
                  min: 0,
                  divisions: 10,
                  activeColor: primaryColor,
                  labels: RangeLabels(
                    salaryRange.start.round().toString(),
                    salaryRange.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      salaryRange = values;
                      minSalary = salaryRange.start.round().toString();
                      maxSalary = salaryRange.end.round().toString();
                      filterText[1].count = "1";
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      minSalary == "" ? '₹ 0' : '₹ $minSalary',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF5C5C5C),
                      ),
                    ),
                    Text(
                      maxSalary == "" ? '₹ 30000' : '₹ $maxSalary',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF5C5C5C),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget passportWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          // Passport Widget
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Passport',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: passportList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (passportValue == passportList[index]) {
                              passportValue = "";
                              filterText[2].count = "";
                            } else {
                              passportValue = passportList[index];
                              filterText[2].count = "1";
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: passportValue == passportList[index]
                                      ? blueColor
                                      : Colors.grey,
                                  width: 1),
                              borderRadius: BorderRadius.circular(5),
                              color: passportValue == passportList[index]
                                  ? blueColor
                                  : Colors.white),
                          child: Center(
                            child: Text(
                              passportList[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: passportValue == passportList[index]
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ageWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          //  Age Widget
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Age',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent),
                child: Column(
                  children: [
                    RangeSlider(
                      values: ageRange,
                      max: 60,
                      min: 18,
                      divisions: 10,
                      activeColor: primaryColor,
                      labels: RangeLabels(
                        ageRange.start.round().toString(),
                        ageRange.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          ageRange = values;
                          minAge = ageRange.start.round().toString();
                          maxAge = ageRange.end.round().toString();
                          filterText[3].count = "1";
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          minAge == "" ? '18' : minAge,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF5C5C5C),
                          ),
                        ),
                        Text(
                          maxAge == "" ? '60' : maxAge,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF5C5C5C),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget experienceWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Experience',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent),
            child: Column(
              children: [
                RangeSlider(
                  values: experienceRange,
                  max: 20,
                  min: 0,
                  divisions: 10,
                  activeColor: primaryColor,
                  labels: RangeLabels(
                    experienceRange.start.round().toString(),
                    experienceRange.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      experienceRange = values;
                      minExperience = experienceRange.start.round().toString();
                      maxExperience = experienceRange.end.round().toString();
                      filterText[4].count = "1";
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      minExperience == "" ? '0' : minExperience,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF5C5C5C),
                      ),
                    ),
                    Text(
                      maxExperience == "" ? '20' : maxExperience,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF5C5C5C),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget kmWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Kilometer',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent),
            child: Column(
              children: [
                // Slider(
                //   value: kmRange.toDouble(),
                //   max: 15,
                //   min: 2,
                //   activeColor: primaryColor,
                //   label: 'Select Km',
                //   onChanged: (values) {
                //     setState(() {
                //       km = values.toInt().toString();
                //     });
                //   },
                // ),
                Slider(
                  label: "Select KM",
                  value: kmRange.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      km = value.toInt().toString();
                      kmRange = value.toInt();
                      filterText[9].count = "1";
                    });
                  },
                  divisions: 15,
                  min: 2,
                  max: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Selected KM : $km',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF5C5C5C),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget genderWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Gender',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: genderList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (genderValue.contains(genderList[index])) {
                              genderValue.remove(genderList[index]);
                              filterText[5].count = "";
                            } else {
                              genderValue.add(genderList[index]);
                              filterText[5].count = "1";
                            }

                            if (genderValue.isEmpty) {
                              filterText[5].count = "";
                            } else {
                              filterText[5].count = "1";
                            }
                            // genderValue = genderList[index];
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: genderValue.contains(genderList[index])
                                      ? blueColor
                                      : Colors.grey,
                                  width: 1),
                              borderRadius: BorderRadius.circular(5),
                              color: genderValue.contains(genderList[index])
                                  ? blueColor
                                  : Colors.white),
                          child: Center(
                            child: Text(
                              genderList[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: genderValue.contains(genderList[index])
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget workingHoursWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Working Hours',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: workingHoursList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (workingHoursValue
                                  .contains(workingHoursList[index])) {
                                workingHoursValue
                                    .remove(workingHoursList[index]);
                                filterText[6].count = "";
                              } else {
                                workingHoursValue.add(workingHoursList[index]);
                                filterText[6].count = "1";
                              }

                              if (workingHoursValue.isEmpty) {
                                filterText[6].count = "";
                              } else {
                                filterText[6].count = "1";
                              }
                              // workingHoursValue = workingHoursList[index];
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: workingHoursValue
                                            .contains(workingHoursList[index])
                                        ? blueColor
                                        : Colors.grey,
                                    width: 1),
                                borderRadius: BorderRadius.circular(5),
                                color: workingHoursValue
                                        .contains(workingHoursList[index])
                                    ? blueColor
                                    : Colors.white),
                            child: Center(
                              child: Text(
                                workingHoursList[index],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: workingHoursValue
                                          .contains(workingHoursList[index])
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget religionWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Religion',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: religionList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (religionValue.contains(religionList[index])) {
                              religionValue.remove(religionList[index]);
                            } else {
                              religionValue.add(religionList[index]);
                            }

                            if (religionValue.isEmpty) {
                              filterText[7].count = "";
                            } else {
                              filterText[7].count = "1";
                            }
                            // religionValue = religionList[index];
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: religionValue
                                          .contains(religionList[index])
                                      ? blueColor
                                      : Colors.grey,
                                  width: 1),
                              borderRadius: BorderRadius.circular(5),
                              color: religionValue.contains(religionList[index])
                                  ? blueColor
                                  : Colors.white),
                          child: Center(
                            child: Text(
                              religionList[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    religionValue.contains(religionList[index])
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget languageWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Language',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: languageList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (languageValue.contains(languageList[index])) {
                              languageValue.remove(languageList[index]);
                              filterText[8].count = "";
                            } else {
                              languageValue.add(languageList[index]);
                              filterText[8].count = "1";
                            }
                            // languageValue = languageList[index];
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: languageValue
                                          .contains(languageList[index])
                                      ? blueColor
                                      : Colors.grey,
                                  width: 1),
                              borderRadius: BorderRadius.circular(5),
                              color: languageValue.contains(languageList[index])
                                  ? blueColor
                                  : Colors.white),
                          child: Center(
                            child: Text(
                              languageList[index],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color:
                                    languageValue.contains(languageList[index])
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
