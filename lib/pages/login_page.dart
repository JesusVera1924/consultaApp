import 'package:another_flushbar/flushbar.dart';
import 'package:app_consulta/class/users.dart';
import 'package:app_consulta/dialog/dialog_aceptar.dart';
import 'package:app_consulta/services/conexion.dart';
import 'package:app_consulta/services/solicitud_api.dart';
import 'package:app_consulta/widget/util_view.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodyLogeo(),
    );
  }
}

class BodyLogeo extends StatefulWidget {
  const BodyLogeo({Key? key}) : super(key: key);

  @override
  State<BodyLogeo> createState() => _BodyLogeoState();
}

class _BodyLogeoState extends State<BodyLogeo> {
  final myControllerUsuario = TextEditingController();
  final myControllerPass = TextEditingController();
  Map _source = {ConnectivityResult.none: false};
  final MyConnectivity _connectivity = MyConnectivity.instance;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SolicitudApi api = SolicitudApi();
    String string = "";
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        string = "Offline";
        break;
      case ConnectivityResult.mobile:
        string = "Mobile: Online";
        break;
      case ConnectivityResult.wifi:
        string = "WiFi: Online";
    }
    return Scaffold(
        body: string.contains('Online')
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        const Image(
                          width: double.infinity,
                          height: 360.0,
                          fit: BoxFit.cover,
                          image: AssetImage('lib/image/fondoLogo.jpg'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 50.0),
                        )
                      ],
                    ),
                    Transform.translate(
                      offset: const Offset(0.0, -20.0),
                      child: Container(
                        width: double.infinity,
                        height: 500,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  'Bienvenido a la App',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30.0),
                                ),
                                const Text(
                                  'Bienvenido a la App',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0),
                                ),
                                _emailInput(myControllerUsuario),
                                _passwordInput(myControllerPass),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.amber,
                                      shape: const StadiumBorder()),
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    final SharedPreferences preferences =
                                        await SharedPreferences.getInstance();

                                    var empresa = "";
                                    List<User> list;

                                    list = await api.getLogin(
                                        myControllerUsuario.text.trim(),
                                        myControllerPass.text.trim());

                                    if (list.isNotEmpty) {
                                      final listEmp = await api.consultaUserEmp(
                                          'CMOV', list.first.codUsr);

                                      if (listEmp.length > 1) {
                                        empresa = await dialogAcepCanc(
                                            context,
                                            'Seleccione empresa',
                                            listEmp,
                                            Icons.emoji_people_rounded,
                                            Colors.black);
                                      } else {
                                        empresa = listEmp.isEmpty
                                            ? list.first.codEmp
                                            : listEmp.first.codEmp;
                                      }

                                      await preferences.setString(
                                          'name', myControllerUsuario.text);
                                      await preferences.setString(
                                          'codEmp',
                                          empresa == ""
                                              ? list.first.codEmp
                                              : empresa);
                                      await preferences.setString(
                                          'ykkk', list.first.nomYkk);
                                      await preferences.setString(
                                          'codusr', list.first.codUsr);

                                      UtilView.empresa =
                                          await api.getSettingEmp(empresa);

                                      UtilView.codEmp = empresa == ""
                                          ? list.first.codEmp
                                          : empresa;

                                      UtilView.codUser = list.first.codUsr;

                                      myControllerUsuario.clear();
                                      myControllerPass.clear();

                                      Navigator.pushNamed(context, 'menu');
                                    } else {
                                      UtilView.messageWarning(
                                          "Usuario o contraseña incorrectos",
                                          context);
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  },
                                  child: (isLoading)
                                      ? const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 1.5,
                                          ))
                                      : const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            'Iniciar Session',
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                )

                                /*    _buttonLogin(context, myControllerUsuario,
                                    myControllerPass), */
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Estableciendo conexion....',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ));
  }
}

Widget _emailInput(control) {
  return Container(
    margin: const EdgeInsets.only(top: 40.0),
    padding: const EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: const Color.fromRGBO(142, 142, 147, 1.2),
        borderRadius: BorderRadius.circular(30.0)),
    child: TextFormField(
      textCapitalization: TextCapitalization.characters,
      controller: control,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          hintText: 'Usuario',
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    ),
  );
}

Widget _passwordInput(control) {
  return Container(
    margin: const EdgeInsets.only(top: 15.0),
    padding: const EdgeInsets.only(left: 20.0),
    decoration: BoxDecoration(
        color: const Color.fromRGBO(142, 142, 147, 1.2),
        borderRadius: BorderRadius.circular(30.0)),
    child: TextFormField(
      controller: control,
      keyboardType: TextInputType.number,
      obscureText: true,
      decoration: const InputDecoration(
          hintText: 'Password',
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    ),
  );
}
