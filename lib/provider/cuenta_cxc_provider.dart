import 'package:app_consulta/class/cuenta_user.dart';
import 'package:app_consulta/class/factura.dart';
import 'package:app_consulta/services/solicitud_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CuentaCxcProvider extends ChangeNotifier {
  //Variable de seleccion del cliente
  var selectCliente;
  //tabla de todo los usuarios facturados
  List<FacturaCabecera> listFact = [];
  //listado de clientes del combo
  List<CuentaUsuario> listClientes = [];
  //tabla del detalle de la factura
  List<FacturaDet> listFactDet = [];

  List<CuentaUsuario> listClientesUtil = [];

  SolicitudApi solicitudApi = SolicitudApi();

  final controllerC = TextEditingController();

  final txtCritFI = TextEditingController(
      text: DateFormat("dd-MM-yyyy")
          .format(DateTime.now().add(const Duration(days: -365))));
  final txtCritFF = TextEditingController(
      text: DateFormat("dd-MM-yyyy").format(DateTime.now()));

  /* Info de usuario */
  String codRef = "";
  String nomRef = "";
  String dirRef = "";
  String nomAux = "";
  String telRef = "";
  String emp = "";
  String empresa = "";

  void findQuery() async {
    notifyListeners();
  }

  void findQueryClient(String emp, String codigo) async {
    var resp = await solicitudApi.consultaClientescxc(emp, codigo);
    listClientes = resp;
    listClientesUtil.addAll(resp);
    notifyListeners();
  }

  void clearList() {
    listClientes.addAll(listClientesUtil);
    controllerC.clear();
    notifyListeners();
  }

  onSearchTextChanged(String text) async {
    listClientes.clear();
    if (text.isEmpty) {
      listClientes.addAll(listClientesUtil);
      notifyListeners();
      return;
    }

    for (var userDetail in listClientesUtil) {
      if (userDetail.codRef.contains(text) ||
          userDetail.nomRef.contains(text)) {
        listClientes.add(userDetail);
      }
    }

    notifyListeners();
  }

  bool rangoFech() {
    DateTime dateDesd = DateTime.parse(txtCritFI.text);
    DateTime dateHast = DateTime.parse(txtCritFF.text);

    if (dateHast.isAfter(dateDesd)) {
      return true;
    } else {
      return false;
    }
  }

  Future getListDet(var val, String empresa) async {
    var responde = await solicitudApi.consultaFacturaDet(
        empresa, 'FC', val, selectCliente);

    listFactDet = responde;

    notifyListeners();
  }
}
