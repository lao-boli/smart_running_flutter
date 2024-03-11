import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:race_flutter/components/AppDataTable.dart';
import 'package:race_flutter/components/AppDropdownMenu.dart';
import 'package:race_flutter/components/AppFormDropdown.dart';

import 'package:race_flutter/components/AppTextField.dart';
import 'package:race_flutter/components/AppTextFormField.dart';
import 'package:race_flutter/model/role.dart';
import 'package:race_flutter/model/unit.dart';
import 'package:race_flutter/model/user.dart';
import 'package:race_flutter/pages/user/user_logic.dart';

class UserFormPage extends StatefulWidget {
  UserFormPage({Key? key}) : super(key: key);

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final logic = Get.put(UserLogic());

  final state = Get.find<UserLogic>().state;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _genderController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: state.formUser.name);
    _genderController =
        TextEditingController(text: state.formUser.gender.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppTextFormField(
                      labelText: '姓名',
                      controller: _nameController,
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppFormDropdown<String>(
                        model: state.formUser.gender,
                        onSave: (gender) => {
                              state.formUser.gender = gender,
                            },
                        list: ['男', '女'],
                        hintText: '性别'),
                  ))
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppFormDropdown<Unit>(
                      model: logic.getUserUnit(state.formUser),
                        onSave: (unit) => {
                              state.formUser.unitId = unit.unit_id,
                            },
                        label: (unit) => unit.name ?? '',
                        list: state.unitList ?? [],
                        hintText: '单位'),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppFormDropdown<Role>(
                        onSave: (role) => {
                              state.formUser.roleId = role.roleId,
                            },
                        label: (role) => role.name,
                        list: state.roleList ?? [],
                        hintText: '权限'),
                  ))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppTextFormField(labelText: '联系电话'),
              ))
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('提交'),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('取消'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<Unit> buildUnit() {
  var a = Unit();
  a.name = 'hqu';
  a.unitId = 'hquid';
  var b = Unit();
  b.name = 'hqu2';
  b.unitId = 'hquid2';
  return [a, b];
}
