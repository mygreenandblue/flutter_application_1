class Companys {
  List<Company> items = [];

  Companys();

  Companys.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    for (var item in jsonList) {
      final pelicula = new Company.fromJson(item);
      items.add(pelicula);
    }
  }
}

class Company {
  int? ResultId;
  String? ClassA;
  String? DescriptionA;

  Company({required this.ResultId, required this.DescriptionA, required this.ClassA});

  Company.fromJson(Map<dynamic, dynamic> json) {
    ResultId = json['ResultId'];
    ClassA = json['ClassA'];
    DescriptionA = json['DescriptionA'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassA'] = this.ClassA;
    data['DescriptionA'] = this.DescriptionA;
    data['ResultId'] = this.ResultId;
    return data;
  }
}
