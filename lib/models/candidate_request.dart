class CandidateRequest {
  String? userId;
  String? latitude;
  String? longitude;
  String? page;
  String? km;
  String? categoryId;
  String? minSalry;
  String? maxSalary;
  String? passport;
  String? minAge;
  String? maxAge;
  String? minExp;
  String? maxExp;
  String? gender;
  String? workingHours;
  String? religon;
  String? language;
  String? sortBy;

  CandidateRequest(
      {this.userId,
      this.latitude,
      this.longitude,
      this.page,
      this.km,
      this.categoryId,
      this.minSalry,
      this.maxSalary,
      this.passport,
      this.minAge,
      this.maxAge,
      this.minExp,
      this.maxExp,
      this.gender,
      this.workingHours,
      this.religon,
      this.language,
      this.sortBy});

  CandidateRequest.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    page = json['page'];
    km = json['km'];
    categoryId = json['CategoryId'];
    minSalry = json['min_salry'];
    maxSalary = json['max_salary'];
    passport = json['passport'];
    minAge = json['min_age'];
    maxAge = json['max_age'];
    minExp = json['min_exp'];
    maxExp = json['max_exp'];
    gender = json['gender'];
    workingHours = json['working_hours'];
    religon = json['religon'];
    language = json['language'];
    sortBy = json['sort_by'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['UserId'] = userId ?? '';
    data['latitude'] = latitude ?? '';
    data['longitude'] = longitude ?? '';
    data['page'] = page ?? '';
    data['km'] = km ?? '';
    data['CategoryId'] = categoryId ?? '';
    data['min_salry'] = minSalry ?? '';
    data['max_salary'] = maxSalary ?? '';
    data['passport'] = passport ?? '';
    data['min_age'] = minAge ?? '';
    data['max_age'] = maxAge ?? '';
    data['min_exp'] = minExp ?? '';
    data['max_exp'] = maxExp ?? '';
    data['gender'] = gender ?? '';
    data['working_hours'] = workingHours ?? '';
    data['religon'] = religon ?? '';
    data['language'] = language ?? '';
    data['sort_by'] = sortBy ?? '';
    return data;
  }
}
