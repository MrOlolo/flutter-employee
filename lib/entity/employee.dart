class Employee {
  Employee({
    this.id,
    this.name,
    this.surname,
    this.patronymic,
    this.position,
    this.dob,
    this.childrenAmount,
  });

  final int id;
  final String name;
  final String surname;
  final String patronymic;
  final String position;
  final String dob;
  final int childrenAmount;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        patronymic: json["patronymic"],
        position: json["position"],
        dob: json["dob"],
        childrenAmount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "patronymic": patronymic,
        "position": position,
        "dob": dob,
      };
}
