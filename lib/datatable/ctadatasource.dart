import 'package:app_consulta/class/cc0020.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter/material.dart';

class CtaDataSource extends DataGridSource {
  CtaDataSource(this.list, this.context) {
    buildDataGridRows();
  }

  List<DataGridRow> _dataGridRows = <DataGridRow>[];

  final List<Cc0020> list;
  final BuildContext context;

  /// Building DataGridRows
  void buildDataGridRows() {
    _dataGridRows = list.map<DataGridRow>((Cc0020 team) {
      return DataGridRow(cells: <DataGridCell>[
        DataGridCell<DateTime>(columnName: 'fecha', value: team.fecVen),
        DataGridCell<String>(columnName: 'cuenta', value: team.nunCta),
        DataGridCell<String>(columnName: 'valor', value: team.valMov),
        DataGridCell<String>(columnName: 'cobrador', value: team.codCob),
        DataGridCell<String>(columnName: 'codigo', value: team.codBco),
        DataGridCell<String>(columnName: 'banco', value: team.nomRef),
        DataGridCell<DateTime>(columnName: 'fechaE', value: team.fecEmi),
      ]);
    }).toList();
  }

  // Overrides
  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: <Widget>[
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        child: Text(
          DateFormat('dd/MM/yy').format(row.getCells()[0].value),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[1].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.centerRight,
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[3].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[4].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        alignment: Alignment.center,
        child: Text(
          row.getCells()[5].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        child: Text(
          DateFormat('dd/MM/yy').format(row.getCells()[6].value),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }
}
