import 'package:app_consulta/pages/consulta_guia_page.dart';
import 'package:app_consulta/pages/consulta_page.dart';
import 'package:app_consulta/pages/consulta_user_page.dart';
import 'package:app_consulta/pages/cuentas_page.dart';
import 'package:app_consulta/pages/guia_page.dart';
import 'package:app_consulta/pages/login_page.dart';
import 'package:app_consulta/pages/menu_page.dart';
import 'package:flutter/material.dart';


final routes = <String, WidgetBuilder>{
  'login': (BuildContext context) => const LoginPage(),
  'menu': (BuildContext context) => const MenuPage(),
  'consulta': (BuildContext context) => const ConsultaPage(),
  'cuenta': (BuildContext context) => const CuentasPage(),
  'consultaUser': (BuildContext context) => const ConsultaUserPage(),
  'consultaGuia': (BuildContext context) => const ConsultaGuiaPage(),
  'guia': (BuildContext context) => const GuiaPage(),
  
};
