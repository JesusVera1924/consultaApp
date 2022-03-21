import 'dart:convert';

class UsuarioResponse {
  UsuarioResponse({
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

  factory UsuarioResponse.fromJson(String str) =>
      UsuarioResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsuarioResponse.fromMap(Map<String, dynamic> json) => UsuarioResponse(
        codRef: json["cod_ref"],
        nomRef: json["nom_ref"],
        cedRuc: json["ced_ruc"],
        dirRef: json["dir_ref"],
        telRef: json["tel_ref"],
        codAux: json["cod_aux"],
      );

  Map<String, dynamic> toMap() => {
        "cod_ref": codRef,
        "nom_ref": nomRef,
        "ced_ruc": cedRuc,
        "dir_ref": dirRef,
        "tel_ref": telRef,
        "cod_aux": codAux,
      };
}
