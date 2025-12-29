import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaamwalijobs_new/bloc/homepage_event.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/features/dashboard/presentation/location/location_select.dart';

import '../../../bloc/homepage_bloc.dart';
import '../../../constant/colors.dart';
import '../../../core/local_storage.dart';
import '../../../models/categorylist.dart';
import '../../../models/employer_register_model.dart';
import '../../../models/job_post_count_minus.dart';
import '../../auth/network/auth_repository.dart';
import '../../navigation/bloc/packages_bloc.dart';
import '../../navigation/bloc/packages_event.dart';
import '../../navigation/network/saerch_candidates_api.dart';

class JobsPost extends StatefulWidget {
  const JobsPost({super.key});

  @override
  State<JobsPost> createState() => _JobsPostState();
}

class _JobsPostState extends State<JobsPost> {
  late HomepageBloc _homepageBloc;
  @override
  void initState() {
    super.initState();
    loadCategoryUpload();
    _homepageBloc = BlocProvider.of<HomepageBloc>(context, listen: false);
  }

  Categorylistmodel? categoryitemModel;

  Future<void> loadCategoryUpload() async {
    final categorydata = await AuthRepository().getcategorynameid();
    setState(() {
      categoryitemModel = categorydata;
    });
  }

  TextEditingController minimumPaymentController = TextEditingController();
  TextEditingController maximumPaymentController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  String? categoryvalue;

