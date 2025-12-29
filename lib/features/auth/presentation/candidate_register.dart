import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
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
  final religionItems = ["Hindu", "Muslim", "Catholic"];
  final genderItems = ["Male", "Female", "Not prefer to say"];
  final educationItem = ["<5th", ">5th", ">10"];
  final timingItem = [
    "Morning Shift",
    "Afternoon Shift",
    "Evening Shift",
    "Night Shift"
  ];
  final workingItem = [
    "2 Hours",
    "4 Hours",
    "6 Hours",
    "8 Hours",
    "10 Hours",
    "12 Hours",
    "24 Hours"
  ];
  final below6HoursSalaryItem = [
    "1000",
    "2000",
    "3000",
    "4000",
    "5000",
    "6000",
    "7000",
    "8000",
    "9000",
    "10000"
  ];
  final above6HoursSalaryItem = [
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

  List<String> categoryvalue = [];
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

  bool _obscurePassword = true;
  Otp? otp;

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

  InputDecoration buildInputDecoration(String hint) {
    return InputDecoration(
      counterText: "",
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade600),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: blueColor, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  "APPLY FOR A JOB",
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "ध्यान दें: नौकरी के लिए आवेदन करने के बाद प्रतीक्षा करें। कामवाली जॉब्स के अधिकारी यथाशीघ्र आपसे संपर्क करेंगे.",
                    style: TextStyle(fontSize: 14, color: primaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),

                // Name
                buildTextField("Full Name (नाम) *", nameController,
                    validator: (v) {
                  if (v!.isEmpty) return "Enter Full Name";
                  return null;
                }),

                // Mobile
                buildTextField("Mobile No. (मोबाइल नंबर) *", numberController,
                    maxLength: 10,
                    keyboardType: TextInputType.phone, validator: (v) {
                  if (v!.isEmpty || v.length != 10)
                    return "Enter 10 digit number";
                  return null;
                }),

                // Email
                buildTextField("Email (ईमेल)", emailController,
                    keyboardType: TextInputType.emailAddress),

                // Password
                buildTextField(
                  "Create Password (पासवर्ड बनाएं) *",
                  passwordController,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (v) {
                    if (v!.isEmpty || v.length < 6)
                      return "Password min 6 characters";
                    return null;
                  },
                ),

                // Category
                const SizedBox(height: 15),
                buildSectionTitle("Category (वर्ग) *"),
                buildCategorySelector(),

                // Marital Status
                buildDropdown(
                    "Marital Status (वैवाहिक स्थिति ) *",
                    marriedvalue,
                    marriageItems,
                    (v) => setState(() => marriedvalue = v),
                    validator: (v) =>
                        v == null ? "Select Marital Status" : null),

                // Age
                buildTextField("Age (आयु) *", ageController,
                    keyboardType: TextInputType.number,
                    maxLength: 3, validator: (v) {
                  if (v!.isEmpty) return "Enter Age";
                  if (int.parse(v) < 18) return "Age must be >=18";
                  return null;
                }),

                // Religion
                buildDropdown("Religion (धर्म) *", religionvalue, religionItems,
                    (v) => setState(() => religionvalue = v),
                    validator: (v) => v == null ? "Select Religion" : null),

                // Gender
                buildDropdown("Gender (लिंग) *", genderValue, genderItems,
                    (v) => setState(() => genderValue = v),
                    validator: (v) => v == null ? "Select Gender" : null),

                // Passport
                buildSectionTitle("Passport (पारपत्र)"),
                Row(
                  children: Passport.values.map((p) {
                    return Row(
                      children: [
                        Radio(
                          activeColor: selectionGreenColor,
                          value: p,
                          groupValue: passportSelected,
                          onChanged: (val) => setState(() {
                            passportSelected = val;
                            passport = val!.name;
                          }),
                        ),
                        Text(p.name, style: TextStyle(fontSize: 14))
                      ],
                    );
                  }).toList(),
                ),

                // Education
                buildDropdown("Education (शिक्षा) *", educationValue,
                    educationItem, (v) => setState(() => educationValue = v),
                    validator: (v) => v == null ? "Select Education" : null),

                // Working Hrs
                buildDropdown(
                    "Working Hrs (कार्य घंटे) *",
                    workingHrsValue,
                    workingItem,
                    (v) => setState(() {
                          workingHrsValue = v;
                          expectedSalaryValue = null;
                        }),
                    validator: (v) =>
                        v == null ? "Select Working Hours" : null),

                // Work Location
                buildTextField(
                    "Work Location (कार्यस्थल) *", locationController,
                    validator: (v) =>
                        v!.isEmpty ? "Enter Work Location" : null),

                // Expected Salary
                buildDropdown(
                  "Expected Salary (अपेक्षित वेतन) *",
                  expectedSalaryValue,
                  workingHrsValue != null &&
                          ["2 Hours", "4 Hours", "6 Hours"]
                              .contains(workingHrsValue)
                      ? below6HoursSalaryItem
                      : above6HoursSalaryItem,
                  (v) => setState(() => expectedSalaryValue = v),
                  validator: (v) => v == null ? "Select Expected Salary" : null,
                ),

                // Total Experience
                buildDropdown(
                    "Total Experience (कुल अनुभव) *",
                    totalExperienceValue,
                    totalExperienceItem,
                    (v) => setState(() => totalExperienceValue = v),
                    validator: (v) =>
                        v == null ? "Select Total Experience" : null),

                // Languages
                buildSectionTitle(
                    "Which languages do you know? (तुम कौन सी भाषा जानते हो)"),
                Row(
                  children: Language.values.map((l) {
                    return Row(
                      children: [
                        Radio(
                          activeColor: selectionGreenColor,
                          value: l,
                          groupValue: languageSelected,
                          onChanged: (val) => setState(() {
                            languageSelected = val;
                            language = val!.name;
                          }),
                        ),
                        Text(l.name, style: TextStyle(fontSize: 14))
                      ],
                    );
                  }).toList(),
                ),

                const SizedBox(height: 20),

                // Submit Button
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        EasyLoading.show();

                        otp = await AuthRepository()
                            .getEmployerRegisterOtp(numberController.text);

                        if (otp != null && otp!.status == '200') {
                          EasyLoading.dismiss();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CandidateRegisterOtpScreen(
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
                                workingHrs: workingHrsValue,
                                location: locationController.text,
                                expectedSalary: expectedSalaryValue,
                                totalExperience: totalExperienceValue,
                                launguage: language.toString(),
                                otp: otp,
                              ),
                            ),
                          );
                        } else {
                          EasyLoading.dismiss();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                otp?.msg ??
                                    "Something went wrong. Please try again.",
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      } catch (e) {
                        EasyLoading.dismiss();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Error: ${e.toString()}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                          colors: [blueColor, Colors.blueAccent]),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.shade200,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {bool obscureText = false,
      Widget? suffixIcon,
      TextInputType? keyboardType,
      int? maxLength,
      String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        buildSectionTitle(label),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLength: maxLength,
          validator: validator,
          decoration:
              buildInputDecoration(label).copyWith(suffixIcon: suffixIcon),
        ),
      ],
    );
  }

  Widget buildDropdown(String label, String? value, List<String> items,
      void Function(String?) onChanged,
      {String? Function(String?)? validator}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        buildSectionTitle(label),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          initialValue: value,
          decoration: buildInputDecoration("").copyWith(hintText: label),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Text(title,
          style:
              GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14)),
    );
  }

  Widget buildCategorySelector() {
    return FormField<List<String>>(
      validator: (value) =>
          categoryvalue.isEmpty ? 'Select at least one category' : null,
      builder: (formState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    List<String> tempSelectedCategories =
                        List.from(categoryvalue);
                    return AlertDialog(
                      title: const Text("Select Categories"),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: categoryitemModel == null
                            ? const Center(child: CircularProgressIndicator())
                            : StatefulBuilder(
                                builder: (context, setStateDialog) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: categoryitemModel!.data.length,
                                  itemBuilder: (context, index) {
                                    final category =
                                        categoryitemModel!.data[index];
                                    return CheckboxListTile(
                                      title: Text(category.categoryName),
                                      value: tempSelectedCategories
                                          .contains(category.categoryId),
                                      onChanged: (bool? value) {
                                        setStateDialog(() {
                                          if (value == true) {
                                            tempSelectedCategories
                                                .add(category.categoryId);
                                          } else {
                                            tempSelectedCategories
                                                .remove(category.categoryId);
                                          }
                                        });
                                      },
                                    );
                                  },
                                );
                              }),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel")),
                        TextButton(
                            onPressed: () {
                              setState(
                                  () => categoryvalue = tempSelectedCategories);
                              formState.didChange(categoryvalue);
                              Navigator.pop(context);
                            },
                            child: const Text("Done"))
                      ],
                    );
                  },
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: formState.hasError
                          ? Colors.red
                          : Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        categoryvalue.isEmpty
                            ? "Select Category"
                            : _getSelectedCategoryNames(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            if (formState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 4),
                child: Text(formState.errorText!,
                    style: const TextStyle(color: Colors.red, fontSize: 12)),
              ),
          ],
        );
      },
    );
  }

  String _getSelectedCategoryNames() {
    if (categoryitemModel == null) return "";
    List<String> names = [];
    for (String categoryId in categoryvalue) {
      for (var category in categoryitemModel!.data) {
        if (category.categoryId == categoryId) {
          names.add(category.categoryName);
          break;
        }
      }
    }
    return names.join(", ");
  }
}
