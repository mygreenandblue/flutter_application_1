class Employees {
  List<Employee> items = [];

  Employees();

  Employees.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = new Employee.fromJson(item);
      items.add(pelicula);
    }
  }
}

class Employee {
  int? ResultId;
  dynamic UpdatedTime;
  String? ItemTitle;

  Employee({
    required this.ResultId,
    required this.UpdatedTime,
    required this.ItemTitle,
  });

  Employee.fromJson(Map<dynamic, dynamic> json) {
    ResultId = json['ResultId'];
    UpdatedTime = json['UpdatedTime'];
    ItemTitle = json['ItemTitle'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UpdatedTime'] = this.UpdatedTime;
    data['ResultId'] = this.ResultId;
    data['ItemTitle'] = this.ItemTitle;
    return data;
  }
}
