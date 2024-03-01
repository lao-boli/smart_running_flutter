import 'package:flutter/material.dart';
import 'package:race_flutter/components/AppDataTable.dart';
import 'package:race_flutter/model/user.dart';

class UserDataSource extends AppDataSource {
  List<User> data;

  UserDataSource(this.data);

  void updateData(List<User> newData) {
    data = newData;
    notifyListeners();
  }

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
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${data[index].id}')),
        DataCell(Text('${data[index].name}')),
        DataCell(Text('${data[index].gender}')),
        DataCell(Text('${data[index].roleName}')),
        DataCell(Text('${data[index].unitName}')),
        DataCell(Text('${data[index].phone}')),
        DataCell(Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('修改'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('删除'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('权限'),
            ),
          ],
        )),
      ],
    );
  }

  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class UserState {
  UserDataSource dataSource = UserDataSource([]);

  UserState() {
    dataSource = UserDataSource([]);
  }
}
