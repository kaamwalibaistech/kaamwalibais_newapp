import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/models/categorylist.dart';

import '../../../models/empolyer_registerotp_model.dart';
import '../network/auth_repository.dart';
import 'candidate_register_otpscreen.dart';

class CandidateRegister extends StatefulWidget {
  const CandidateRegister({super.key});

  @override
  State<CandidateRegister> createState() => _CandidateRegisterState();
}

enum Passport { Yes, No }

enum Language { English, Hindi, Marathi }

class _CandidateRegisterState extends State<CandidateRegister> {
  final _formKey = GlobalKey<FormState>();
  String? passport = "";
  String? language = "";
  Categorylistmodel? categoryitemModel;

  final marriageItems = ["Unmarried", "Married", "Divorce"];
  final religionItems = ["Hindu", "muslim", "Christian", "Sikh"];

  final genderItems = ["Male", "Female", "Not prefer to say"];
  final educationItem = ["<5th", ">5th", ">10"];
  final timingItem = [
    "Morning Shift",
    "Afternoon Shift",
    "Evening Shift",
    "Night Shift",
  ];

  @override
  void initState() {
    super.initState();
    loadCategoryUpload();
  }

  Future<void> loadCategoryUpload() async {
    final categorydata = await AuthRepository().getcategorynameid();
    setState(() {
      categoryitemModel = categorydata;
    });
  }

