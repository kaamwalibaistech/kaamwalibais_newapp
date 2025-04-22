class JobListing {
  String? status;
  List<JobData>? data;

  JobListing({this.status, this.data});

  JobListing.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <JobData>[];
      json['data'].forEach((v) {
        data!.add(new JobData.fromJson(v));
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

class JobData {
  String? jobpostId;
  String? age;
  String? gender;
  String? religion;
  String? maritalStatus;
  String? jobLocation;
  String? workingHours;
  String? experience;
  String? monthPrice;
  String? jobType;
  String? totalView;
  String? postedBy;

  JobData(
      {this.jobpostId,
      this.age,
      this.gender,
      this.religion,
      this.maritalStatus,
      this.jobLocation,
      this.workingHours,
      this.experience,
      this.monthPrice,
      this.jobType,
      this.totalView,
      this.postedBy});

  JobData.fromJson(Map<String, dynamic> json) {
    jobpostId = json['jobpost_id'];
    age = json['Age'];
    gender = json['Gender'];
    religion = json['Religion'];
    maritalStatus = json['Marital_Status'];
    jobLocation = json['job_location'];
    workingHours = json['working_hours'];
    experience = json['Experience'];
    monthPrice = json['month_price'];
    jobType = json['job_type'];
    totalView = json['total_view'];
    postedBy = json['posted_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobpost_id'] = this.jobpostId;
    data['Age'] = this.age;
    data['Gender'] = this.gender;
    data['Religion'] = this.religion;
    data['Marital_Status'] = this.maritalStatus;
    data['job_location'] = this.jobLocation;
    data['working_hours'] = this.workingHours;
    data['Experience'] = this.experience;
    data['month_price'] = this.monthPrice;
    data['job_type'] = this.jobType;
    data['total_view'] = this.totalView;
    data['posted_by'] = this.postedBy;
    return data;
  }
}
