import 'dart:convert';

Child childFromJson(String str) => Child.fromJson(json.decode(str));

String childToJson(Child data) => json.encode(data.toJson());

class Child {
  Child({
    this.name,
    this.surname,
    this.patronymic,
    this.dob,
    this.parentId,
  });

  String name;
  String surname;
  String patronymic;
  String dob;
  int parentId;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        name: json["name"],
        surname: json["surname"],
        patronymic: json["patronymic"],
        dob: json["dob"],
        parentId: json["parentId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "patronymic": patronymic,
        "dob": dob,
        "parentId": parentId,
      };
}
