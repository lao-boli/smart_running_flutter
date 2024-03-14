import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:race_flutter/components/AppDataTable.dart';
import 'package:race_flutter/model/role.dart';
import 'package:race_flutter/model/unit.dart';
import 'package:race_flutter/model/user.dart';
import 'package:get/get.dart';
import 'package:race_flutter/pages/user/user_from_page.dart';
import 'package:race_flutter/pages/user/user_logic.dart';
import '../feedback/feedback_page.dart';

typedef Consumer<T> = void Function(T value);

class UserDataSource extends AppDataSource {
  List<User> data;
  int? total;
  int size = 10;
  int pageNum = 1;
  Consumer<User>? onUpdate;

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
    // print('$index, $total, ${data.length}');
    var i = index % size;
    if (i >= data.length) {
      return null;
    }
    return DataRow.byIndex(
      index: i,
      cells: [
        DataCell(Text('${data[i].id}')),
        DataCell(Text('${data[i].name}')),
        DataCell(Text('${data[i].gender}')),
        DataCell(Text('${data[i].roleName}')),
        DataCell(Text('${data[i].unitName}')),
        DataCell(Text('${data[i].phone}')),
        DataCell(Row(
          children: [
            ElevatedButton(
              // onPressed: () {Get.to(FeedbackPage());},
              onPressed: () {
                onUpdate!(data[i]);
                debugPrint("${data[i]}");
                Get.to(FormPage());
              },
              child: Text('修改'),
            ),
            // buildOpenContainer(),
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

  int get rowCount {
    return total ?? data.length;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class UserState {
  UserDataSource dataSource = UserDataSource([]);
  User formUser = User();
  List<Unit> unitList = [];
  List<Role>? roleList;
  Map<String, dynamic> queryParams = {};

  UserState() {
    dataSource = UserDataSource([]);
    dataSource.onUpdate = (user) => formUser = user;
    }
}

class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "hello",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          UserFormPage(type: FormType.update,),
        ],
      ),
    );
  }
}

OpenContainer<dynamic> buildOpenContainer() {
  return OpenContainer(
    closedColor: Colors.transparent,
    closedElevation: 0.0,
    transitionType: ContainerTransitionType.fade,
    transitionDuration: const Duration(milliseconds: 150),
    openColor: Colors.transparent,
    //显示的布局
    closedBuilder: (context, action) {
      return ElevatedButton(
        onPressed: action,
        child: Text('修改'),
      );
    },
    openBuilder: (context, action) {
      return FormPage();
    },
  );
}
