import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:race_flutter/components/AppFormDropdown.dart';
import 'package:race_flutter/components/AppTextFormField.dart';

import 'feedback_logic.dart';

class FeedbackPage extends StatelessWidget {
  FeedbackPage({Key? key}) : super(key: key);

  final logic = Get.put(FeedbackLogic());
  final state = Get.find<FeedbackLogic>().state;

  final _formKey = GlobalKey<FormState>();

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
                child: AppTextFormField(labelText: '姓名'),
              )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppFormDropdown<String>(list:['男','女'],hintText: '性别'),
                  ))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppTextFormField(labelText: '年龄'),
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
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppTextFormField(labelText: '联系单位'),
                  ))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppTextFormField(labelText: '反馈意见/报错提交:',maxLines: 10,),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('提交'),
                ),
              ),
              Spacer(flex: 1,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                  },
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
