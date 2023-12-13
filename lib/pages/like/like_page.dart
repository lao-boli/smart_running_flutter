import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:race_flutter/model/user.dart';
import 'package:race_flutter/pages/generate/generate_logic.dart';

import 'like_logic.dart';

class LikePage extends StatelessWidget {
  LikePage({Key? key}) : super(key: key);

  final logic = Get.put(LikeLogic());
  final state = Get.find<LikeLogic>().state;
  final generateState = Get.find<GenerateLogic>().state;

  @override
  Widget build(BuildContext context) {
    if (generateState.favorites.isEmpty) {
      return const Center(
        child: Text('No favorites yet.'),
      );
    }
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Text('You have '
            '${generateState.favorites.length} favorites:'),
      ),
      for (var pair in generateState.favorites)
        ListTile(
          leading: const Icon(Icons.favorite),
          title: Text(pair.asLowerCase),
        ),
    ]);
  }
}
