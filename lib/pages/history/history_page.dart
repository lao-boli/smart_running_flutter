import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:race_flutter/components/AppAutoComplete.dart';
import 'package:race_flutter/components/AppDataTable.dart';
import 'package:race_flutter/components/AppDropdownMenu.dart';
import 'package:race_flutter/components/AppTextField.dart';
import 'package:race_flutter/model/train_record.dart';

import 'history_logic.dart';

class HistoryDataSource extends AppDataSource {
  final List<TrainRecord> data;

  HistoryDataSource(this.data);

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
    double? weight = data[index].weight;
    double? height = data[index].height;
    double bmi = weight! / pow(height ?? 1, 2);
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${data[index].id}')),
        DataCell(Text('${data[index].name}')),
        DataCell(Text('${data[index].gender}')),
        DataCell(Text('${data[index].age}')),
        DataCell(Text('$height')),
        DataCell(Text('$weight')),
        DataCell(Text(bmi.toStringAsFixed(2))),
        DataCell(Text(data[index].athlete! ? '是' : '否')),
        DataCell(Text('${data[index].time}')),
        DataCell(Text('${data[index].vo2max?.toStringAsFixed(2)}')),
        DataCell(ElevatedButton(
          onPressed: () {},
          child: Text('加入对比'),
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

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);

  final logic = Get.put(HistoryLogic());
  final state = Get.find<HistoryLogic>().state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(16), // 设置圆角大小为 8
                        ),
                        child: Text(
                          '数据查询及筛选',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppAutocomplete(
                      labelText: '你想查谁的数据',
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const AppTextField(
                      labelText: '年龄',
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppDropdownMenu(
                        hintText: '性别', list:() => <String>['男', '女']),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppDropdownMenu(
                        width: 300,
                        hintText: '是否运动员',
                        list:() => <String>['是', '否']),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                      width: 800,
                      child: AppDataTable(labels: [
                        'ID',
                        '姓名',
                        '性别',
                        '年龄',
                        '身高',
                        '体重',
                        'BMI',
                        '是否运动员',
                        '测试日期',
                        '预测VO2max',
                        '操作'
                      ], dataSource: HistoryDataSource(buildTestData()))),
                )
              ],
            ),
          ],
        ),
      ),
    );
    ;
  }

  List<TrainRecord> buildTestData() {
    List<TrainRecord> _data = [];
    List.generate(100, (index) {
      var record = TrainRecord();
      record.id = index;
      record.name = 'test$index';
      record.age = index % 50;
      record.gender = index % 2 == 0 ? '男' : '女';
      record.height = index * 1.0;
      record.weight = index * 1.0;
      record.athlete = index % 2 == 0;
      record.vo2max = index * Random.secure().nextDouble();
      _data.add(record);
    });
    return _data;
  }
}
