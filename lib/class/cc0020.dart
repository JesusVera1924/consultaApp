import 'dart:convert';

class Cc0020 {
    Cc0020({
        required this.codMov,
        required this.nunCta,
        required this.fecVen,
        required this.valMov,
        required this.codCob,
        required this.codBco,
        required this.nomRef,
        required this.numCta,
        required this.fecEmi,
    });

    String codMov;
    String nunCta;
    DateTime fecVen;
    String valMov;
    String codCob;
    String codBco;
    String nomRef;
    String numCta;
    DateTime fecEmi;

    factory Cc0020.fromJson(String str) => Cc0020.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Cc0020.fromMap(Map<String, dynamic> json) => Cc0020(
        codMov: json["cod_mov"],
        nunCta: json["nun_cta"],
        fecVen: DateTime.parse(json["fec_ven"]),
        valMov: json["val_mov"],
        codCob: json["cod_cob"],
        codBco: json["cod_bco"],
        nomRef: json["nom_ref"],
        numCta: json["num_cta"],
        fecEmi: DateTime.parse(json["fec_emi"]),
    );

    Map<String, dynamic> toMap() => {
        "cod_mov": codMov,
        "nun_cta": nunCta,
        "fec_ven": "${fecVen.year.toString().padLeft(4, '0')}-${fecVen.month.toString().padLeft(2, '0')}-${fecVen.day.toString().padLeft(2, '0')}",
        "val_mov": valMov,
        "cod_cob": codCob,
        "cod_bco": codBco,
        "nom_ref": nomRef,
        "num_cta": numCta,
        "fec_emi": "${fecEmi.year.toString().padLeft(4, '0')}-${fecEmi.month.toString().padLeft(2, '0')}-${fecEmi.day.toString().padLeft(2, '0')}",
    };
}
