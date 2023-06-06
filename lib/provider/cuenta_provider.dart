import 'package:app_consulta/class/cc0020.dart';
import 'package:app_consulta/class/client_ven.dart';
import 'package:app_consulta/services/solicitud_api.dart';
import 'package:flutter/material.dart';

class CuentaProvider extends ChangeNotifier {
  List<Cc0020> listCuenta = [];
  List<Cc0020> listCuentaTemp = [];
  List<ClienteVen> listUsuario = [];
  List<ClienteVen> listUsuarioTemp = [];
  SolicitudApi solicitudApi = SolicitudApi();

  TextEditingController controllerC = TextEditingController();

  /* Info de usuario */
  String codRef = "";
  String nomRef = "";
  String dirRef = "";
  String nomAux = "";
  String telRef = "";
  String emp = "";
  String empresa = "";

  void findQuery() async {
    clearComponents();
    notifyListeners();
  }

  void fillListInit(listaUsuario) {
    listUsuario = listUsuario;
    listUsuarioTemp = listUsuario;
    notifyListeners();
  }

  void findQueryClient(String emp, String codigo) async {
    listUsuario.clear();
    listUsuarioTemp.clear();
    listUsuario = await solicitudApi.findClientVen(emp, codigo);
    listUsuarioTemp.addAll(listUsuario);
    notifyListeners();
  }

  void clearComponents() {
    listCuenta.clear();
  }

  onSearchTextChanged(String text) async {
    listUsuario.clear();
    if (text.isEmpty) {
      listUsuario.addAll(listUsuarioTemp);
      notifyListeners();
      return;
    }

    for (var userDetail in listUsuarioTemp) {
      if (userDetail.cliente.contains(text) ||
          userDetail.ncliente.contains(text)) {
        listUsuario.add(userDetail);
      }
    }

    notifyListeners();
  }

  void cargarCuenta() async {
    listCuenta = await solicitudApi.consultaSolicitudCuenta(empresa, 'DF', emp);
    listCuentaTemp.addAll(listCuenta);
    notifyListeners();
  }

  void filtroCuenta(String filtro) {
    listCuenta.clear();
    if (filtro == "") {
      listCuenta.addAll(listCuentaTemp);
      notifyListeners();
      return;
    }

    for (var userDetail in listCuentaTemp) {
      if (userDetail.nunCta.contains(filtro)) listCuenta.add(userDetail);
    }

    notifyListeners();
  }
}
