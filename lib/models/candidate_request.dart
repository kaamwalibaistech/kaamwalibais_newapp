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
    final Map<String, String> data = Map<String, String>();
    data['UserId'] = this.userId ?? '';
    data['latitude'] = this.latitude ?? '';
    data['longitude'] = this.longitude ?? '';
    data['page'] = this.page ?? '';
    data['km'] = this.km ?? '';
    data['CategoryId'] = this.categoryId ?? '';
    data['min_salry'] = this.minSalry ?? '';
    data['max_salary'] = this.maxSalary ?? '';
    data['passport'] = this.passport ?? '';
    data['min_age'] = this.minAge ?? '';
    data['max_age'] = this.maxAge ?? '';
    data['min_exp'] = this.minExp ?? '';
    data['max_exp'] = this.maxExp ?? '';
    data['gender'] = this.gender ?? '';
    data['working_hours'] = this.workingHours ?? '';
    data['religon'] = this.religon ?? '';
    data['language'] = this.language ?? '';
    data['sort_by'] = this.sortBy ?? '';
    return data;
  }
}