  int selectedValue = 0;
  int selectedShiftValue = 0;
  String? genderValue;
  String? marriedvalue;
  String? religionValue;
  String? educationValue;
  String? languageValue;
  String? ageValue;
  String? experienceValue;
  String? jobShiftvalue;
  String? scheduleValue;
  final languageItems = ["English", "Hindi", "Marathi", "Urdu"];
  final genderItems = [
    "Male",
    "Female",
  ];
  final marriageItems = ["Unmarried", "Married", "Divorce"];
  final religionItems = ["Hindu", "muslim", "Christian", "Sikh"];
  final educationItem = ["<5th", ">5th", ">10"];
  final ageItems = ["18-25", "25-35", "35-45", "45-55"];
  final experienceItems = [
    "3 Months",
    "6 Months",
    "9 Months",
    "1 Years",
    "2 Years",
    "3 Years",
    "4 Years",
    "5 Years",
    "6 Years",
    "7 Years",
    "8 Years",
    "9 Years",
    "10 Years",
    "10 >"
  ];
  final List<String> jobShiftItems = [
    "4 Hours",
    "8 Hours",
    "12 Hours",
    "24 Hours"
  ];
  final List<String> scheduleItems = [
    "Morning Shift",
    "Afternoon Shift",
    "Evening Shift",
    "Night Shift",
    "AnyTime Shift"
  ];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Job Posting",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                  child: Text(
                    "Job Category *",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.93,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    hint: const Text("Select Category"),
                    initialValue: categoryvalue,
                    items: categoryitemModel?.data.map((source) {
                      return DropdownMenuItem(
                        value: source.categoryId,
                        child: Text(source.categoryName),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        categoryvalue = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select Category'; // Validation message
                      }
                      return null; // Valid input
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 5),
                  child: Text(
                    "Job Location *",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.93,
                    child: GestureDetector(
                      onTap: () async {
                        final address = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationSelectScreen()));
                        setState(() {
                          locationController.text = address;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          border: Border.all(color: textGreyColor),
                        ),
                        child: Center(
                            child: locationController.text.isEmpty
                                ? Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "Enter work location",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(locationController.text),
                                      ),
                                    ],
                                  )),
                      ),
                    )),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 5),
                  child: Text(
                    "Job Shift *",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                sizedBoxH10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedValue = 1;
                          jobShiftvalue = jobShiftItems[0];
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.20,
                        decoration: BoxDecoration(
                          border: Border.all(color: blackColor),
                          color:
                              selectedValue == 1 ? Colors.grey : Colors.white,
                        ),
                        child: Center(child: Text(jobShiftItems[0])),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedValue = 2;
                          jobShiftvalue = jobShiftItems[1];
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.20,
                        decoration: BoxDecoration(
                          border: Border.all(color: blackColor),
                          color:
                              selectedValue == 2 ? Colors.grey : Colors.white,
                        ),
                        child: Center(child: Text(jobShiftItems[1])),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedValue = 3;
                          jobShiftvalue = jobShiftItems[2];
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.20,
                        decoration: BoxDecoration(
                          border: Border.all(color: blackColor),
                          color:
                              selectedValue == 3 ? Colors.grey : Colors.white,
                        ),
                        child: Center(child: Text(jobShiftItems[2])),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedValue = 4;
                          jobShiftvalue = jobShiftItems[3];
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.20,
                        decoration: BoxDecoration(
                          border: Border.all(color: blackColor),
                          color:
                              selectedValue == 4 ? Colors.grey : Colors.white,
                        ),
                        child: Center(child: Text(jobShiftItems[3])),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 5),
                  child: Text(
                    "Schedule *",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                sizedBoxH10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedShiftValue = 1;
                          scheduleValue = scheduleItems[0];
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                          border: Border.all(color: blackColor),
                          color: selectedShiftValue == 1
                              ? Colors.grey
                              : Colors.white,
                        ),
                        child: Center(child: Text(scheduleItems[0])),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedShiftValue = 2;
                          scheduleValue = scheduleItems[1];
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                          border: Border.all(color: blackColor),
                          color: selectedShiftValue == 2
                              ? Colors.grey
                              : Colors.white,
                        ),
                        child: Center(child: Text(scheduleItems[1])),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedShiftValue = 3;
                          scheduleValue = scheduleItems[2];
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                          border: Border.all(color: blackColor),
                          color: selectedShiftValue == 3
                              ? Colors.grey
                              : Colors.white,
                        ),
                        child: Center(child: Text(scheduleItems[2])),
                      ),
                    ),
                  ],
                ),
                sizedBoxH15,
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedShiftValue = 4;
                          scheduleValue = scheduleItems[3];
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                          border: Border.all(color: blackColor),
                          color: selectedShiftValue == 4
                              ? Colors.grey
                              : Colors.white,
                        ),
                        child: Center(child: Text(scheduleItems[3])),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedShiftValue = 5;
                          scheduleValue = scheduleItems[4];
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.28,
                        decoration: BoxDecoration(
                          border: Border.all(color: blackColor),
                          color: selectedShiftValue == 5
                              ? Colors.grey
                              : Colors.white,
                        ),
                        child: Center(child: Text(scheduleItems[4])),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                  child: Text(
                    "Gender (लिंग) *",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    hint: const Text("Select Gender"),
                    initialValue: genderValue,
                    items: genderItems.map((source) {
                      return DropdownMenuItem(
                        value: source,
                        child: Text(source),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        genderValue = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select Gender'; // Validation message
                      }
                      return null; // Valid input
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                  child: Text(
                    "Marital Status *",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    hint: const Text("Select Maritial Status"),
                    initialValue: marriedvalue,
                    items: marriageItems.map((source) {
                      return DropdownMenuItem(
                        value: source,
                        child: Text(source),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        marriedvalue = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select Maritial Status'; // Validation message
                      }
                      return null; // Valid input
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                  child: Text(
                    "Religion *",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    hint: const Text("Select Religion"),
                    initialValue: religionValue,
                    items: religionItems.map((source) {
                      return DropdownMenuItem(
                        value: source,
                        child: Text(source),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        religionValue = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select Religion'; // Validation message
                      }
                      return null; // Valid input
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 5, bottom: 5),
                  child: Text(
                    "Education *",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    hint: const Text("Select Education"),
                    initialValue: educationValue,
                    items: educationItem.map((source) {
                      return DropdownMenuItem(
                        value: source,
                        child: Text(source),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        educationValue = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select Education'; // Validation message
                      }
                      return null; // Valid input
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 5, bottom: 5),
                  child: Text(
                    "Language*",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    hint: const Text("Select Language"),
                    initialValue: languageValue,
                    items: languageItems.map((source) {
                      return DropdownMenuItem(
                        value: source,
                        child: Text(source),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        languageValue = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select Language'; // Validation message
                      }
                      return null; // Valid input
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 5, bottom: 5),
                  child: Text(
                    "Age*",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    hint: const Text("Select Age"),
                    initialValue: ageValue,
                    items: ageItems.map((source) {
                      return DropdownMenuItem(
                        value: source,
                        child: Text(source),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        ageValue = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select Age'; // Validation message
                      }
                      return null; // Valid input
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                  child: Text(
                    "Experience *",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    hint: const Text("Select Experience"),
                    initialValue: experienceValue,
                    items: experienceItems.map((source) {
                      return DropdownMenuItem(
                        value: source,
                        child: Text(source),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        experienceValue = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select Total Experience'; // Validation message
                      }
                      return null; // Valid input
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                  child: Text(
                    "Payment *",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 140),
                  child: Row(
                    children: [
                      Text(
                        "Minimum",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                      ),
                      Text(
                        "Maximum",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                sizedBoxH5,
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 100),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextFormField(
                          maxLength: 7,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "minimum payment";
                            }
                            return null;
                          },
                          controller: minimumPaymentController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 6),
                            hintText: "10000",
                            hintStyle: TextStyle(color: textGreyColor),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "to",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          maxLength: 7,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "maximum payment";
                            }
                            return null;
                          },
                          controller: maximumPaymentController,
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 6),
                            hintText: "20000",
                            hintStyle: TextStyle(color: textGreyColor),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBoxH20,
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      EmployerRegisterModel? localUserProfileData =
                          LocalStoragePref.instance?.getUserProfile();
                      if (formKey.currentState!.validate() &&
                          jobShiftvalue!.isNotEmpty &&
                          scheduleValue!.isNotEmpty) {
                        Jobpostcountminus data = await NavRepositiory()
                            .getJobPostCount(
                                categoryvalue.toString(),
                                locationController.text,
                                jobShiftvalue.toString(),
                                scheduleValue.toString(),
                                genderValue.toString(),
                                religionValue.toString(),
                                ageValue.toString(),
                                marriedvalue.toString(),
                                educationValue.toString(),
                                languageValue.toString(),
                                experienceValue.toString(),
                                minimumPaymentController.text,
                                maximumPaymentController.text,
                                localUserProfileData!.userId);

                        _homepageBloc.add(GetHomePageCategoriesEvents());
                        BlocProvider.of<PurchasedPackageDataBloc>(context,
                                listen: false)
                            .add(PurchasedPackageEvent());

                        Fluttertoast.showToast(msg: "Job Posted Successfully");

                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(msg: "All Fields are Required");
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      decoration: BoxDecoration(color: blueColor),
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: Center(
                          child: Text(
                        "Post Job",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
