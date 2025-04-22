class FilterListWithCountModel {
  String? title;
  String? count;

  FilterListWithCountModel({this.title, this.count});

  FilterListWithCountModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['count'] = count;
    return data;
  }
}
