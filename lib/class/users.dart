import 'dart:convert';

class User {
  User({
    required this.codEmp,
    required this.grpYkk,
    required this.codYkk,
    required this.nomYkk,
    required this.codUsr,
    required this.filtrar,
    required this.omision,
  });

  String codEmp;
  String grpYkk;
  String codYkk;
  String nomYkk;
  String codUsr;
  String filtrar;
  String omision;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        codEmp: json["cod_emp"],
        grpYkk: json["grp_ykk"],
        codYkk: json["cod_ykk"],
        nomYkk: json["nom_ykk"],
        codUsr: json["cod_usr"],
        filtrar: json["filtrar"],
        omision: json["omision"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "grp_ykk": grpYkk,
        "cod_ykk": codYkk,
        "nom_ykk": nomYkk,
        "cod_usr": codUsr,
        "filtrar": filtrar,
        "omision": omision,
      };
}
