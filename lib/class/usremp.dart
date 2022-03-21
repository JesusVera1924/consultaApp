import 'dart:convert';

class UsrEmp {
  UsrEmp({
    required this.codEmp,
    required this.nomEmp,
  });

  String codEmp;
  String nomEmp;

  factory UsrEmp.fromJson(String str) => UsrEmp.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsrEmp.fromMap(Map<String, dynamic> json) => UsrEmp(
        codEmp: json["cod_emp"],
        nomEmp: json["nom_emp"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "nom_emp": nomEmp,
      };
}