  final workingItem = [
    "1 Hours", // hours
    "2 Hours", "3 Hours", "4 Hours", "5 Hours", "6 Hours", "7 Hours", "8 Hours",
    "9 Hours", "10 Hours", "11 Hours", "12 Hours", "24 Hours"
  ];
  final expectedSalaryItem = [
    "1000",
    "2000",
    "3000",
    "4000",
    "5000",
    "6000",
    "7000",
    "8000",
    "9000",
    "10000",
    "11000",
    "12000",
    "13000",
    "14000",
    "15000",
    "16000",
    "17000",
    "18000",
    "19000",
    "20000"
  ];
  final totalExperienceItem = [
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

  String? categoryvalue;
  String? marriedvalue;
  String? religionvalue;
  String? genderValue;
  Passport? passportSelected;
  Language? languageSelected;
  String? educationValue;
  String? timingValue;
  String? workingHrsValue;
  String? expectedSalaryValue;
  String? totalExperienceValue;
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  String? validateEmail(String? email) {
    RegExp emailRegEx = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegEx.hasMatch(email ?? "");
    if (!isEmailValid) return "please  Enter a valid email";
    return null;
  }

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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                      child: Text(
                    "APPLY FOR A JOB",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      "ध्यान दें: नौकरी के लिए आवेदन करने के बाद प्रतीक्षा करें। कामवाली जॉब्स के अधिकारी यथाशीघ्र आपसे संपर्क करेंगे.",
                      style: TextStyle(
                        fontSize: 15,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 5),
                    child: Text(
                      "Full Name (नाम) *",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.93,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Full Name";
                          }
                          return null;
                        },
                        controller: nameController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                          hintText: "Enter Full Name.",
                          hintStyle: TextStyle(color: textGreyColor),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 5),
                    child: Text(
                      "Mobile No. (मोबाइल नंबर) *",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.93,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone number should be 10 in digits";
                          }
                          return null;
                        },
                        controller: numberController,
                        maxLength: 10,
                        decoration: InputDecoration(
                          counterText: "",
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                          hintText: "Enter Mobile no.",
                          hintStyle: TextStyle(color: textGreyColor),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 5),
                    child: Text(
                      "Email. (ईमेल) *",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.93,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                        controller: emailController,
                        // maxLength: 10,
                        decoration: InputDecoration(
                          counterText: "",
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                          hintText: "Enter Email.",
                          hintStyle: TextStyle(color: textGreyColor),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 5),
                    child: Text(
                      "Password *",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.93,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty && value.split("").length < 6) {
                            return "Enter Password";
                          }
                          return null;
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                          hintText: "Enter Password",
                          hintStyle: TextStyle(color: textGreyColor),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                    child: Text(
                      "Category (वर्ग)*",
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
                      hint: const Text("Select Category"),
                      value: categoryvalue,
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
                    padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                    child: Text(
                      "Marital Status (वैवाहिक स्थिति ) *",
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
                      value: marriedvalue,
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
                    padding: EdgeInsets.only(top: 20.0, left: 5),
                    child: Text(
                      "Age (आयु) *",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.93,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Age";
                          }
                          return null;
                        },
                        controller: ageController,
                        decoration: InputDecoration(
                          counterText: "",
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                          hintText: "Eg.18",
                          hintStyle: TextStyle(color: textGreyColor),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                    child: Text(
                      "Religion (धर्म) *",
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
                      value: religionvalue,
                      items: religionItems.map((source) {
                        return DropdownMenuItem(
                          value: source,
                          child: Text(source),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          religionvalue = newValue!;
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
                      value: genderValue,
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
                      "Passport (पारपत्र ) *",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                            activeColor: selectionGreenColor,
                            value: Passport.Yes,
                            groupValue: passportSelected,
                            onChanged: (value) {
                              setState(() {
                                passportSelected = value;
                                passport = value!.name;
                              });
                            },
                          ),
                          const Text(
                            'Yes',
                            style: TextStyle(
                                fontFamily: "Arial",
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF2F2F2F)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: selectionGreenColor,
                            value: Passport.No,
                            groupValue: passportSelected,
                            onChanged: (value) {
                              setState(() {
                                passportSelected = value;
                                passport = value!.name;
                              });
                            },
                          ),
                          const Text(
                            'No',
                            style: TextStyle(
                                fontFamily: "Arial",
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF2F2F2F)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0, left: 5, bottom: 5),
                    child: Text(
                      "Education (शिक्षा) *",
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
                      value: educationValue,
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
                    padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                    child: Text(
                      "Timing (समय) *",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      hint: const Text("Select Timing"),
                      value: timingValue,
                      items: timingItem.map((source) {
                        return DropdownMenuItem(
                          value: source,
                          child: Text(source),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          timingValue = newValue!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select Timing'; // Validation message
                        }
                        return null; // Valid input
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                    child: Text(
                      "Working Hrs (कार्य घंटे) *",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      hint: const Text("Select Working Hours"),
                      value: workingHrsValue,
                      items: workingItem.map((source) {
                        return DropdownMenuItem(
                          value: source,
                          child: Text(source),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          workingHrsValue = newValue!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select Working Hours'; // Validation message
                        }
                        return null; // Valid input
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                    child: Text(
                      "Address (पता) *",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.93,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Address";
                        }
                        return null;
                      },
                      controller: addressController,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: whiteColor,
                        border: OutlineInputBorder(),
                        hintText: 'Home Address',
                        hintStyle: const TextStyle(
                          color: textGreyColor4,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: "Arial",
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 6),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: blackColor,
                            width: 0.80,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: blackColor,
                            width: 0.80,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      maxLines: 3,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                    child: Text(
                      "Work Location (कार्यस्थल) *",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.93,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Work Location";
                        }
                        return null;
                      },
                      controller: locationController,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: whiteColor,
                        border: OutlineInputBorder(),
                        hintText: 'Enter Work Location',
                        hintStyle: const TextStyle(
                          color: textGreyColor4,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: "Arial",
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 6),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: blackColor,
                            width: 0.80,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: blackColor,
                            width: 0.80,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      // maxLines: 2,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                    child: Text(
                      "Expected Salary (अपेक्षित वेतन) *",
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
                      hint: const Text("Select Expected Salary"),
                      value: expectedSalaryValue,
                      items: expectedSalaryItem.map((source) {
                        return DropdownMenuItem(
                          value: source,
                          child: Text(source),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          expectedSalaryValue = newValue!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select Expected Salary'; // Validation message
                        }
                        return null; // Valid input
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
                    child: Text(
                      "Total Experience (कुल अनुभव) *",
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
                      value: totalExperienceValue,
                      items: totalExperienceItem.map((source) {
                        return DropdownMenuItem(
                          value: source,
                          child: Text(source),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          totalExperienceValue = newValue!;
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
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(
                      "Which languages do you know? (तुम कौन सी भाषा जानते हो) ",
                      style: TextStyle(
                        fontFamily: "Arial",
                        fontSize: 14,
                        color: blackColor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                            activeColor: selectionGreenColor,
                            value: Language.English,
                            groupValue: languageSelected,
                            onChanged: (value) {
                              setState(() {
                                languageSelected = value;
                                language = value!.name;
                              });
                            },
                          ),
                          const Text(
                            'English',
                            style: TextStyle(
                                fontFamily: "Arial",
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF2F2F2F)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: selectionGreenColor,
                            value: Language.Hindi,
                            groupValue: languageSelected,
                            onChanged: (value) {
                              setState(() {
                                languageSelected = value;
                                language = value!.name;
                              });
                            },
                          ),
                          const Text(
                            'Hindi',
                            style: TextStyle(
                                fontFamily: "Arial",
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF2F2F2F)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: selectionGreenColor,
                            value: Language.Marathi,
                            groupValue: languageSelected,
                            onChanged: (value) {
                              setState(() {
                                languageSelected = value;
                                language = value!.name;
                              });
                            },
                          ),
                          const Text(
                            'Marathi',
                            style: TextStyle(
                                fontFamily: "Arial",
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF2F2F2F)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     const Padding(
                  //       padding: EdgeInsets.only(left: 20.0, top: 15.0),
                  //       child: Text(
                  //         "Upload Image (तस्वीर डालिये) *",
                  //         style: TextStyle(
                  //           fontFamily: "Arial",
                  //           fontSize: 13,
                  //           color: blackColor,
                  //         ),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(
                  //           left: 14.0, right: 14.0, top: 8.0),
                  //       child: Row(
                  //         children: [
                  //           Expanded(
                  //             child: Container(
                  //               width: double.infinity,
                  //               decoration: BoxDecoration(
                  //                 color: whiteColor,
                  //                 borderRadius:
                  //                     const BorderRadius.all(Radius.circular(10.0)),
                  //                 border: Border.all(
                  //                   color: Colors.grey,
                  //                   width: 0.80,
                  //                 ),
                  //               ),
                  //               child: InkWell(
                  //                 onTap: () {
                  //                   setState(() {
                  //                     imageStatus = 3;
                  //                   });
                  //                   selectImageDialog(context);
                  //                 },
                  //                 child: Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Expanded(
                  //                       child: Padding(
                  //                         padding: const EdgeInsets.only(left: 8.0),
                  //                         child: Text(
                  //                           otherDoc != null
                  //                               ? otherDoc!
                  //                               : "No file found",
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Container(
                  //                       width: 70,
                  //                       height: 48,
                  //                       decoration: const BoxDecoration(
                  //                         color: Color(0xFF006DCF),
                  //                         borderRadius: BorderRadius.only(
                  //                           topRight: Radius.circular(8.0),
                  //                           bottomRight: Radius.circular(8.0),
                  //                         ),
                  //                       ),
                  //                       child: const Center(
                  //                         child: Text(
                  //                           'Browse',
                  //                           style: TextStyle(
                  //                             fontWeight: FontWeight.normal,
                  //                             fontFamily: "Arial",
                  //                             fontSize: 13,
                  //                             color: whiteColor,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        if (_formKey.currentState!.validate() &&
                            nameController.text.isNotEmpty &&
                            numberController.text.isNotEmpty &&
                            emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty &&
                            categoryvalue!.isNotEmpty &&
                            marriedvalue!.isNotEmpty &&
                            religionvalue!.isNotEmpty &&
                            genderValue!.isNotEmpty &&
                            passportSelected!.name.isNotEmpty &&
                            educationValue!.isNotEmpty &&
                            timingValue!.isNotEmpty &&
                            workingHrsValue!.isNotEmpty &&
                            ageController.text.isNotEmpty &&
                            addressController.text.isNotEmpty &&
                            locationController.text.isNotEmpty &&
                            expectedSalaryValue!.isNotEmpty &&
                            totalExperienceValue!.isNotEmpty &&
                            languageSelected!.name.isNotEmpty) {
                          Otp? otp = await AuthRepository()
                              .getEmployerRegisterOtp(numberController.text);
                          if (otp != null && otp.status == '200') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CandidateRegisterOtpScreen(
                                            name: nameController.text,
                                            mobileNo: numberController.text,
                                            password: passwordController.text,
                                            email: emailController.text,
                                            category: categoryvalue,
                                            maritalStatus: marriedvalue,
                                            age: ageController.text,
                                            religion: religionvalue,
                                            gender: genderValue,
                                            passport: passport.toString(),
                                            education: educationValue,
                                            timing: timingValue,
                                            workingHrs: workingHrsValue,
                                            address: addressController.text,
                                            location: locationController.text,
                                            expectedSalary: expectedSalaryValue,
                                            totalExperience:
                                                totalExperienceValue,
                                            launguage: language.toString(),
                                            otp: otp)));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Mobile Number is Already Registered')));
                          }
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: MediaQuery.of(context).size.width * 0.50,
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(10)),
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: Center(
                          child: Text(
                            "Submit",
                            style: GoogleFonts.poltawskiNowy(
                                color: whiteColor, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void selectImageDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return SimpleDialog(
  //           backgroundColor: Colors.white,
  //           contentPadding: const EdgeInsets.symmetric(horizontal: 20),
  //           titlePadding:
  //               const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
  //           title: const Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: <Widget>[
  //               Text(
  //                 'Select Image',
  //                 style: TextStyle(
  //                     color: blueColor,
  //                     fontWeight: FontWeight.w500,
  //                     fontSize: 15),
  //               ),
  //               Divider(
  //                 thickness: 1,
  //                 color: Colors.black26,
  //               ),
  //             ],
  //           ),
  //           children: <Widget>[
  //             Padding(
  //               padding: const EdgeInsets.only(bottom: 20.0),
  //               child: InkWell(
  //                 onTap: () async {
  //                   pickImageCamera();
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Row(
  //                   children: [
  //                     Icon(
  //                       Icons.camera_alt,
  //                       size: 25,
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 8.0),
  //                       child: Text(
  //                         'Camera',
  //                         style: TextStyle(
  //                             color: blueColor,
  //                             fontWeight: FontWeight.w500,
  //                             fontSize: 15),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.only(bottom: 20.0),
  //               child: InkWell(
  //                 onTap: () async {
  //                   pickImage();
  //                   Navigator.pop(context);
  //                 },
  //                 child: const Row(
  //                   children: [
  //                     Icon(
  //                       Icons.image,
  //                       size: 25,
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 8.0),
  //                       child: Text(
  //                         'Pick image from gallery',
  //                         style: TextStyle(
  //                             color: blueColor,
  //                             fontWeight: FontWeight.w500,
  //                             fontSize: 15),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         );
  //       });
  // }

  // void pickImageCamera() async {
  //   _pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

  //   CroppedFile? croppedFile = await ImageCropper().cropImage(
  //     sourcePath: _pickedFile!.path,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //     ],
  //     uiSettings: [
  //       AndroidUiSettings(
  //           toolbarTitle: 'Cropper',
  //           toolbarColor: primaryColor,
  //           toolbarWidgetColor: Colors.white,
  //           hideBottomControls: true,
  //           // initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: true),
  //       IOSUiSettings(
  //         title: 'Cropper',
  //       ),
  //     ],
  //     compressQuality: 60,
  //   );

  //   _pickedFile = XFile(croppedFile!.path);

  //   if (imageStatus == 2) {
  //     aadhaar = _pickedFile!.name;
  //     aadharFile = _pickedFile;
  //   } else if (imageStatus == 3) {
  //     otherDoc = _pickedFile!.name;
  //     Image = _pickedFile;
  //   }

  //   setState(() {});
  // }

  // void pickImage() async {
  //   _pickedFile = (await ImagePicker().pickImage(source: ImageSource.gallery))!;

  //   CroppedFile? croppedFile = await ImageCropper().cropImage(
  //     sourcePath: _pickedFile!.path,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //     ],
  //     uiSettings: [
  //       AndroidUiSettings(
  //           toolbarTitle: 'Cropper',
  //           toolbarColor: primaryColor,
  //           toolbarWidgetColor: Colors.white,
  //           hideBottomControls: true,
  //           // initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: true),
  //       IOSUiSettings(
  //         title: 'Cropper',
  //       ),
  //     ],
  //     compressQuality: 80,
  //   );
  //   _pickedFile = XFile(croppedFile!.path);

  //   if (imageStatus == 2) {
  //     aadhaar = _pickedFile!.name;
  //     aadharFile = _pickedFile;
  //   } else if (imageStatus == 3) {
  //     otherDoc = _pickedFile!.name;
  //     Image = _pickedFile;
  //   }
  //   setState(() {});
  // }

  DropdownMenuItem<String> buildMarriedItem(String marriageItems) =>
      DropdownMenuItem(value: marriageItems, child: Text(marriageItems));

  DropdownMenuItem<String> buildReligionItem(String religionItems) =>
      DropdownMenuItem(value: religionItems, child: Text(religionItems));

  DropdownMenuItem<String> buildGenderItems(String genderItems) =>
      DropdownMenuItem(value: genderItems, child: Text(genderItems));

  DropdownMenuItem<String> buildEducationItems(String educationItem) =>
      DropdownMenuItem(value: educationItem, child: Text(educationItem));

  DropdownMenuItem<String> buildTimingItems(String timingItem) =>
      DropdownMenuItem(value: timingItem, child: Text(timingItem));
  DropdownMenuItem<String> buildWorkingHrsItems(String timingItem) =>
      DropdownMenuItem(value: timingItem, child: Text(timingItem));

  DropdownMenuItem<String> buildExpectedSalaryItems(
          String expectedSalaryItem) =>
      DropdownMenuItem(
          value: expectedSalaryItem, child: Text(expectedSalaryItem));

  DropdownMenuItem<String> buildTotalExperienceItems(
          String totalExperienceItem) =>
      DropdownMenuItem(
          value: totalExperienceItem, child: Text(totalExperienceItem));
}
