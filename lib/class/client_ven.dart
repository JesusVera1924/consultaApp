import 'dart:convert';

class ClienteVen {
  ClienteVen({
    required this.ciudad,
    required this.cliente,
    required this.descuento,
    required this.direccion,
    required this.empresa,
    required this.formaPago,
    required this.id,
    required this.mail1,
    required this.mail2,
    required this.ncliente,
    required this.nclienteAux,
    required this.persona,
    required this.provincia,
    required this.ruc,
    required this.telefono,
    required this.vendedor,
  });

  String ciudad;
  String cliente;
  double descuento;
  String direccion;
  String empresa;
  String formaPago;
  int id;
  String mail1;
  String mail2;
  String ncliente;
  String nclienteAux;
  int persona;
  String provincia;
  String ruc;
  String telefono;
  String vendedor;

  factory ClienteVen.fromJson(String str) =>
      ClienteVen.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ClienteVen.fromMap(Map<String, dynamic> json) => ClienteVen(
        ciudad: json["ciudad"],
        cliente: json["cliente"],
        descuento: json["descuento"].toDouble(),
        direccion: json["direccion"],
        empresa: json["empresa"],
        formaPago: json["forma_pago"],
        id: json["id"],
        mail1: json["mail1"],
        mail2: json["mail2"],
        ncliente: json["ncliente"],
        nclienteAux: json["ncliente_aux"],
        persona: json["persona"],
        provincia: json["provincia"],
        ruc: json["ruc"],
        telefono: json["telefono"],
        vendedor: json["vendedor"],
      );

  Map<String, dynamic> toMap() => {
        "ciudad": ciudad,
        "cliente": cliente,
        "descuento": descuento,
        "direccion": direccion,
        "empresa": empresa,
        "forma_pago": formaPago,
        "id": id,
        "mail1": mail1,
        "mail2": mail2,
        "ncliente": ncliente,
        "ncliente_aux": nclienteAux,
        "persona": persona,
        "provincia": provincia,
        "ruc": ruc,
        "telefono": telefono,
        "vendedor": vendedor,
      };
}
