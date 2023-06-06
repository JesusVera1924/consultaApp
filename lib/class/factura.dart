import 'dart:convert';

class FacturaCabecera {
  FacturaCabecera({
    required this.codRef,
    required this.codMov,
    required this.numMov,
    required this.numRel,
    required this.valMov,
    required this.fecEmi,
    required this.codCob,
    required this.nomRef,
    required this.cedRuc,
    required this.dirRef,
    required this.telRef,
    required this.codAux,
    required this.sdoMov,
  });

  String codRef;
  String codMov;
  String numMov;
  String numRel;
  double valMov;
  DateTime fecEmi;
  String codCob;
  String nomRef;
  String cedRuc;
  String dirRef;
  String telRef;
  String codAux;
  double sdoMov;

  factory FacturaCabecera.fromJson(String str) =>
      FacturaCabecera.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FacturaCabecera.fromMap(Map<String, dynamic> json) => FacturaCabecera(
        codRef: json["cod_ref"],
        codMov: json["cod_mov"],
        numMov: json["num_mov"],
        numRel: json["num_rel"],
        valMov: json["val_mov"].toDouble(),
        fecEmi: DateTime.parse(json["fec_emi"]),
        codCob: json["cod_cob"],
        nomRef: json["nom_ref"],
        cedRuc: json["ced_ruc"],
        dirRef: json["dir_ref"],
        telRef: json["tel_Ref"],
        codAux: json["cod_aux"],
        sdoMov: json["sdo_mov"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "cod_ref": codRef,
        "cod_mov": codMov,
        "num_mov": numMov,
        "num_rel": numRel,
        "val_mov": valMov,
        "fec_emi":
            "${fecEmi.year.toString().padLeft(4, '0')}-${fecEmi.month.toString().padLeft(2, '0')}-${fecEmi.day.toString().padLeft(2, '0')}",
        "cod_cob": codCob,
        "nom_ref": nomRef,
        "ced_ruc": cedRuc,
        "dir_ref": dirRef,
        "tel_Ref": telRef,
        "cod_aux": codAux,
        "sdo_mov": sdoMov,
      };
}

class FacturaDet {
  String codBco;
  String codCob;
  String codDiv;
  String codEmp;
  String codMov;
  String codNex;
  String codPto;
  String codRef;
  String codRel;
  double cotDiv;
  String fcrNex;
  String fecEmi;
  String fecNex;
  String fecVen;
  String girador;
  String idnBir;
  String ncrNex;
  String nomRef;
  String numCta;
  String numMov;
  String numNex;
  String numRel;
  String nunCta;
  String obsMov;
  String ptoNex;
  String ptoRel;
  String scsMov;
  double sdoMov;
  String sosMov;
  String stsMov;
  double valMov;

  FacturaDet(
      {required this.codBco,
      required this.codCob,
      required this.codDiv,
      required this.codEmp,
      required this.codMov,
      required this.codNex,
      required this.codPto,
      required this.codRef,
      required this.codRel,
      required this.cotDiv,
      required this.fcrNex,
      required this.fecEmi,
      required this.fecNex,
      required this.fecVen,
      required this.girador,
      required this.idnBir,
      required this.ncrNex,
      required this.nomRef,
      required this.numCta,
      required this.numMov,
      required this.numNex,
      required this.numRel,
      required this.nunCta,
      required this.obsMov,
      required this.ptoNex,
      required this.ptoRel,
      required this.scsMov,
      required this.sdoMov,
      required this.sosMov,
      required this.stsMov,
      required this.valMov});

