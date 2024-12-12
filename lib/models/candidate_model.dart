class CandidateModel {
  String? status;
  List<CandidateData>? data;

  CandidateModel({this.status, this.data});

  CandidateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CandidateData>[];
      json['data'].forEach((v) {
        data!.add(new CandidateData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CandidateData {
  String? candidateId;
  String? categoryName;
  String? mobileNo;
  String? jobType;
  String? serviceLocation;
  String? rating;
  String? aadharCard;
  String? otherDocuments;
  String? passposrt;
  String? age;
  String? maritalStatus;
  String? religion;
  String? totalExp;
  String? expectedSalary;
  String? gender;
  String? maximumEducation;
  String? workingHours;
  List<String>? language;
  String? image;
  String? alreadySorted;
  String? ratingCount;

  CandidateData(
      {this.candidateId,
      this.categoryName,
      this.mobileNo,
      this.jobType,
      this.serviceLocation,
      this.rating,
      this.aadharCard,
      this.otherDocuments,
      this.passposrt,
      this.age,
      this.maritalStatus,
      this.religion,
      this.totalExp,
      this.expectedSalary,
      this.gender,
      this.maximumEducation,
      this.workingHours,
      this.language,
      this.image,
      this.alreadySorted,
      this.ratingCount});

  CandidateData.fromJson(Map<String, dynamic> json) {
    candidateId = json['candidate_id'];
    categoryName = json['CategoryName'];
    mobileNo = json['MobileNo'];
    jobType = json['job_type'];
    serviceLocation = json['ServiceLocation'];
    rating = json['rating'];
    aadharCard = json['AadharCard'];
    otherDocuments = json['OtherDocuments'];
    passposrt = json['passposrt'];
    age = json['Age'];
    maritalStatus = json['MaritalStatus'];
    religion = json['Religion'];
    totalExp = json['TotalExp'];
    expectedSalary = json['ExpectedSalary'];
    gender = json['Gender'];
    maximumEducation = json['MaximumEducation'];
    workingHours = json['WorkingHours'];
    language = json['Language'].cast<String>();
    image = json['image'];
    alreadySorted = json['already_sorted'];
    ratingCount = json['rating_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['candidate_id'] = this.candidateId;
    data['CategoryName'] = this.categoryName;
    data['MobileNo'] = this.mobileNo;
    data['job_type'] = this.jobType;
    data['ServiceLocation'] = this.serviceLocation;
    data['rating'] = this.rating;
    data['AadharCard'] = this.aadharCard;
    data['OtherDocuments'] = this.otherDocuments;
    data['passposrt'] = this.passposrt;
    data['Age'] = this.age;
    data['MaritalStatus'] = this.maritalStatus;
    data['Religion'] = this.religion;
    data['TotalExp'] = this.totalExp;
    data['ExpectedSalary'] = this.expectedSalary;
    data['Gender'] = this.gender;
    data['MaximumEducation'] = this.maximumEducation;
    data['WorkingHours'] = this.workingHours;
    data['Language'] = this.language;
    data['image'] = this.image;
    data['already_sorted'] = this.alreadySorted;
    data['rating_count'] = this.ratingCount;
    return data;
  }
}
