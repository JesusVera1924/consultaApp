import 'package:app_consulta/provider/cuenta_provider.dart';
import 'package:app_consulta/style/custom_inputs.dart';
import 'package:app_consulta/widget/util_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsultaUserPage extends StatelessWidget {
  const ConsultaUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de cuentas'),
        backgroundColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
      ),
      backgroundColor: UtilView.convertColor("#abb8c3"),
      body: const BodyUsuarioPage(),
    );
  }
}

class BodyUsuarioPage extends StatefulWidget {
  const BodyUsuarioPage({Key? key}) : super(key: key);

  @override
  State<BodyUsuarioPage> createState() => _BodyUsuarioPageState();
}

class _BodyUsuarioPageState extends State<BodyUsuarioPage> {
  @override
  void initState() {
    Provider.of<CuentaProvider>(context, listen: false)
        .findQueryClient(UtilView.codEmp, UtilView.codUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CuentaProvider>(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 60 / 100,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: provider.controllerC,
                    keyboardType: TextInputType.text,
                    decoration: CustomInputs.boxInputDecorationFunctionClear(
                        hintText: 'CODIGO',
                        fc: () {
                          provider.controllerC.clear();
                        }),
                    onEditingComplete: () {
                      provider.onSearchTextChanged(
                          provider.controllerC.text.toUpperCase());
                    },
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.5,
                  ),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: "Busqueda Registros",
                  highlightColor: const Color.fromARGB(255, 84, 230, 222),
                  splashColor: Colors.grey[350],
                  onPressed: () => provider.onSearchTextChanged(
                      provider.controllerC.text.toUpperCase()),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        provider.listUsuario.isEmpty
            ? Column(
                children: const [
                  SizedBox(height: 200),
                  Text('Esperando data...',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                  CircularProgressIndicator()
                ],
              )
            : Expanded(
                child: ListView.builder(
                  itemCount: provider.listUsuario.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          provider.findQuery();

                          provider.nomRef =
                              provider.listUsuario[index].ncliente;
                          provider.nomAux =
                              provider.listUsuario[index].nclienteAux == ""
                                  ? " SIN AUX "
                                  : provider.listUsuario[index].nclienteAux;
                          provider.dirRef =
                              provider.listUsuario[index].direccion;
                          provider.telRef =
                              provider.listUsuario[index].telefono == ""
                                  ? " SIN TELEFONO "
                                  : provider.listUsuario[index].telefono;

                          provider.emp = provider.listUsuario[index].cliente;

                          provider.empresa =
                              provider.listUsuario[index].empresa;

                          Navigator.pushNamed(context, 'cuenta');
                        },
                        title: Text(provider.listUsuario[index].ncliente),
                        subtitle: Text(provider.listUsuario[index].cliente +
                            "\n" +
                            provider.listUsuario[index].ruc +
                            "\n" +
                            provider.listUsuario[index].telefono +
                            "\n" +
                            provider.listUsuario[index].direccion),
                        leading: CircleAvatar(
                          child: Image.asset(
                            'lib/image/businessman.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      elevation: 8,
                      margin: const EdgeInsets.all(8),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
