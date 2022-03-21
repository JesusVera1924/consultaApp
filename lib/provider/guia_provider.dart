import 'package:app_consulta/class/cliente.dart';
import 'package:app_consulta/class/guia.dart';
import 'package:app_consulta/class/usuario_response.dart';
import 'package:app_consulta/services/solicitud_api.dart';
import 'package:app_consulta/widget/util_view.dart';
import 'package:flutter/material.dart';

class GuiaProvider extends ChangeNotifier {
  List<Guia> listGuias = [];
  Cliente? cliente;
  List<UsuarioResponse> listUsuario = [];
  List<UsuarioResponse> listUsuarioTemp = [];
  final solicitudApi = SolicitudApi();

  bool isShow = true;

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
      text: UtilView.convertDateToString(
          DateTime.now().add(const Duration(days: -1))));
  final txtFinUser =
      TextEditingController(text: UtilView.convertDateToString(DateTime.now()));

  void getGuias() async {
    listGuias.clear();
    listGuias = await solicitudApi.findGuias(
        UtilView.userSeleccionado, txtFechaInicio.text, txtFechaFin.text);
    var listResponse = await solicitudApi.queryClienteVen(
        UtilView.codEmp, UtilView.userSeleccionado, UtilView.codUser);
    cliente = listResponse.isEmpty ? null : listResponse.first;
    notifyListeners();
  }

  void findQueryClient(String emp, String codigo) async {
    listUsuario = await solicitudApi.getListClientVen(
        emp,
        txtInicioUser.text,
        txtFinUser.text,
        txtfindVendedor.text == "" ? codigo : txtfindVendedor.text);
    listUsuarioTemp.addAll(listUsuario);

    notifyListeners();
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
