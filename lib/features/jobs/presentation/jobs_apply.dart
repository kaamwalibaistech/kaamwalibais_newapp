import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/features/jobs/network/job_repository.dart';

class JobsApply extends StatefulWidget {
  final String jobsLocation;
  final String jobsType;
  final String jobsId;

  const JobsApply(
      {super.key,
      required this.jobsLocation,
      required this.jobsType,
      required this.jobsId});

  @override
  State<JobsApply> createState() => _JobsApplyState();
}

class _JobsApplyState extends State<JobsApply> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // late HomepageBloc homepageBloc;
  @override
  void initState() {
    super.initState();
    // homepageBloc = BlocProvider.of<HomepageBloc>(context);
  }

  String? validateEmail(String? email) {
    RegExp emailRegEx = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegEx.hasMatch(email ?? "");
    if (!isEmailValid) return "please  Enter a valid email";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: scaffoldColor,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back))),
        backgroundColor: scaffoldColor,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.jobsType,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    widget.jobsLocation,
                    style: TextStyle(color: textGreyColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      "Name *",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  sizedBoxH10,
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Name";
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        hintText: "Enter Full Name",
                        hintStyle: TextStyle(color: textGreyColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Phone Number *",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  sizedBoxH10,
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Phone Number";
                        }
                        return null;
                      },
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        hintText: "Enter Your Phone Number",
                        hintStyle: TextStyle(color: textGreyColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Email Address *",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  sizedBoxH10,
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      validator: validateEmail,
                      controller: emailController,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        hintText: "Enter Your Email Address",
                        hintStyle: TextStyle(color: textGreyColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "City *",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  sizedBoxH10,
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Your City";
                        }
                        return null;
                      },
                      controller: cityController,
                      decoration: InputDecoration(
                        counterText: "",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        hintText: "Enter Your City",
                        hintStyle: TextStyle(color: textGreyColor),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            JobRepository().applyJobsPost(
                                nameController.text,
                                phoneNumberController.text,
                                emailController.text,
                                cityController.text,
                                widget.jobsId);
                            Fluttertoast.showToast(msg: "Applied SuccessFully");
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: blueColor),
                          child: Center(
                              child: Text(
                            "Apply Now",
                            style: TextStyle(color: whiteColor),
                          )),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
