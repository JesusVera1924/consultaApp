
import 'dart:convert';

class CuentaUsuario {
  CuentaUsuario({
    required this.codRef,
    required this.nomRef,
    required this.cedRuc,
    required this.dirRef,
    required this.telRef,
    required this.codAux,
  });

  String codRef;
  String nomRef;
  String cedRuc;
  String dirRef;
  String telRef;
  String codAux;

  factory CuentaUsuario.fromJson(String str) =>
      CuentaUsuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CuentaUsuario.fromMap(Map<String, dynamic> json) => CuentaUsuario(
        codRef: json["cod_ref"],
        nomRef: json["nom_ref"],
        cedRuc: json["ced_ruc"],
        dirRef: json["dir_ref"],
        telRef: json["tel_Ref"],
        codAux: json["cod_aux"],
      );

  Map<String, dynamic> toMap() => {
        "cod_ref": codRef,
        "nom_ref": nomRef,
        "ced_ruc": cedRuc,
        "dir_ref": dirRef,
        "tel_Ref": telRef,
        "cod_aux": codAux,
      };
}
