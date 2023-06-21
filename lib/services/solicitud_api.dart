import 'package:app_consulta/class/cc0020.dart';
import 'package:app_consulta/class/client_ven.dart';
import 'package:app_consulta/class/cliente.dart';
import 'package:app_consulta/class/cobranza.dart';
import 'package:app_consulta/class/cuenta_user.dart';
import 'package:app_consulta/class/empresa.dart';
import 'package:app_consulta/class/factura.dart';
import 'package:app_consulta/class/guia.dart';
import 'package:app_consulta/class/ig0040y.dart';
import 'package:app_consulta/class/karmov.dart';
import 'package:app_consulta/class/users.dart';
import 'package:app_consulta/class/usremp.dart';
import 'package:app_consulta/class/usuario_response.dart';
import 'package:app_consulta/widget/util_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SolicitudApi {
  Future<Empresa> getSettingEmp(String emp) async {
    Empresa dato;
    var url = Uri.parse(
        "http://181.39.96.138:8081/desarrollosolicitud/getempresa?empresa=$emp");
    print(url.toString());

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
    var url = Uri.http('181.39.96.138:8082', '/contabilidad/loginMovil',
        {'usuario': user, 'pass': pass});

    print(url.toString());
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
    var url = Uri.http('181.39.96.138:8081',
        '/wscojapan/rest/service_cobranza/clientescob', {'codemp': emp});

    print(url.toString());
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

  Future<List<CuentaUsuario>> consultaClientescxc(
      String empresa, vendedor) async {
    var url = Uri.http('181.39.96.138:8082', '/contabilidad/getusercxc',
        {'empresa': empresa, 'vendedor': vendedor});

    print(url.toString());
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseClientescxc(utf8.decode(respuesta.bodyBytes));
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

  List<CuentaUsuario> parseClientescxc(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo
        .map<CuentaUsuario>((json) => CuentaUsuario.fromMap(json))
        .toList();
  }

/*   Future<List<FacturaCabecera>> consultaFacturaCab(
      String emp, String tipo, String nummov, String codref) async {
    var url = Uri.http(
        '181.39.96.138:8081:8088',
        '/wscojapan/rest/service_cobranza/cobroscab',
        {'codemp': emp, 'codref': codref, 'codmov': tipo, 'nummov': nummov});
    print(url.toString());
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
 */
  List<FacturaCabecera> parseFacturaCab(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo
        .map<FacturaCabecera>((json) => FacturaCabecera.fromMap(json))
        .toList();
  }

  Future<List<FacturaDet>> consultaFacturaDet(
      String emp, String tipo, String nummov, String codref) async {
    var url = Uri.http('181.39.96.138:8082', '/contabilidad/cobrosdeb',
        {'codemp': emp, 'codref': codref, 'codmov': tipo, 'nummov': nummov});

    print(url.toString());
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
      String codref, String fecdes, String fechas) async {
    var url = Uri.http('181.39.96.138:8082', '/contabilidad/cobroscab', {
      'codemp': emp,
      'codref': codref,
      'codmov': tipo,
      'inicio': UtilView.dateFormatYMD(fecdes),
      'fin': UtilView.dateFormatYMD(fechas)
    });

    print(url.toString());

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

  Future<List<FacturaCabecera>> consultaFacturaCabSolo(
      String emp, String codref, String fecdes, String fechas) async {
    var url = Uri.http('181.39.96.138:8082', '/contabilidad/cobroscab', {
      'codemp': emp,
      'codref': codref,
      'codmov': '',
      'inicio': UtilView.dateFormatYMD(fecdes),
      'fin': UtilView.dateFormatYMD(fechas)
    });

    print(url.toString());

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
        '181.39.96.138:8081:8088',
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
    var url = Uri.http('181.39.96.138:8082', '/contabilidad/getCc0020',
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
    var url = Uri.http('181.39.96.138:8082', '/contabilidad/getEmpUser',
        {'grupo': grupo, 'codusr': codusr});
    print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        return parseUsuariosEmp(utf8.decode(respuesta.bodyBytes));
      } else {
        throw Exception('Excepcion' + respuesta.statusCode.toString());
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
    var url = Uri.http('181.39.96.138:8081', '/desarrollosolicitud/getcliente',
        {'empresa': empresa, 'codigo': usuario});

    print(url.toString());

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

  Future<Guia?> queryGuia(String numero) async {
    dynamic resul;
    var url = Uri.http('181.39.96.138:8082', '/contabilidad/getNumeroGuia',
        {'numero': numero});

    print(url.toString());

    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        if (respuesta.body != "") {
          resul = Guia.fromJson(utf8.decode(respuesta.bodyBytes));
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
    var url = Uri.http('181.39.96.138:8082', '/contabilidad/vldClientes',
        {'codemp': empresa, 'codven': ven});
    print(url.toString());
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        resul = respuesta.body == ""
            ? []
            : parseClient(utf8.decode(respuesta.bodyBytes));
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
    var url = Uri.http('181.39.96.138:8082', '/contabilidad/getguias',
        {'usuario': usuario, 'inicio': inicio, 'fin': fin});
    print(url.toString());
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
    var url = Uri.http(
        '181.39.96.138:8081',
        '/desarrollosolicitud/getvenclientes',
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
    var url = Uri.http('181.39.96.138:8082', '/contabilidad/getUsuarioGuia', {
      'empresa': empresa,
      'inicio': inicio,
      'fin': fin,
      'vendedor': vendcode
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

  Future<List<Karmov>> getKarmov(String empresa, String movimiento) async {
    List<Karmov> resul = [];
    var url = Uri.http('181.39.96.138:8082', '/contabilidad/getMovKarmov',
        {'codemp': empresa, 'nummov': movimiento});

    print(url.toString());
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        if (respuesta.body != "") {
          return respuesta.body.toString() != "[]"
              ? parseKarmovResponse(utf8.decode(respuesta.bodyBytes))
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

  List<Karmov> parseKarmovResponse(String respuesta) {
    final parseo = jsonDecode(respuesta);
    return parseo.map<Karmov>((json) => Karmov.fromMap(json)).toList();
  }

  Future<Ig0040Y?> getFacturaIg0040y(String numero) async {
    Ig0040Y? resul;
    var url = Uri.http(
        '181.39.96.138:8082', '/contabilidad/getFactura', {'tipo': numero});

    print(url.toString());
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        if (respuesta.body != "") {
          resul = Ig0040Y.fromJson(utf8.decode(respuesta.bodyBytes));
        }
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  Future<String> getNumeroFecha(String numero) async {
    String resul = "";
    var url = Uri.http('181.39.96.138:8082', '/contabilidad/getFechaMenbrete',
        {'numero': numero});

    print(url.toString());
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        if (respuesta.body != "") {
          resul = utf8.decode(respuesta.bodyBytes);
        }
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  Future<String> getNombreusuario(String codigo) async {
    String resul = "";
    var url = Uri.http('181.39.96.138:8082', '/contabilidad/getNombreMg0032',
        {'empresa': '01', 'cliente': codigo});

    print(url.toString());
    try {
      http.Response respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        if (respuesta.body != "") {
          resul = utf8.decode(respuesta.bodyBytes);
        }
      } else {
        throw Exception('Excepcion ' + respuesta.statusCode.toString());
      }
    } catch (e) {
      throw ('error el en GET: $e');
    }
    return resul;
  }

  //http://181.39.96.138:8081/contabilidad/getUsuarioGuia?empresa=01&vendedor=V009
}
