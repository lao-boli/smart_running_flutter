import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:race_flutter/components/AppAutoComplete.dart';
import 'package:race_flutter/components/AppDataTable.dart';
import 'package:race_flutter/components/AppDropdownMenu.dart';
import 'package:race_flutter/components/AppFormDropdown.dart';
import 'package:race_flutter/components/AppTextField.dart';
import 'package:race_flutter/model/unit.dart';
import 'package:race_flutter/model/user.dart';
import 'package:race_flutter/pages/feedback/feedback_page.dart';
import 'package:race_flutter/pages/user/user_from_page.dart';
import 'package:race_flutter/pages/user/user_state.dart';

import 'user_logic.dart';

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
                    child: AppTextField(
                      onChanged: (value) => {
                        if (value.isEmpty)
                          {
                            state.queryParams.remove('name'),
                          }
                        else
                          {
                            state.queryParams.addAll({'name': value}),
                          }
                      },
                      labelText: '姓名',
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GetBuilder<UserLogic>(builder: (logic) {
                        return state.unitList.isEmpty
                            ? const CircularProgressIndicator()
                            : AppDropdownMenu<Unit>(
                                onSelected: (unit) => {
                                      state.queryParams
                                          .addAll({'unitId': unit?.unitId}),
                                      debugPrint("${state.queryParams}")
                                    },
                                onClear: (unit) => {
                                      state.queryParams.remove('unitId'),
                                      debugPrint("${state.queryParams}")
                                    },
                                label: (unit) => unit.name ?? '',
                                list: () {
                                  return state.unitList;
                                },
                                hintText: '单位');
                      }),
                    )),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () => {
                              logic.pageUser(1, 10,
                                  queryParams: state.queryParams)
                            },
                        child: Text(
                          '查询用户',
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () =>
                            {state.formUser = User(), Get.to(FormPage())},
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
                          onPageChanged: (value) => {
                                logic.pageUser((value / 10 + 1) as int, 10,
                                    queryParams: state.queryParams)
                              },
                          onRowsPerPageChanged: (i) =>
                              print('onPageChanged -> $i'),
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
}
