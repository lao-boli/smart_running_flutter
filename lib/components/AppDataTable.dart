import 'package:flutter/material.dart';

/// Flutter code sample for [PaginatedDataTable].

class AppDataSource extends DataTableSource {
  void setData(List<List<Comparable<Object>>> rawData, int sortColumn,
      bool sortAscending) {
    notifyListeners();
  }

  static DataCell cellFor(Object data) {
    String value;
    if (data is DateTime) {
      value =
          '${data.year}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}';
    } else {
      value = data.toString();
    }
    return DataCell(Text(value));
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow? getRow(int index) {
    throw UnimplementedError();
  }

  @override
  int get rowCount => throw UnimplementedError();
}

class AppDataTable extends StatefulWidget {
  final List<String> labels;
  final AppDataSource dataSource;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int?>? onRowsPerPageChanged;

  const AppDataTable(
      {super.key,
      required this.labels,
      required this.dataSource,
      this.onPageChanged,
      this.onRowsPerPageChanged});

  @override
  State<AppDataTable> createState() => _AppDataTableState();
}

class _AppDataTableState extends State<AppDataTable> {
  late AppDataSource dataSource;
  late List<String> labels;
  late ValueChanged<int>? onPageChanged;
  late ValueChanged<int?>? onRowsPerPageChanged;

  int _columnIndex = 0;
  bool _columnAscending = true;

  @override
  void initState() {
    super.initState();
    labels = widget.labels;
    dataSource = widget.dataSource;
    onPageChanged = widget.onPageChanged;
    onRowsPerPageChanged = widget.onRowsPerPageChanged;
  }

  List<DataColumn> buildDataColumns(List<String> labels) {
    return labels.map((label) {
      return DataColumn(
        label: Text(label),
        onSort: _sort,
      );
    }).toList();
  }

  void _sort(int columnIndex, bool ascending) {
    setState(() {
      _columnIndex = columnIndex;
      _columnAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      onPageChanged: onPageChanged,
      sortColumnIndex: _columnIndex,
      sortAscending: _columnAscending,
      columns: buildDataColumns(labels),
      source: dataSource,
    );
  }
}
