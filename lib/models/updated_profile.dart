// To parse this JSON data, do
//
//     final userUpdatedprofilemodel = userUpdatedprofilemodelFromJson(jsonString);

import 'dart:convert';

UserUpdatedprofilemodel userUpdatedprofilemodelFromJson(String str) =>
    UserUpdatedprofilemodel.fromJson(json.decode(str));

String userUpdatedprofilemodelToJson(UserUpdatedprofilemodel data) =>
    json.encode(data.toJson());

class UserUpdatedprofilemodel {
  String status;
  List<Employer> employer;
  List<Candidate> candidate;
  List<dynamic> agent;

  UserUpdatedprofilemodel({
    required this.status,
    required this.employer,
    required this.candidate,
    required this.agent,
  });

  factory UserUpdatedprofilemodel.fromJson(Map<String, dynamic> json) =>
      UserUpdatedprofilemodel(
        status: json["status"],
        employer: List<Employer>.from(
            json["employer"].map((x) => Employer.fromJson(x))),
        candidate: List<Candidate>.from(
            json["candidate"].map((x) => Candidate.fromJson(x))),
        agent: List<dynamic>.from(json["agent"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "employer": List<dynamic>.from(employer.map((x) => x.toJson())),
        "candidate": List<dynamic>.from(candidate.map((x) => x.toJson())),
        "agent": List<dynamic>.from(agent.map((x) => x)),
      };
}

class Candidate {
  String userId;
  String name;
  String mobileNo;
  String emailId;
  String contactAddress;
  String serviceLocation;
  String age;
  String gender;
  String maritalStatus;
  String maximumEducation;
  String religion;
  List<JobType> jobType;
  String totalExp;
  String workingHours;
  String expectedSalary;
  String passport;
  String isCoupleAvailable;
  String flag;
  String status;
  String profileUpdate;
  String image;
  String aadhaarCard;
  String otherDoc;
  String resume;
  List<String> language;

  Candidate({
    required this.userId,
    required this.name,
    required this.mobileNo,
    required this.emailId,
    required this.contactAddress,
    required this.serviceLocation,
    required this.age,
    required this.gender,
    required this.maritalStatus,
    required this.maximumEducation,
    required this.religion,
    required this.jobType,
    required this.totalExp,
    required this.workingHours,
    required this.expectedSalary,
    required this.passport,
    required this.isCoupleAvailable,
    required this.flag,
    required this.status,
    required this.profileUpdate,
    required this.image,
    required this.aadhaarCard,
    required this.otherDoc,
    required this.resume,
    required this.language,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        userId: json["UserId"],
        name: json["Name"],
        mobileNo: json["MobileNo"],
        emailId: json["EmailId"],
        contactAddress: json["ContactAddress"],
        serviceLocation: json["ServiceLocation"],
        age: json["Age"],
        gender: json["Gender"],
        maritalStatus: json["MaritalStatus"],
        maximumEducation: json["MaximumEducation"],
        religion: json["Religion"],
        jobType: List<JobType>.from(
            json["Job_type"].map((x) => JobType.fromJson(x))),
        totalExp: json["TotalExp"],
        workingHours: json["WorkingHours"],
        expectedSalary: json["ExpectedSalary"],
        passport: json["Passport"],
        isCoupleAvailable: json["IsCoupleAvailable"],
        flag: json["flag"],
        status: json["Status"],
        profileUpdate: json["profile_update"],
        image: json["Image"],
        aadhaarCard: json["aadhaar_card"],
        otherDoc: json["other_doc"],
        resume: json["resume"],
        language: List<String>.from(json["Language"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "UserId": userId,
        "Name": name,
        "MobileNo": mobileNo,
        "EmailId": emailId,
        "ContactAddress": contactAddress,
        "ServiceLocation": serviceLocation,
        "Age": age,
        "Gender": gender,
        "MaritalStatus": maritalStatus,
        "MaximumEducation": maximumEducation,
        "Religion": religion,
        "Job_type": List<dynamic>.from(jobType.map((x) => x.toJson())),
        "TotalExp": totalExp,
        "WorkingHours": workingHours,
        "ExpectedSalary": expectedSalary,
        "Passport": passport,
        "IsCoupleAvailable": isCoupleAvailable,
        "flag": flag,
        "Status": status,
        "profile_update": profileUpdate,
        "Image": image,
        "aadhaar_card": aadhaarCard,
        "other_doc": otherDoc,
        "resume": resume,
        "Language": List<dynamic>.from(language.map((x) => x)),
      };
}

class JobType {
  String categoryid;
  String catgoryName;

  JobType({
    required this.categoryid,
    required this.catgoryName,
  });

  factory JobType.fromJson(Map<String, dynamic> json) => JobType(
        categoryid: json["Categoryid"],
        catgoryName: json["Catgory_name"],
      );

  Map<String, dynamic> toJson() => {
        "Categoryid": categoryid,
        "Catgory_name": catgoryName,
      };
}

class Employer {
  String userId;
  String name;
  String mobileNo;
  String emailId;
  String flag;
  dynamic address;
  dynamic state;
  dynamic city;
  dynamic pinCode;
  dynamic companyName;
  dynamic gstNo;
  String status;
  String profileUpdate;
  String aadhaarCard;
  String panCard;

  Employer({
    required this.userId,
    required this.name,
    required this.mobileNo,
    required this.emailId,
    required this.flag,
    required this.address,
    required this.state,
    required this.city,
    required this.pinCode,
    required this.companyName,
    required this.gstNo,
    required this.status,
    required this.profileUpdate,
    required this.aadhaarCard,
    required this.panCard,
  });

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
        userId: json["UserId"],
        name: json["Name"],
        mobileNo: json["MobileNo"],
        emailId: json["EmailId"],
        flag: json["flag"],
        address: json["Address"],
        state: json["State"],
        city: json["City"],
        pinCode: json["PinCode"],
        companyName: json["CompanyName"],
        gstNo: json["GSTNo"],
        status: json["Status"],
        profileUpdate: json["profile_update"],
        aadhaarCard: json["aadhaar_card"],
        panCard: json["pan_card"],
      );

  Map<String, dynamic> toJson() => {
        "UserId": userId,
        "Name": name,
        "MobileNo": mobileNo,
        "EmailId": emailId,
        "flag": flag,
        "Address": address,
        "State": state,
        "City": city,
        "PinCode": pinCode,
        "CompanyName": companyName,
        "GSTNo": gstNo,
        "Status": status,
        "profile_update": profileUpdate,
        "aadhaar_card": aadhaarCard,
        "pan_card": panCard,
      };
}
