import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';

class CandidateRegister extends StatefulWidget {
  const CandidateRegister({super.key});

  @override
  State<CandidateRegister> createState() => _CandidateRegisterState();
}

class _CandidateRegisterState extends State<CandidateRegister> {
  final categoryItems = [
    "Maid",
    "BabySitter",
    "Cook",
    "Nanny",
    "Elder Care",
    "Japa Maid",
    "Nurse",
    "House keepings"
  ];
  final marriageItems = ["Unmarried", "Married", "Divorce"];
  final religionItems = ["Hindu", "muslim", "Christian", "Sikh"];
  String? categoryvalue;
  String? marriedvalue;
  String? religionvalue;
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
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.93,
                  decoration: BoxDecoration(
                      border: Border.all(color: blackColor),
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const TextField(
                    // controller: _controller,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                      hintText: "Enter Full Name.",
                      hintStyle: TextStyle(color: textGreyColor),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
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
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.93,
                  decoration: BoxDecoration(
                      border: Border.all(color: blackColor),
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const TextField(
                    // controller: _controller,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                      hintText: "Enter Mobile no.",
                      hintStyle: TextStyle(color: textGreyColor),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
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
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.93,
                  decoration: BoxDecoration(
                      border: Border.all(color: blackColor),
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const TextField(
                    // controller: _controller,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                      hintText: "Enter Password",
                      hintStyle: TextStyle(color: textGreyColor),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
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
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width * 0.93,
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: blackColor)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      hint: const Text("Select Category"),
                      dropdownColor: whiteColor,
                      focusColor: whiteColor,
                      isExpanded: true,
                      value: categoryvalue,
                      items: categoryItems.map(buildMenuItem).toList(),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      onChanged: (value) =>
                          setState(() => categoryvalue = value)),
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
              //   child: Text(
              //     "Marital Status (वैवाहिक स्थिति ) *",
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Container(
              //   padding: const EdgeInsets.only(left: 10),
              //   width: MediaQuery.of(context).size.width * 0.93,
              //   decoration: BoxDecoration(
              //       color: whiteColor,
              //       borderRadius: BorderRadius.circular(10),
              //       border: Border.all(color: blackColor)),
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton(
              //         hint: const Text("Select Marital Status"),
              //         dropdownColor: whiteColor,
              //         focusColor: whiteColor,
              //         isExpanded: true,
              //         value: marriedvalue,
              //         items: marriageItems.map(buildMarriedItem).toList(),
              //         style: const TextStyle(
              //             color: Colors.black, fontWeight: FontWeight.bold),
              //         onChanged: (value) =>
              //             setState(() => marriedvalue = value)),
              //   ),
              // ),
              // const Padding(
              //   padding: EdgeInsets.only(top: 20.0, left: 5),
              //   child: Text(
              //     "Age (आयु) *",
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 5.0),
              //   child: Container(
              //     padding: const EdgeInsets.only(left: 10),
              //     height: MediaQuery.of(context).size.height * 0.06,
              //     width: MediaQuery.of(context).size.width * 0.93,
              //     decoration: BoxDecoration(
              //         border: Border.all(color: blackColor),
              //         color: whiteColor,
              //         borderRadius: BorderRadius.circular(10)),
              //     child: const TextField(
              //       // controller: _controller,
              //       decoration: InputDecoration(
              //         contentPadding:
              //             EdgeInsets.symmetric(vertical: 12, horizontal: 2),
              //         hintText: "Eg.18",
              //         hintStyle: TextStyle(color: textGreyColor),
              //         border: OutlineInputBorder(borderSide: BorderSide.none),
              //       ),
              //     ),
              //   ),
              // ),
              // const Padding(
              //   padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
              //   child: Text(
              //     "Religion (धर्म) *",
              //     style: TextStyle(fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Container(
              //   padding: const EdgeInsets.only(left: 10),
              //   width: MediaQuery.of(context).size.width * 0.93,
              //   decoration: BoxDecoration(
              //       color: whiteColor,
              //       borderRadius: BorderRadius.circular(10),
              //       border: Border.all(color: blackColor)),
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton(
              //         hint: const Text("Select Religion"),
              //         dropdownColor: whiteColor,
              //         focusColor: whiteColor,
              //         isExpanded: true,
              //         value: religionvalue,
              //         items: religionItems.map(buildReligionItem).toList(),
              //         style: const TextStyle(
              //             color: Colors.black, fontWeight: FontWeight.bold),
              //         onChanged: (value) =>
              //             setState(() => religionvalue = value)),
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String items) =>
      DropdownMenuItem(value: items, child: Text(items));

  DropdownMenuItem<String> buildMarriedItem(String marriageItems) =>
      DropdownMenuItem(value: marriageItems, child: Text(marriageItems));

  DropdownMenuItem<String> buildReligionItem(String religionItems) =>
      DropdownMenuItem(value: religionItems, child: Text(religionItems));
}
