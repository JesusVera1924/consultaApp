import 'package:app_consulta/class/cliente.dart';
import 'package:app_consulta/class/guia.dart';
import 'package:app_consulta/class/ig0040y.dart';
import 'package:app_consulta/class/karmov.dart';
import 'package:app_consulta/class/usuario_response.dart';
import 'package:app_consulta/services/solicitud_api.dart';
import 'package:app_consulta/widget/util_view.dart';
import 'package:flutter/material.dart';

class GuiaProvider extends ChangeNotifier {
  List<Guia> listGuias = [];
  Cliente? cliente;
  Karmov? isSelectKarmov;

  Guia? isSelectGuia;
  List<Karmov> listKarmov = [];
  List<UsuarioResponse> listUsuario = [];
  List<UsuarioResponse> listUsuarioTemp = [];
  String supervisor = "";
  String empacador = "";
  final solicitudApi = SolicitudApi();
  bool isShow = true;
  String numero = "";
  String menbrete = "";
  Ig0040Y? factura;
  TextEditingController controllerC = TextEditingController();
  TextEditingController txtfindVendedor = TextEditingController();

  final txtUsuario = TextEditingController();
  /* FILTRO DEL RANGO DE CONSULTA ESPECIFICA POR USUARIO */
  final txtFechaInicio = TextEditingController(
      text: UtilView.convertDateToString(
          DateTime.now().add(const Duration(days: -2))));
  final txtFechaFin =
      TextEditingController(text: UtilView.convertDateToString(DateTime.now()));

  String codRef = "";
  String nomRef = "";
  String dirRef = "";
  String nomAux = "";
  String telRef = "";

  final txtInicioUser = TextEditingController(
      text: UtilView.convertDateToStringLash(
          DateTime.now().add(const Duration(days: -1))));
  final txtFinUser = TextEditingController(
      text: UtilView.convertDateToStringLash(DateTime.now()));

  void getGuias() async {
    listGuias.clear();

    /*   listGuias = await solicitudApi.findGuias(
        UtilView.userSeleccionado, txtFechaInicio.text, txtFechaFin.text); */

    var listResponse = await solicitudApi.queryClienteVen(
        UtilView.codEmp, UtilView.userSeleccionado, UtilView.codUser);

    cliente = listResponse.isEmpty ? null : listResponse.first;
    notifyListeners();
  }

  void findQueryClient(String emp, String codigo) async {
    listUsuario = await solicitudApi.getListClientVen(
        emp,
        UtilView.dateFormatYMD(txtInicioUser.text),
        UtilView.dateFormatYMD(txtFinUser.text),
        txtfindVendedor.text == "" ? codigo : txtfindVendedor.text);
    listUsuarioTemp.addAll(listUsuario);

    notifyListeners();
  }

  Future findQueryKamrov(String emp, String nummov) async {
    try {
      var list = await solicitudApi.getKarmov(emp, nummov);
      var factura = await solicitudApi.getFacturaIg0040y(nummov);
      menbrete = await solicitudApi.getNumeroFecha(nummov);

      if (list.isNotEmpty) {
        isSelectKarmov = list[0];
      }
      if (factura != null) {
        numero = factura.usrIbs;
      }
    } catch (e) {
      print(e);
    }
  }

  Future findQueryFactura(String numero) async {
    try {
      var list = await solicitudApi.getKarmov("01", numero);

      if (list.isNotEmpty) {
        isSelectKarmov = list[0];
        listKarmov = list;
        factura = await solicitudApi.getFacturaIg0040y(isSelectKarmov!.numMov);
        if (factura != null) {
          menbrete = await solicitudApi.getNumeroFecha(factura!.numMov);
          isSelectGuia = await solicitudApi.queryGuia(isSelectKarmov!.numMov);
          /*  if (menbrete.split("&")[1] != "") {
            empacador =
                await solicitudApi.getNombreusuario(menbrete.split("&")[1]);
          } */
          if (menbrete.split("&")[2] != "") {
            supervisor = await solicitudApi.getNombreusuario(
                menbrete.split("&")[2].trim().replaceAll("+", ""));
            if (supervisor == "") {
              supervisor =
                  menbrete.split("&")[2].trim().replaceAll("+", "") + " - N/A";
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void clearComponents() {
    listGuias.clear();
  }

  void clearComponents2() {
    listUsuario.clear();
    txtfindVendedor.clear();
    isShow = true;
  }

  void limpiar() {
    listUsuario.clear();
    listGuias.clear();
    listUsuarioTemp.clear();
    isShow = true;
    notifyListeners();
  }

  onSearchTextChanged(String text) async {
    listUsuario.clear();
    if (text.isEmpty) {
      listUsuario.addAll(listUsuarioTemp);
      notifyListeners();
      return;
    }

    for (var userDetail in listUsuarioTemp) {
      if (userDetail.codRef.contains(text) ||
          userDetail.nomRef.contains(text)) {
        listUsuario.add(userDetail);
      }
    }

    notifyListeners();
  }
}
