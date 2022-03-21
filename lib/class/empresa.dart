// To parse this JSON data, do
//
//     final empresa = empresaFromMap(jsonString);

import 'dart:convert';

class Empresa {
  Empresa({
    required this.codEmp,
    required this.nm1Emp,
    required this.nm2Emp,
    required this.aliEmp,
    required this.fexEmp,
    required this.cccEmp,
    required this.ceaEmp,
    required this.csaEmp,
    required this.cxaEmp,
    required this.cs1Emp,
    required this.cs2Emp,
    required this.cs3Emp,
    required this.cs4Emp,
    required this.uiaEmp,
    required this.uf1Emp,
    required this.uf2Emp,
    required this.uf3Emp,
    required this.uf4Emp,
    required this.uf5Emp,
    required this.cl1Emp,
    required this.cl2Emp,
    required this.cl3Emp,
    required this.cl4Emp,
    required this.cl5Emp,
    required this.stsEmp,
  });

  String codEmp;
  String nm1Emp;
  String nm2Emp;
  String aliEmp;
  DateTime fexEmp;
  String cccEmp;
  String ceaEmp;
  String csaEmp;
  String cxaEmp;
  String cs1Emp;
  String cs2Emp;
  String cs3Emp;
  String cs4Emp;
  String uiaEmp;
  String uf1Emp;
  String uf2Emp;
  String uf3Emp;
  String uf4Emp;
  String uf5Emp;
  String cl1Emp;
  String cl2Emp;
  String cl3Emp;
  String cl4Emp;
  String cl5Emp;
  String stsEmp;

  factory Empresa.fromJson(String str) => Empresa.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Empresa.fromMap(Map<String, dynamic> json) => Empresa(
        codEmp: json["cod_emp"],
        nm1Emp: json["nm1_emp"],
        nm2Emp: json["nm2_emp"],
        aliEmp: json["ali_emp"],
        fexEmp: DateTime.parse(json["fex_emp"]),
        cccEmp: json["ccc_emp"],
        ceaEmp: json["cea_emp"],
        csaEmp: json["csa_emp"],
        cxaEmp: json["cxa_emp"],
        cs1Emp: json["cs1_emp"],
        cs2Emp: json["cs2_emp"],
        cs3Emp: json["cs3_emp"],
        cs4Emp: json["cs4_emp"],
        uiaEmp: json["uia_emp"],
        uf1Emp: json["uf1_emp"],
        uf2Emp: json["uf2_emp"],
        uf3Emp: json["uf3_emp"],
        uf4Emp: json["uf4_emp"],
        uf5Emp: json["uf5_emp"],
        cl1Emp: json["cl1_emp"],
        cl2Emp: json["cl2_emp"],
        cl3Emp: json["cl3_emp"],
        cl4Emp: json["cl4_emp"],
        cl5Emp: json["cl5_emp"],
        stsEmp: json["sts_emp"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "nm1_emp": nm1Emp,
        "nm2_emp": nm2Emp,
        "ali_emp": aliEmp,
        "fex_emp":
            "${fexEmp.year.toString().padLeft(4, '0')}-${fexEmp.month.toString().padLeft(2, '0')}-${fexEmp.day.toString().padLeft(2, '0')}",
        "ccc_emp": cccEmp,
        "cea_emp": ceaEmp,
        "csa_emp": csaEmp,
        "cxa_emp": cxaEmp,
        "cs1_emp": cs1Emp,
        "cs2_emp": cs2Emp,
        "cs3_emp": cs3Emp,
        "cs4_emp": cs4Emp,
        "uia_emp": uiaEmp,
        "uf1_emp": uf1Emp,
        "uf2_emp": uf2Emp,
        "uf3_emp": uf3Emp,
        "uf4_emp": uf4Emp,
        "uf5_emp": uf5Emp,
        "cl1_emp": cl1Emp,
        "cl2_emp": cl2Emp,
        "cl3_emp": cl3Emp,
        "cl4_emp": cl4Emp,
        "cl5_emp": cl5Emp,
        "sts_emp": stsEmp,
      };
}
