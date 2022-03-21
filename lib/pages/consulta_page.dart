import 'package:another_flushbar/flushbar.dart';
import 'package:app_consulta/class/cobranza.dart';
import 'package:app_consulta/class/factura.dart';
import 'package:app_consulta/services/solicitud_api.dart';
import 'package:app_consulta/widget/util_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultaPage extends StatelessWidget {
  const ConsultaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: MyHome());
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  //listas
  List<FacturaCabecera> listFact = []; //tabla de todo los usuarios facturados
  List<FacturaDet> listFactDet = []; //  tabla del detalle de la factura
  List<FacturaDet> listFactDet1 = []; //tabla de el filtro de CODREF Y NUMREF
  List<Cobranza> listClientes = []; //listado de clientes del combo
  List<CuentasPorCobrar> listCxc = [];
  List<CuentasPorCobrar> listCxcFiltro = [];

  //controladores
  final myController = TextEditingController();
  final myFechaStart = TextEditingController();
  final myFechaEnd = TextEditingController();

  //instancias
  SolicitudApi myConexion = SolicitudApi();
  DateTime dateActual = DateTime.now();
  DateTime currentDate = DateTime.now();
  DateTime currentDateHast = DateTime.now();
  //variables de presentacion
  var selectCliente;
  String finalValorEmp = "";
  double totalCartera = 0.0;
  String empresa = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateActual,
      helpText: 'Seleccionar Fecha',
      firstDate: DateTime(2019),
      lastDate: dateActual,
      fieldLabelText: 'Ingresar Fecha',
      fieldHintText: 'Dia-Mes-Año',
    );

    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        myFechaStart.text = DateFormat("dd-MM-yyyy")
            .format(DateTime.parse(currentDate.toString()));
      });
    }
  }

  Future<void> _selectDateAfter(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateActual,
      helpText: 'Seleccionar Fecha',
      firstDate: DateTime(2019),
      lastDate: dateActual,
      fieldLabelText: 'Ingresar Fecha',
      fieldHintText: 'Dia-Mes-Año',
    );

    if (pickedDate != null && pickedDate != currentDateHast) {
      setState(() {
        currentDateHast = pickedDate;
        myFechaEnd.text = DateFormat("dd-MM-yyyy")
            .format(DateTime.parse(currentDateHast.toString()));
      });
    }
  }

  bool rangoFech(DateTime dateDesd, DateTime dateHast) {
    if (dateHast.isAfter(dateDesd)) {
      return true;
    } else {
      return false;
    }
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    finalValorEmp = prefs.getString('codEmp')!;
    var x = await myConexion.consultaClientes(finalValorEmp);
    if (x.isNotEmpty) {
      setState(() {
        listClientes = x;
      });
    }
  }

  void getList(var val, fechdes, fechas) async {
    var x = await myConexion.consultaFacturaCabFech(
        finalValorEmp, 'FC', val, selectCliente, fechdes, fechas);
    setState(() {
      listFact = x;
    });
  }

  void getListDet(var val) async {
    var xp = await myConexion.consultaFacturaDet(
        finalValorEmp, 'FC', val, selectCliente);
    setState(() {
      listFactDet = xp;
    });
  }

  void getListSolofecha(fechdes, fechas) async {
    var x = await myConexion.consultaFacturaCabSolo(
        finalValorEmp, selectCliente, 'FC', fechdes, fechas);
    setState(() {
      listFact = x;
    });
  }

  void getListDetail(x, y) async {
    var result =
        await myConexion.consultaFacturaDet(finalValorEmp, x, y, selectCliente);
    setState(() {
      listFactDet1 = result;
    });
  }

  void getListCxC() async {
    var result =
        await myConexion.consultaCuentasxCobrar(finalValorEmp, selectCliente);
    setState(() {
      listCxc = result;
    });
  }

  Future<List<CuentasPorCobrar>> getListFuturo() async {
    List<CuentasPorCobrar> result = [];
    try {
      result =
          await myConexion.consultaCuentasxCobrar(finalValorEmp, selectCliente);
      total(result);
    } catch (e) {
      print(e.toString());
    }

    return result;
  }

  void total(List<CuentasPorCobrar> list) {
    totalCartera = 0.0;
    double valTotal = 0.0;
    if (list.isNotEmpty) {
      for (var element in list) {
        valTotal += element.total;
      }
      setState(() {
        totalCartera = valTotal;
      });
    }
  }

  @override
  void dispose() {
    myController.dispose();
    myFechaEnd.dispose();
    myFechaStart.dispose();
    super.dispose();
  }

  @override
  void initState() {
    myFechaEnd.text =
        DateFormat("dd-MM-yyyy").format(DateTime.parse(dateActual.toString()));
    myFechaStart.text = DateFormat("dd-MM-yyyy")
        .format(dateActual.add(const Duration(days: -365)));
    loadData(); 
    super.initState();
  }

  dataBody(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
            headingRowColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              return Theme.of(context).colorScheme.secondary;
            }),
            showCheckboxColumn: false,
            columnSpacing: 30,
            columns: const [
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Tipo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                numeric: false,
                tooltip: "Escribir descripcion...",
              ),
              DataColumn(
                  label: Expanded(
                    child: Text(
                      'Numero',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  numeric: false,
                  tooltip: "Escribir descripcion..."),
              DataColumn(
                  label: Expanded(
                      child: Text(
                    'Fecha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                  numeric: false,
                  tooltip: "Escribir descripcion..."),
              DataColumn(
                  label: Expanded(
                      child: Text(
                    'Recibo',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
                  numeric: false,
                  tooltip: "Escribir descripcion..."),
              DataColumn(
                  label: Expanded(
                      child: Text(
                    'Valor',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
                  numeric: false,
                  tooltip: "Escribir descripcion..."),
              DataColumn(
                  label: Expanded(
                      child: Text(
                    'Saldo',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
                  numeric: false,
                  tooltip: "Escribir descripcion..."),
            ],
            rows: listFact
                .map((fact) => DataRow(
                      onSelectChanged: (value) async {
                        if (fact.valMov != fact.sdoMov) {
                          getListDet(fact.numMov);
                          setState(() {
                            showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    content: (SizedBox(
                                      height: 400,
                                      child: Column(
                                        children: [
                                          Text(
                                            'FC: ' + fact.numMov,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 21),
                                          ),
                                          const SizedBox(
                                            height: 35.0,
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: DataTable(
                                                showCheckboxColumn: false,
                                                columns: const [
                                                  DataColumn(
                                                      label: Expanded(
                                                        child: Text(
                                                          'Mov',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                  DataColumn(
                                                      label: Expanded(
                                                        child: Text(
                                                          'Numero',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion.."),
                                                  DataColumn(
                                                      label: Expanded(
                                                          child: Text(
                                                        'Valor',
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                ],
                                                rows: listFactDet
                                                    .map((det) => DataRow(
                                                            onSelectChanged:
                                                                (value) async {
                                                              if (det.codMov !=
                                                                      "RF" &&
                                                                  det.codMov !=
                                                                      "NC") {
                                                                getListDetail(
                                                                    det.codMov,
                                                                    det.numMov);
                                                                if (listFactDet1
                                                                    .isNotEmpty) {
                                                                  showDialog(
                                                                    barrierDismissible:
                                                                        true,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                        shape: const RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(20.0))),
                                                                        content:
                                                                            SizedBox(
                                                                          height:
                                                                              400,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Text(
                                                                                'Factura: ' + det.numMov,
                                                                                style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 21),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 35.0,
                                                                              ),
                                                                              SingleChildScrollView(
                                                                                scrollDirection: Axis.horizontal,
                                                                                child: DataTable(
                                                                                    horizontalMargin: 5,
                                                                                    columnSpacing: 30,
                                                                                    columns: const [
                                                                                      DataColumn(
                                                                                          label: Expanded(
                                                                                              child: Text(
                                                                                            'Mov',
                                                                                            textAlign: TextAlign.center,
                                                                                          )),
                                                                                          numeric: false,
                                                                                          tooltip: "Movimiento"),
                                                                                      DataColumn(
                                                                                          label: Expanded(
                                                                                              child: Text(
                                                                                            'Numero',
                                                                                            textAlign: TextAlign.center,
                                                                                          )),
                                                                                          numeric: false,
                                                                                          tooltip: "Numero de Movimiento"),
                                                                                      DataColumn(
                                                                                          label: Expanded(
                                                                                              child: Text(
                                                                                            'Valor',
                                                                                            textAlign: TextAlign.center,
                                                                                          )),
                                                                                          numeric: false,
                                                                                          tooltip: "Valor"),
                                                                                      DataColumn(
                                                                                          label: Expanded(
                                                                                              child: Text(
                                                                                            'Banco',
                                                                                            textAlign: TextAlign.center,
                                                                                          )),
                                                                                          numeric: false,
                                                                                          tooltip: "Banco"),
                                                                                      DataColumn(
                                                                                          label: Expanded(
                                                                                              child: Text(
                                                                                            'Cuenta',
                                                                                            textAlign: TextAlign.center,
                                                                                          )),
                                                                                          numeric: false,
                                                                                          tooltip: "Cuenta"),
                                                                                      DataColumn(
                                                                                          label: Expanded(
                                                                                              child: Text(
                                                                                            'NumCta',
                                                                                            textAlign: TextAlign.center,
                                                                                          )),
                                                                                          numeric: false,
                                                                                          tooltip: "Numero de Cuenta"),
                                                                                    ],
                                                                                    rows: listFactDet1
                                                                                        .map((detail) => DataRow(cells: [
                                                                                              DataCell(
                                                                                                Align(alignment: Alignment.centerLeft, child: Text(detail.codMov)),
                                                                                              ),
                                                                                              DataCell(
                                                                                                Align(alignment: Alignment.centerLeft, child: Text(detail.numMov)),
                                                                                              ),
                                                                                              DataCell(
                                                                                                Align(
                                                                                                  alignment: Alignment.centerRight,
                                                                                                  child: Text("${detail.valMov.toStringAsFixed(2)}"),
                                                                                                ),
                                                                                              ),
                                                                                              DataCell(
                                                                                                Align(alignment: Alignment.centerLeft, child: Text(detail.codBco)),
                                                                                              ),
                                                                                              DataCell(
                                                                                                Align(alignment: Alignment.centerLeft, child: Text(detail.numCta)),
                                                                                              ),
                                                                                              DataCell(Align(alignment: Alignment.centerLeft, child: Text(detail.nunCta))),
                                                                                            ]))
                                                                                        .toList()),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                }
                                                              }
                                                            },
                                                            cells: [
                                                              DataCell(
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        det.codMov)),
                                                              ),
                                                              DataCell(
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        det.numMov)),
                                                              ),
                                                              DataCell(
                                                                Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child: Text(det
                                                                      .valMov
                                                                      .toStringAsFixed(
                                                                          2)),
                                                                ),
                                                              ),
                                                            ]))
                                                    .toList()),
                                          )
                                        ],
                                      ),
                                    )),
                                  );
                                });
                          });
                        }
                      },
                      cells: [
                        DataCell(
                          Text(fact.codMov),
                        ),
                        DataCell(
                          Text(fact.numMov),
                        ),
                        DataCell(
                          Text((DateFormat("dd-MM-yyyy")
                              .format(DateTime.parse(fact.fecEmi.toString())))),
                        ),
                        DataCell(
                          Text(fact.numRel),
                        ),
                        DataCell(
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text(fact.valMov.toStringAsFixed(2))),
                        ),
                        DataCell(
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                fact.sdoMov.toStringAsFixed(2),
                              )),
                        ),
                      ],
                    ))
                .toList()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Consulta'),
          backgroundColor: UtilView.convertColor(UtilView.empresa.cl2Emp),
        ),
        /* 
        resizeToAvoidBottomPadding: false, */
        body: Padding(
          padding: const EdgeInsets.fromLTRB(29.0, 45.0, 29.0, 10.0),
          child: Column(
            children: [
              SizedBox(
                height: 35.0,
                child: listClientes.isNotEmpty
                    ? DropdownButton<String>(
                        isExpanded: true,
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        hint: const Text("Seleccione una Opcion "),
                        value: selectCliente,
                        isDense: true,
                        onChanged: (value) {
                          setState(() {
                            selectCliente = value;
                            listFact = [];
                          });
                          print(selectCliente);
                        },
                        items: listClientes.map((Cobranza map) {
                          return DropdownMenuItem<String>(
                            value: map.codRef,
                            child: Text(map.codRef + " - " + map.nomRef,
                                style: TextStyle(color: Colors.black)),
                          );
                        }).toList())
                    : const Text('Cargando lista de clientes........'),
              ),
              const SizedBox(
                height: 11.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 75.0,
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: myController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Numero',
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.white,
                              offset: Offset(-4, -4),
                              blurRadius: 5,
                              spreadRadius: 2),
                          BoxShadow(
                              color: Colors.grey.shade300,
                              offset: Offset(1, 2),
                              blurRadius: 5,
                              spreadRadius: 1)
                        ]),
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      tooltip: "Busqueda de las Facturas de los clientes ",
                      highlightColor: Colors.amberAccent,
                      splashColor: Colors.grey[350],
                      onPressed: () {
                        //metodo para la vista y control de fechas
                        if (myController.text != "" &&
                            myFechaStart.text != "" &&
                            myFechaEnd.text != "") {
                          if (rangoFech(currentDate, currentDateHast)) {
                            //metodo
                            getList(myController.text, myFechaStart.text,
                                myFechaEnd.text);
                            myController.text = "";
                          } else {
                            Flushbar(
                              margin: EdgeInsets.all(8),
                              title: "Info",
                              message:
                                  "Fecha de Hasta: es menor a la Fecha Desde",
                              icon: Icon(
                                Icons.info_outline,
                                size: 28.0,
                                color: Colors.blue[300],
                              ),
                              duration: const Duration(seconds: 3),
                            ).show(context);
                          }
                        } else if (myController.text == "" &&
                            myFechaStart.text != "" &&
                            myFechaEnd.text != "") {
                          getListSolofecha(myFechaStart.text, myFechaEnd.text);
                        } else {
                          Flushbar(
                            margin: const EdgeInsets.all(8),
                            title: "Info",
                            message:
                                "Algunos de los parametros de busqueda esta vacio",
                            icon: Icon(
                              Icons.info_outline,
                              size: 28.0,
                              color: Colors.blue[400],
                            ),
                            duration: Duration(seconds: 3),
                          ).show(context);
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  RaisedButton(
                    color: Colors.white,
                    onPressed: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            content: SizedBox(
                              height: 400,
                              child: Column(
                                children: [
                                  Text(
                                    'Resumen de Cartera',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21),
                                  ),
                                  const SizedBox(
                                    height: 25.0,
                                  ),
                                  FutureBuilder<List<CuentasPorCobrar>>(
                                    future: getListFuturo(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<CuentasPorCobrar> data =
                                            snapshot.data!;
                                        return Column(
                                          children: [
                                            SingleChildScrollView(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0),
                                              scrollDirection: Axis.horizontal,
                                              child: DataTable(
                                                headingRowColor:
                                                    MaterialStateProperty
                                                        .resolveWith<Color>(
                                                            (Set<MaterialState>
                                                                states) {
                                                  return Theme.of(context)
                                                      .colorScheme
                                                      .primary;
                                                }),
                                                showCheckboxColumn: false,
                                                columns: const [
                                                  DataColumn(
                                                      label: Expanded(
                                                          child: Text(
                                                        'Transaccion',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                  DataColumn(
                                                      label: Expanded(
                                                          child: Text(
                                                        'Total',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                ],
                                                rows: data
                                                    .map((e) => DataRow(cells: [
                                                          DataCell(
                                                            Text(e.docXCob),
                                                          ),
                                                          DataCell(
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                  "${e.total.toStringAsFixed(2)}"),
                                                            ),
                                                          ),
                                                        ]))
                                                    .toList(),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.symmetric(
                                                    horizontal: BorderSide(
                                                        color: Colors.grey)),
                                                color: Colors.amberAccent,
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 24.0,
                                                  ),
                                                  Expanded(
                                                      flex: 2,
                                                      child: Text("Total:  ")),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 12,
                                                            top: 12,
                                                            right: 24,
                                                            left: 12),
                                                    child: Container(
                                                      child: Text(
                                                        '${totalCartera.toStringAsFixed(2)}',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      } else {
                                        return Container(
                                          child: Center(
                                            child: Column(
                                              children: [
                                                CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          Colors.blue),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text('CXC'),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              content: Container(
                                  height: 600,
                                  child: FutureBuilder<List<CuentasPorCobrar>>(
                                    future: getListFuturo(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<CuentasPorCobrar> data =
                                            snapshot.data!;
                                        return Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Vencido ',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            SingleChildScrollView(
                                              padding:
                                                  EdgeInsets.only(top: 10.0),
                                              scrollDirection: Axis.horizontal,
                                              child: DataTable(
                                                headingRowColor:
                                                    MaterialStateProperty
                                                        .resolveWith<Color>(
                                                            (Set<MaterialState>
                                                                states) {
                                                  return Theme.of(context)
                                                      .colorScheme
                                                      .primary;
                                                }),
                                                horizontalMargin: 10,
                                                showCheckboxColumn: false,
                                                columnSpacing: 15.0,
                                                columns: [
                                                  DataColumn(
                                                      label: Expanded(
                                                          child: Text(
                                                        'Tp',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                  DataColumn(
                                                      label: Expanded(
                                                          child: Text(
                                                        '001-030',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                  DataColumn(
                                                      label: Expanded(
                                                        child: Text(
                                                          '030-060',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                  DataColumn(
                                                      label: Expanded(
                                                        child: Text(
                                                          '060-090',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                  DataColumn(
                                                      label: Expanded(
                                                        child: Text(
                                                          '090-120',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                  DataColumn(
                                                      label: Expanded(
                                                        child: Text(
                                                          '120-150',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                  DataColumn(
                                                      label: Expanded(
                                                        child: Text(
                                                          '--->150',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                ],
                                                rows: data
                                                    .map((e) => DataRow(cells: [
                                                          DataCell(
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    e.docXCob)),
                                                          ),
                                                          DataCell(
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                    "${e.f130Dias.toStringAsFixed(2)}")),
                                                          ),
                                                          DataCell(
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                    "${e.f3060Dias.toStringAsFixed(2)}")),
                                                          ),
                                                          DataCell(
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                    "${e.f6090Dias.toStringAsFixed(2)}")),
                                                          ),
                                                          DataCell(
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                    "${e.f90120Dias.toStringAsFixed(2)}")),
                                                          ),
                                                          DataCell(
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                    "${e.f120150Dias.toStringAsFixed(2)}")),
                                                          ),
                                                          DataCell(
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(
                                                                    "${e.fMas150Dias.toStringAsFixed(2)}")),
                                                          ),
                                                        ]))
                                                    .toList(),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Por Vencer ',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            SingleChildScrollView(
                                              padding:
                                                  EdgeInsets.only(top: 10.0),
                                              scrollDirection: Axis.horizontal,
                                              child: DataTable(
                                                headingRowColor:
                                                    MaterialStateProperty
                                                        .resolveWith<Color>(
                                                            (Set<MaterialState>
                                                                states) {
                                                  return Theme.of(context)
                                                      .colorScheme
                                                      .primary;
                                                }),
                                                horizontalMargin: 10,
                                                showCheckboxColumn: false,
                                                columnSpacing: 15.0,
                                                columns: const [
                                                  DataColumn(
                                                      label: Expanded(
                                                          child: Text(
                                                        'Tp',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                  DataColumn(
                                                      label: Expanded(
                                                          child: Text(
                                                        '000-030',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                  DataColumn(
                                                      label: Expanded(
                                                          child: Text(
                                                        '030-060',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                  DataColumn(
                                                      label: Expanded(
                                                          child: Text(
                                                        '060-090',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                  DataColumn(
                                                      label: Expanded(
                                                          child: Text(
                                                        '090-120',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                  DataColumn(
                                                      label: Expanded(
                                                          child: Text(
                                                        '120-150',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                  DataColumn(
                                                      label: Expanded(
                                                          child: Text(
                                                        '--->150',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                      numeric: false,
                                                      tooltip:
                                                          "Escribir descripcion..."),
                                                ],
                                                rows: data
                                                    .map((e) => DataRow(cells: [
                                                          DataCell(
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    e.docXCob)),
                                                          ),
                                                          DataCell(
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(e
                                                                    .vMas150Dias
                                                                    .toStringAsFixed(
                                                                        2))),
                                                          ),
                                                          DataCell(
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(e
                                                                    .v120150Dias
                                                                    .toStringAsFixed(
                                                                        2))),
                                                          ),
                                                          DataCell(
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(e
                                                                    .v90120Dias
                                                                    .toStringAsFixed(
                                                                        2))),
                                                          ),
                                                          DataCell(
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(e
                                                                    .v6090Dias
                                                                    .toStringAsFixed(
                                                                        2))),
                                                          ),
                                                          DataCell(
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(e
                                                                    .v3060Dias
                                                                    .toStringAsFixed(
                                                                        2))),
                                                          ),
                                                          DataCell(
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Text(e
                                                                    .v030Dias
                                                                    .toStringAsFixed(
                                                                        2))),
                                                          ),
                                                        ]))
                                                    .toList(),
                                              ),
                                            )
                                          ],
                                        );
                                      } else {
                                        return Center(
                                          child: Column(
                                            children: const [
                                              CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.blue),
                                              ),
                                              Text("Cargando Datos...")
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  )),
                            );
                          });
                    },
                    color: Colors.white,
                    child: Text('CxC.Edad'),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2,
                        child: TextField(
                          controller: myFechaStart,
                          onTap: () {
                            _selectDate(context);
                          },
                          readOnly: true,
                          decoration: const InputDecoration(
                              hintText: 'Desde:',
                              prefixIcon: Icon(Icons.date_range),
                              suffixIcon: Icon(Icons.arrow_drop_down)),
                        )),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                        flex: 2,
                        child: TextField(
                            readOnly: true,
                            controller: myFechaEnd,
                            onTap: () {
                              _selectDateAfter(context);
                            },
                            decoration: const InputDecoration(
                                hintText: 'Hasta:',
                                prefixIcon: Icon(Icons.date_range),
                                suffixIcon: Icon(Icons.arrow_drop_down))))
                  ],
                ),
              ),
              listFact.isNotEmpty
                  ? dataBody(context)
                  : const SizedBox(
                      height: 150,
                      child: Center(
                        child: Text(
                          '......',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }
}
