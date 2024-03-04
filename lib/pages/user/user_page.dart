import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:race_flutter/components/AppAutoComplete.dart';
import 'package:race_flutter/components/AppDataTable.dart';
import 'package:race_flutter/components/AppDropdownMenu.dart';
import 'package:race_flutter/components/AppTextField.dart';
import 'package:race_flutter/model/user.dart';

import 'user_logic.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);

  final logic = Get.put(UserLogic());
  final state = Get.find<UserLogic>().state;

  @override
  Widget build(BuildContext context) {
    logic.pageUser(1, 10);
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
                        onPageChanged: (value) => {logic.pageUser((value/10 + 1) as int, 10)} ,
                        onRowsPerPageChanged: (i) => print('onPageChanged -> $i'),
                          labels: ['ID', '姓名', '性别', '身份', '所属单位', '电话', '操作'],
                          // dataSource: UserDataSource(buildTestData()))),
                          dataSource: state.dataSource)),
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
      user.unitName = 'hqu';
      user.phone = '1333333333333';
      _data.add(user);
    });
    return _data;
  }
}
