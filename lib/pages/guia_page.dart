import 'package:app_consulta/provider/guia_provider.dart';
import 'package:app_consulta/style/custom_inputs.dart';
import 'package:app_consulta/utils/date_formatter.dart';
import 'package:app_consulta/widget/util_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GuiaPage extends StatelessWidget {
  const GuiaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de cuentas'),
        backgroundColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
      ),
      backgroundColor: UtilView.convertColor("#abb8c3"),
      body: const BodyPage(),
    );
  }
}

class BodyPage extends StatefulWidget {
  const BodyPage({Key? key}) : super(key: key);

  @override
  State<BodyPage> createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  bool isSwitched = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<GuiaProvider>(context, listen: false).clearComponents2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GuiaProvider>(context);
    final size = MediaQuery.of(context).size;

    void selectDate(String cadena) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );
      if (picked != null) {
        setState(() {
          switch (cadena) {
            case 'init':
              provider.txtInicioUser.text =
                  UtilView.dateFormatDMY(picked.toString());
              break;
            case 'finish':
              provider.txtFinUser.text =
                  UtilView.dateFormatDMY(picked.toString());
              break;

            default:
          }
        });
      }
    }

    return provider.isShow
        ? Center(
            child: Form(
              key: formKey,
              child: Card(
                  elevation: 4,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: Container(
                    width: UtilView.codUser.startsWith("V9")
                        ? 400
                        : size.width / 2,
                    height: size.height / 3,
                    color: Colors.white,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Criterio de filtro de usuarios',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                            controller: provider.txtInicioUser,
                            decoration:
                                CustomInputs.boxInputDecorationDatePicker(
                                    labelText: 'Inicio',
                                    fc: () => selectDate('init')),
                            inputFormatters: [DateFormatter()],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Campo requerido";
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller: provider.txtFinUser,
                            decoration:
                                CustomInputs.boxInputDecorationDatePicker(
                                    labelText: 'Fin',
                                    fc: () => selectDate('finish')),
                            inputFormatters: [DateFormatter()],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Campo requerido";
                              }
                            },
                          ),
                        ),
                        UtilView.codUser.startsWith("V9")
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Row(
                                  children: [
                                    const Text(
                                      'FILTAR VENDEDOR',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Switch(
                                      value: isSwitched,
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitched = value;
                                        });
                                      },
                                    ),
                                    isSwitched
                                        ? SizedBox(
                                            width: 150,
                                            child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              controller:
                                                  provider.txtfindVendedor,
                                              textCapitalization:
                                                  TextCapitalization.characters,
                                              decoration: CustomInputs
                                                  .boxInputDecorationicon(
                                                      hint: 'Busqueda',
                                                      label: 'Busqueda'),
                                              validator: (value) {
                                                if (value!.length < 4) {
                                                  return "CODIGO INVALIDO";
                                                }
                                                return null;
                                              },
                                            ),
                                          )
                                        : const Text('')
                                  ],
                                ),
                              )
                            : const Text(''),
                        OutlinedButton.icon(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  provider.isShow = false;
                                });
                                provider.findQueryClient(
                                    UtilView.codEmp, UtilView.codUser);
                              }
                            },
                            icon: Icon(
                              Icons.search,
                              color: UtilView.convertColor(
                                  UtilView.empresa.cl2Emp),
                            ),
                            label: Text(
                              'Buscar',
                              style: TextStyle(
                                  color: UtilView.convertColor(
                                      UtilView.empresa.cl2Emp)),
                            ))
                      ],
                    ),
                  )),
            ),
          )
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: provider.controllerC,
                          keyboardType: TextInputType.text,
                          decoration:
                              CustomInputs.boxInputDecorationDialogSearch(
                                  hint: 'Busqueda..', label: 'Codigo/Nombre'),
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
                        icon: const Icon(Icons.cleaning_services_rounded),
                        tooltip: "NUEVA BUSQUEDA",
                        highlightColor: const Color.fromARGB(255, 84, 230, 222),
                        splashColor: Colors.grey[350],
                        onPressed: () {
                          setState(() {
                            provider.limpiar();
                          });
                        },
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
                                provider.clearComponents();

                                provider.nomRef =
                                    provider.listUsuario[index].nomRef;
                                provider.nomAux =
                                    provider.listUsuario[index].codAux == ""
                                        ? " SIN AUX "
                                        : provider.listUsuario[index].codAux;
                                provider.dirRef =
                                    provider.listUsuario[index].dirRef;
                                provider.telRef =
                                    provider.listUsuario[index].telRef == ""
                                        ? " SIN TELEFONO "
                                        : provider.listUsuario[index].telRef;

                                provider.codRef =
                                    provider.listUsuario[index].codRef;

                                UtilView.userSeleccionado =
                                    provider.listUsuario[index].codRef;

                                Navigator.pushNamed(context, 'consultaGuia');
                              },
                              title: Text(provider.listUsuario[index].codRef),
                              subtitle: Text(
                                  provider.listUsuario[index].nomRef +
                                      "\n" +
                                      provider.listUsuario[index].cedRuc +
                                      "\n" +
                                      provider.listUsuario[index].telRef +
                                      "\n" +
                                      provider.listUsuario[index].dirRef),
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
