import 'package:app_consulta/widget/util_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String? usuario = "";
  String? correo = "";
  String? empresa = "";

  Future getValues() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var xusuario = preferences.getString('name');
    var xcorreo = preferences.getString('ykkk');
    var xempresa = preferences.getString('codEmp')!;

    setState(() {
      usuario = xusuario;
      correo = xcorreo;
      empresa = xempresa;
    });
  }

  @override
  void initState() {
    getValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime anio = DateTime.now();
    return Scaffold(
        appBar: AppBar(
          title: Text('Menu'.toUpperCase()),
          backgroundColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
        ),
        drawer: MenuLateral(email: usuario!, user: correo!, empresa: empresa!),
        body: Column(
          children: [
            const Spacer(),
            Center(
              child: Image(
                width: 250.0,
                height: 250.0,
                image: AssetImage(empresa == "01"
                    ? 'lib/image/cojapanwp.png'
                    : 'lib/image/logo.jpg'),
              ),
            ),
            const Spacer(),
            Text(
              'Powered by Tecosistemas  Copyrigh (c) ${anio.year}',
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            )
          ],
        ));
  }
}

class MenuLateral extends StatefulWidget {
  final String email;
  final String user;
  final String empresa;

  const MenuLateral(
      {Key? key,
      required this.email,
      required this.user,
      required this.empresa})
      : super(key: key);

  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: UtilView.convertColor(UtilView.empresa.cl3Emp)
                  //UtilView.convertColor(UtilView.empresa.cl2Emp)
                  ),
              child: Stack(children: <Widget>[
                Positioned(
                    bottom: 12.0,
                    left: 16.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 140,
                          height: 80,
                          child: widget.empresa == "01"
                              ? Image.asset(
                                  "lib/image/cojapanwp.png",
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(
                                  "lib/image/logo.jpg",
                                  fit: BoxFit.fill,
                                ),
                        ),
                        Text(
                          widget.email + "\n" + widget.user,
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    )),
              ])),
          /*   ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text("Estado de cuenta"),
            onTap: () {
              Navigator.pushNamed(context, 'consultausercxc');
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Consulta depositos'),
            onTap: () => Navigator.pushNamed(context, 'consultaUser'),
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Consulta de guias'),
            onTap: () => Navigator.pushNamed(context, 'guia'),
          ), */
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Consulta de factura'),
            onTap: () => Navigator.pushNamed(context, 'consultafactura'),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_outlined),
            title: const Text("Salir"),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('name');
              prefs.remove('ykkk');
              prefs.remove('codEmp');
              Navigator.pushNamed(context, 'login');
            },
          ),
        ],
      ),
    );
  }
}
