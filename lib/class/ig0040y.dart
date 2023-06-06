import 'dart:convert';

class Ig0040Y {
  String codEmp;
  String codPto;
  String codMov;
  String numMov;
  DateTime fecMov;
  String codRef;
  String nomRef;
  String codCop;
  String nomCop;
  String pwaCop;
  String pwaBod;
  String codBod;
  String uduMov;
  String obsMov;
  String ucrMov;
  DateTime fcrMov;
  String stsIbs;
  String usrIbs;
  DateTime fytIbs;
  String stsFbs;
  String usrFbs;
  DateTime fytFbs;
  String indicad;

  Ig0040Y({
    required this.codEmp,
    required this.codPto,
    required this.codMov,
    required this.numMov,
    required this.fecMov,
    required this.codRef,
    required this.nomRef,
    required this.codCop,
    required this.nomCop,
    required this.pwaCop,
    required this.pwaBod,
    required this.codBod,
    required this.uduMov,
    required this.obsMov,
    required this.ucrMov,
    required this.fcrMov,
    required this.stsIbs,
    required this.usrIbs,
    required this.fytIbs,
    required this.stsFbs,
    required this.usrFbs,
    required this.fytFbs,
    required this.indicad,
  });

  factory Ig0040Y.fromJson(String str) => Ig0040Y.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ig0040Y.fromMap(Map<String, dynamic> json) => Ig0040Y(
        codEmp: json["cod_emp"],
        codPto: json["cod_pto"],
        codMov: json["cod_mov"],
        numMov: json["num_mov"],
        fecMov: DateTime.parse(json["fec_mov"]),
        codRef: json["cod_ref"],
        nomRef: json["nom_ref"],
        codCop: json["cod_cop"],
        nomCop: json["nom_cop"],
        pwaCop: json["pwa_cop"],
        pwaBod: json["pwa_bod"],
        codBod: json["cod_bod"],
        uduMov: json["udu_mov"],
        obsMov: json["obs_mov"],
        ucrMov: json["ucr_mov"],
        fcrMov: DateTime.parse(json["fcr_mov"]),
        stsIbs: json["sts_ibs"],
        usrIbs: json["usr_ibs"],
        fytIbs: DateTime.parse(json["fyt_ibs"]),
        stsFbs: json["sts_fbs"],
        usrFbs: json["usr_fbs"],
        fytFbs: DateTime.parse(json["fyt_fbs"]),
        indicad: json["indicad"],
      );

  Map<String, dynamic> toMap() => {
        "cod_emp": codEmp,
        "cod_pto": codPto,
        "cod_mov": codMov,
        "num_mov": numMov,
        "fec_mov":
            "${fecMov.year.toString().padLeft(4, '0')}-${fecMov.month.toString().padLeft(2, '0')}-${fecMov.day.toString().padLeft(2, '0')}",
        "cod_ref": codRef,
        "nom_ref": nomRef,
        "cod_cop": codCop,
        "nom_cop": nomCop,
        "pwa_cop": pwaCop,
        "pwa_bod": pwaBod,
        "cod_bod": codBod,
        "udu_mov": uduMov,
        "obs_mov": obsMov,
        "ucr_mov": ucrMov,
        "fcr_mov":
            "${fcrMov.year.toString().padLeft(4, '0')}-${fcrMov.month.toString().padLeft(2, '0')}-${fcrMov.day.toString().padLeft(2, '0')}",
        "sts_ibs": stsIbs,
        "usr_ibs": usrIbs,
        "fyt_ibs": fytIbs.toIso8601String(),
        "sts_fbs": stsFbs,
        "usr_fbs": usrFbs,
        "fyt_fbs": fytFbs.toIso8601String(),
        "indicad": indicad,
      };
}