  factory FacturaDet.fromJson(Map<String, dynamic> json) {
    return FacturaDet(
      codBco: json['cod_bco'],
      codCob: json['cod_cob'],
      codDiv: json['cod_div'],
      codEmp: json['cod_emp'],
      codMov: json['cod_mov'],
      codNex: json['cod_nex'],
      codPto: json['cod_pto'],
      codRef: json['cod_ref'],
      codRel: json['cod_rel'],
      cotDiv: json['cot_div'],
      fcrNex: json['fcr_nex'],
      fecEmi: json['fec_emi'],
      fecNex: json['fec_nex'],
      fecVen: json['fec_ven'],
      girador: json['girador'],
      idnBir: json['idn_bir'],
      ncrNex: json['ncr_nex'],
      nomRef: json['nom_ref'],
      numCta: json['num_cta'],
      numMov: json['num_mov'],
      numNex: json['num_nex'],
      numRel: json['num_rel'],
      nunCta: json['nun_cta'],
      obsMov: json['obs_mov'],
      ptoNex: json['pto_nex'],
      ptoRel: json['pto_rel'],
      scsMov: json['scs_mov'],
      sdoMov: json['sdo_mov'],
      sosMov: json['sos_mov'],
      stsMov: json['sts_mov'],
      valMov: json['val_mov'],
    );
  }
}

class CuentasPorCobrar {
  String ciudad;
  String cobrador;
  String codCob;
  String codEmp;
  String codRef;
  String docXCob;
  String estadoCliente;
  double f120150Dias;
  double f130Dias;
  double f3060Dias;
  double f6090Dias;
  double f90120Dias;
  double fMas150Dias;
  String nomAux;
  String nomCliente;
  int ordenador;
  int porDes;
  String provincia;
  String tipoPago;
  double total;
  double totalEvaluado;
  double totalVencido;
  double v030Dias;
  double v120150Dias;
  double v3060Dias;
  double v6090Dias;
  double v90120Dias;
  double vMas150Dias;
  double venta12Meses;

  CuentasPorCobrar(
      {required this.ciudad,
      required this.cobrador,
      required this.codCob,
      required this.codEmp,
      required this.codRef,
      required this.docXCob,
      required this.estadoCliente,
      required this.f120150Dias,
      required this.f130Dias,
      required this.f3060Dias,
      required this.f6090Dias,
      required this.f90120Dias,
      required this.fMas150Dias,
      required this.nomAux,
      required this.nomCliente,
      required this.ordenador,
      required this.porDes,
      required this.provincia,
      required this.tipoPago,
      required this.total,
      required this.totalEvaluado,
      required this.totalVencido,
      required this.v030Dias,
      required this.v120150Dias,
      required this.v3060Dias,
      required this.v6090Dias,
      required this.v90120Dias,
      required this.vMas150Dias,
      required this.venta12Meses});

  factory CuentasPorCobrar.fromJson(Map<String, dynamic> json) {
    return CuentasPorCobrar(
      ciudad: json['ciudad'],
      cobrador: json['cobrador'],
      codCob: json['cod_cob'],
      codEmp: json['cod_emp'],
      codRef: json['cod_ref'],
      docXCob: json['doc_x_cob'],
      estadoCliente: json['estado_cliente'],
      f120150Dias: json['f_120_150_dias'],
      f130Dias: json['f_1_30_dias'],
      f3060Dias: json['f_30_60_dias'],
      f6090Dias: json['f_60_90_dias'],
      f90120Dias: json['f_90_120_dias'],
      fMas150Dias: json['f_mas_150_dias'],
      nomAux: json['nom_aux'],
      nomCliente: json['nom_cliente'],
      ordenador: json['ordenador'],
      porDes: json['por_des'],
      provincia: json['provincia'],
      tipoPago: json['tipo_pago'],
      total: json['total'],
      totalEvaluado: json['total_evaluado'],
      totalVencido: json['total_vencido'],
      v030Dias: json['v_0_30_dias'],
      v120150Dias: json['v_120_150_dias'],
      v3060Dias: json['v_30_60_dias'],
      v6090Dias: json['v_60_90_dias'],
      v90120Dias: json['v_90_120_dias'],
      vMas150Dias: json['v_mas_150_dias'],
      venta12Meses: json['venta_12_meses'],
    );
  }
}
