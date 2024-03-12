import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:race_flutter/components/AppDataTable.dart';
import 'package:race_flutter/components/AppDropdownMenu.dart';
import 'package:race_flutter/components/AppFormDropdown.dart';

import 'package:race_flutter/components/AppTextField.dart';
import 'package:race_flutter/components/AppTextFormField.dart';
import 'package:race_flutter/model/api_response.dart';
import 'package:race_flutter/model/role.dart';
import 'package:race_flutter/model/unit.dart';
import 'package:race_flutter/model/user.dart';
import 'package:race_flutter/pages/user/user_logic.dart';

enum FormType { add, update }

class UserFormPage extends StatefulWidget {
  final FormType type;

  UserFormPage({Key? key, this.type = FormType.add, }) : super(key: key);

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final logic = Get.put(UserLogic());

  final state = Get.find<UserLogic>().state;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: state.formUser.name);
    _phoneController =
        TextEditingController(text: state.formUser.phone.toString());
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
                      onSaved: (name) => {
                        state.formUser.name = name
                      },
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
                              state.formUser.unitId = unit.unitId,
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
                        model: logic.getUserRole(state.formUser),
                        onSave: (role) => {
                              state.formUser.roleId = role.roleId,
                          debugPrint("role save")
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
                child: AppTextFormField(
                  labelText: '联系电话',
                  onSaved: (phone) => {
                    state.formUser.phone = phone
                  },
                  controller: _phoneController,
                ),
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
                      if(widget.type == FormType.add){
                        Future<ApiResponse> result = logic.addUser(state.formUser);
                        result.then((value) => {
                          if(value.isSucceed()){
                            logic.refreshUser(),
                            Get.back()
                          },
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(value.msg??"")),
                          )
                        });
                      }
                      if(widget.type == FormType.update){
                        Future<ApiResponse> result = logic.updateUser(state.formUser);
                        result.then((value) => {
                          if(value.isSucceed()){
                            logic.refreshUser(),
                            Get.back()
                          },
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(content: Text(value.msg??"",)),
                          ),
                        });
                      }
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
                  onPressed: () {Get.back();},
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
