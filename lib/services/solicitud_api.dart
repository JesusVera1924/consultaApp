import 'package:app_consulta/class/cc0020.dart';
import 'package:app_consulta/class/client_ven.dart';
import 'package:app_consulta/class/cliente.dart';
import 'package:app_consulta/class/cobranza.dart';
import 'package:app_consulta/class/empresa.dart';
import 'package:app_consulta/class/factura.dart';
import 'package:app_consulta/class/guia.dart';
import 'package:app_consulta/class/users.dart';
import 'package:app_consulta/class/usremp.dart';
import 'package:app_consulta/class/usuario_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SolicitudApi {
  Future<Empresa> getSettingEmp(String emp) async {
    Empresa dato;
    var url = Uri.parse(
        "https://www.cojapan.com.ec/solicitud/getempresa?empresa=$emp");

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        dato = Empresa.fromJson(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return dato;
  }

  List<Empresa> parseJsonToList(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Empresa>((json) => Empresa.fromMap(json)).toList();
  }

  Future<List<User>> getLogin(String user, String pass) async {
    var url = Uri.https('www.cojapan.com.ec', '/contabilidad/loginMovil',
        {'usuario': user, 'pass': pass});
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseUsuarios(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<User> parseUsuarios(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<User>((json) => User.fromMap(json)).toList();
  }

  Future<List<Cobranza>> consultaClientes(String emp) async {
    var url = Uri.http('www.cojapan.com.ec:8088',
        '/wscojapan/rest/service_cobranza/clientescob', {'codemp': emp});
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseClientes(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Cobranza> parseClientes(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Cobranza>((json) => Cobranza.fromJson(json)).toList();
  }

  Future<List<FacturaCabecera>> consultaFacturaCab(
      String emp, String tipo, String nummov, String codref) async {
    var url = Uri.http(
        'www.cojapan.com.ec:8088',
        '/wscojapan/rest/service_cobranza/cobroscab',
        {'codemp': emp, 'codref': codref, 'codmov': tipo, 'nummov': nummov});
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseFacturaCab(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<FacturaCabecera> parseFacturaCab(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo
        .map<FacturaCabecera>((json) => FacturaCabecera.fromJson(json))
        .toList();
  }

  Future<List<FacturaDet>> consultaFacturaDet(
      String emp, String tipo, String nummov, String codref) async {
    var url = Uri.http(
        'www.cojapan.com.ec:8088',
        '/wscojapan/rest/service_cobranza/cobrosdet',
        {'codemp': emp, 'codref': codref, 'codmov': tipo, 'nummov': nummov});
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseFacturaDet(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<FacturaDet> parseFacturaDet(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<FacturaDet>((json) => FacturaDet.fromJson(json)).toList();
  }

  Future<List<FacturaCabecera>> consultaFacturaCabFech(String emp, String tipo,
      String nummov, String codref, String fecdes, String fechas) async {
    var url = Uri.http('www.cojapan.com.ec:8088',
        '/wscojapan/rest/service_cobranza/cobroscab', {
      'codemp': emp,
      'codref': codref,
      'codmov': tipo,
      'nummov': nummov,
      'fecdes': fecdes,
      'fechas': fechas
    });
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseFacturaCab(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<FacturaCabecera>> consultaFacturaCabSolo(String emp,
      String codref, String tipo, String fecdes, String fechas) async {
    var url = Uri.http('www.cojapan.com.ec:8088',
        '/wscojapan/rest/service_cobranza/cobroscab', {
      'codemp': emp,
      'codref': codref,
      'codmov': tipo,
      'nummov': '',
      'fecdes': fecdes,
      'fechas': fechas
    });
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseFacturaCab(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<CuentasPorCobrar>> consultaCuentasxCobrar(
      String emp, String codref) async {
    var url = Uri.http(
        'www.cojapan.com.ec:8088',
        '/wscojapan/rest/service_cobranza/ctaxcob',
        {'codemp': emp, 'codref': codref});

    print(url.toString());
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseCuentasxCobrar(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<CuentasPorCobrar> parseCuentasxCobrar(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo
        .map<CuentasPorCobrar>((json) => CuentasPorCobrar.fromJson(json))
        .toList();
  }

  Future<List<Cc0020>> consultaSolicitudCuenta(
      String emp, String codmov, String codref) async {
    var url = Uri.https('www.cojapan.com.ec', '/contabilidad/getCc0020',
        {'emp': emp, 'codmov': codmov, 'codref': codref});

    print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseSolicitudCuenta(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<Cc0020> parseSolicitudCuenta(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Cc0020>((json) => Cc0020.fromMap(json)).toList();
  }

  Future<List<UsrEmp>> consultaUserEmp(String grupo, String codusr) async {
    var url = Uri.https('www.cojapan.com.ec', '/contabilidad/getEmpUser',
        {'grupo': grupo, 'codusr': codusr});

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseUsuariosEmp(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  List<UsrEmp> parseUsuariosEmp(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<UsrEmp>((json) => UsrEmp.fromMap(json)).toList();
  }

  Future<Cliente?> queryCliente(String empresa, String usuario) async {
    dynamic resul;
    var url = Uri.https('www.cojapan.com.ec', '/solicitud/getcliente',
        {'empresa': empresa, 'codigo': usuario});

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        if (respuesta.body != "") {
          resul = Cliente.fromJson(utf8.decode(respuesta.bodyBytes));
        }

        return resul;
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
  }

  Future<List<ClienteVen>> findClientVen(String empresa, String ven) async {
    List<ClienteVen> resul = [];
    var url = Uri.http(
        'www.cojapan.com.ec:8088',
        '/wscojapan/rest/service_cobranza/vldclientes',
        {'codemp': empresa, 'codven': ven, 'select': 'A'});
    print(url.toString());
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = parseClient(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  List<ClienteVen> parseClient(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<ClienteVen>((json) => ClienteVen.fromMap(json)).toList();
  }

  Future<List<Guia>> findGuias(
      String usuario, String inicio, String fin) async {
    List<Guia> resul = [];
    var url = Uri.https('www.cojapan.com.ec', '/contabilidad/getguias',
        {'usuario': usuario, 'inicio': inicio, 'fin': fin});

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = parseGuias(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  List<Guia> parseGuias(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Guia>((json) => Guia.fromMap(json)).toList();
  }

  Future<List<Cliente>> queryClienteVen(
      String empresa, String codigo, String vendcode) async {
    List<Cliente> resul = [];
    var url = Uri.https('www.cojapan.com.ec', '/solicitud/getvenclientes',
        {'empresa': empresa, 'codigo': codigo, 'vendedor': vendcode});

    print(url.toString());
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        if (respuesta.body != "") {
          return respuesta.body.toString() != "[]"
              ? parseClientVen(utf8.decode(respuesta.bodyBytes))
              : resul;
        }
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  List<Cliente> parseClientVen(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Cliente>((json) => Cliente.fromMap(json)).toList();
  }

  Future<List<UsuarioResponse>> getListClientVen(
      String empresa, String inicio, String fin, String vendcode) async {
    List<UsuarioResponse> resul = [];
    var url = Uri.https('www.cojapan.com.ec', '/contabilidad/getUsuarioGuia', {
      'empresa': empresa,
      'inicio': inicio,
      'fin': fin,
      'vendedor': vendcode.startsWith("V9") ? "" : vendcode
    });
    print(url.toString());
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        if (respuesta.body != "") {
          return respuesta.body.toString() != "[]"
              ? parseClientResponse(utf8.decode(respuesta.bodyBytes))
              : resul;
        }
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  List<UsuarioResponse> parseClientResponse(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo
        .map<UsuarioResponse>((json) => UsuarioResponse.fromMap(json))
        .toList();
  }
  //https://www.cojapan.com.ec/contabilidad/getUsuarioGuia?empresa=01&vendedor=V009
}
