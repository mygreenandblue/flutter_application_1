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

  Company({this.ResultId, required this.DescriptionA, required this.ClassA});

  Company.fromJson(Map<dynamic, dynamic> json) {
    ResultId = json['ResultId'];
    ClassA = json['ClassA'];
    DescriptionA = json['ClassB'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClassA'] = this.ClassA;
    data['ClassB'] = this.DescriptionA;
    data['ResultId'] = this.ResultId;
    return data;
  }
}
