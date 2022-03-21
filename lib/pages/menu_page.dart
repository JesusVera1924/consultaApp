import 'package:app_consulta/widget/util_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Titulo de menu'),
        backgroundColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
      ),
      drawer: const MenuLateral(),
      body: const Center(
        child: Text('Inicio'),
      ),
    );
  }
}

class MenuLateral extends StatefulWidget {
  const MenuLateral({Key? key}) : super(key: key);

  @override
  _MenuLateralState createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  String finalValor = "";
  String preYkk = "";
  String finalValorEmp = "";

  Future getValues() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var usuario = preferences.getString('name');
    var email = preferences.getString('ykkk');
    finalValorEmp = preferences.getString('codEmp')!;

    setState(() {
      finalValor = usuario!;
      preYkk = email!;
    });
  }

  @override
  void initState() {
    getValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('lib/image/menu.jpg'))),
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
                          child: finalValorEmp == "01"
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
                          finalValor + "\n" + preYkk,
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    )),
              ])),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text("Estado de cuenta"),
            onTap: () {
              Navigator.pushNamed(context, 'consulta');
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
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_outlined),
            title: const Text("Salir"),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('name');
              Navigator.pushNamed(context, 'login');
            },
          ),
        ],
      ),
    );
  }
}
