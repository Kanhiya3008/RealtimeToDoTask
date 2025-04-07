class EmployeeModel {
  String? id;
  String? name;
  String? role;
  String? from;
  String? to;

  EmployeeModel({this.from, this.id, this.name, this.role, this.to});

  EmployeeModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    from = json['from'];
    to = json['to'];
  }
  EmployeeModel.fromHive(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    from = json['from'];
    to = json['to'];
  }
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['role'] = role;
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}
