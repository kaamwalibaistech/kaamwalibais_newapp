class CandidateModel {
  String? status;
  List<CandidateData>? data;

  CandidateModel({this.status, this.data});

  CandidateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CandidateData>[];
      json['data'].forEach((v) {
        data!.add(CandidateData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['candidate_id'] = candidateId;
    data['CategoryName'] = categoryName;
    data['MobileNo'] = mobileNo;
    data['job_type'] = jobType;
    data['ServiceLocation'] = serviceLocation;
    data['rating'] = rating;
    data['AadharCard'] = aadharCard;
    data['OtherDocuments'] = otherDocuments;
    data['passposrt'] = passposrt;
    data['Age'] = age;
    data['MaritalStatus'] = maritalStatus;
    data['Religion'] = religion;
    data['TotalExp'] = totalExp;
    data['ExpectedSalary'] = expectedSalary;
    data['Gender'] = gender;
    data['MaximumEducation'] = maximumEducation;
    data['WorkingHours'] = workingHours;
    data['Language'] = language;
    data['image'] = image;
    data['already_sorted'] = alreadySorted;
    data['rating_count'] = ratingCount;
    return data;
  }
}
