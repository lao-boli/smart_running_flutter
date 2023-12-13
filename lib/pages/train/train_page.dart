import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:race_flutter/components/AppDataTable.dart';
import 'package:race_flutter/components/AppDropdownMenu.dart';

import 'package:race_flutter/components/AppTextField.dart';
import 'package:race_flutter/model/user.dart';
import 'train_logic.dart';

class TrainDataSource extends AppDataSource {
  final List<User> data;

  TrainDataSource(this.data);

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
        DataCell(Text('${data[index].age}')),
        DataCell(Text('${data[index].height}')),
        DataCell(Text('${data[index].weight}')),
        DataCell(Text(data[index].athlete! ? '是':'否')),
        DataCell(Text('${data[index].bracelet}')),
      ],
    );
  }

  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class TrainPage extends StatelessWidget {
  TrainPage({Key? key}) : super(key: key);

  final logic = Get.put(TrainLogic());
  final state = Get.find<TrainLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const AppTextField(
                    labelText: '姓名',
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const AppTextField(
                    labelText: '性别',
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppDropdownMenu(
                      hintText: '手环',
                      list: <String>['One', 'Two', 'Three', 'Four']),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                    width: 800,
                    child: AppDataTable(
                        labels: ['ID','姓名', '性别', '年龄','身高','体重','是否运动员','手环'],
                        dataSource: TrainDataSource(buildTestData()))),
              )
            ],
          ),
        ],
      ),
    );
  }

  List<User> buildTestData() {
    List<User> _data = [];
    List.generate(100, (index) {
      var user = User();
      user.id = index;
      user.name = 'test$index';
      user.age = index % 50;
      user.gender = index % 2 == 0 ? '男' : '女';
      user.height = index * 1.0;
      user.weight = index * 1.0;
      user.athlete = index % 2 == 0;
      user.bracelet = 'bracelet$index' ;
      _data.add(user);
    });
    return _data;
  }
}
