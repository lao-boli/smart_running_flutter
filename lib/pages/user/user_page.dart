import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:race_flutter/components/AppAutoComplete.dart';
import 'package:race_flutter/components/AppDataTable.dart';
import 'package:race_flutter/components/AppDropdownMenu.dart';
import 'package:race_flutter/components/AppTextField.dart';
import 'package:race_flutter/model/user.dart';

import 'user_logic.dart';

class UserDataSource extends AppDataSource {
  final List<User> data;

  UserDataSource(this.data);

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
        DataCell(Text('${data[index].unit}')),
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

class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);

  final logic = Get.put(UserLogic());
  final state = Get.find<UserLogic>().state;

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
                          '用户管理',
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
                      labelText: '姓名',
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppDropdownMenu(
                        hintText: '单位', list: <String>['男', '女']),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () => {},
                        child: Text(
                          '添加用户',
                          style: TextStyle(fontSize: 20),
                        )),
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
                          labels: ['ID', '姓名', '性别', '身份', '所属单位', '电话', '操作'],
                          dataSource: UserDataSource(buildTestData()))),
                )
              ],
            ),
          ],
        ),
      ),
    );
    ;
  }

  List<User> buildTestData() {
    List<User> _data = [];
    List.generate(100, (index) {
      var user = User();
      user.id = index;
      user.name = 'test$index';
      user.age = index % 50;
      user.gender = index % 2 == 0 ? '男' : '女';
      user.roleName = 'admin';
      user.height = index * 1.0;
      user.weight = index * 1.0;
      user.athlete = index % 2 == 0;
      user.unit = 'hqu';
      user.phone = '1333333333333';
      _data.add(user);
    });
    return _data;
  }
}
