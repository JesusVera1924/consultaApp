import 'package:app_consulta/provider/cuenta_cxc_provider.dart';
import 'package:app_consulta/style/custom_inputs.dart';
import 'package:app_consulta/widget/util_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsultaCxcPage extends StatelessWidget {
  const ConsultaCxcPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de cxc'),
        backgroundColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
      ),
      backgroundColor: UtilView.convertColor("#abb8c3"),
      body: const BodyConsultaPage(),
    );
  }
}

class BodyConsultaPage extends StatefulWidget {
  const BodyConsultaPage({Key? key}) : super(key: key);

  @override
  State<BodyConsultaPage> createState() => _BodyConsultaPageState();
}

class _BodyConsultaPageState extends State<BodyConsultaPage> {
  @override
  void initState() {
    Provider.of<CuentaCxcProvider>(context, listen: false)
        .findQueryClient(UtilView.codEmp, UtilView.codUser);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CuentaCxcProvider>(context);
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
                    textCapitalization: TextCapitalization.characters,
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
                  )),
            ],
          ),
        ),
        const SizedBox(height: 10),
        provider.listClientes.isEmpty
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
                  itemCount: provider.listClientes.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          provider.findQuery();

                          provider.nomRef = provider.listClientes[index].nomRef;
                          provider.nomAux =
                              provider.listClientes[index].codAux == ""
                                  ? " SIN AUX "
                                  : provider.listClientes[index].codAux;
                          provider.dirRef = provider.listClientes[index].dirRef;
                          provider.telRef =
                              provider.listClientes[index].telRef == ""
                                  ? " SIN TELEFONO "
                                  : provider.listClientes[index].telRef;

                          provider.selectCliente =
                              provider.listClientes[index].codRef;

                          Navigator.pushNamed(context, 'consulta');
                        },
                        title: Text(provider.listClientes[index].nomRef),
                        subtitle: Text(provider.listClientes[index].codRef +
                            "\n" +
                            provider.listClientes[index].cedRuc +
                            "\n" +
                            provider.listClientes[index].telRef +
                            "\n" +
                            provider.listClientes[index].dirRef),
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
