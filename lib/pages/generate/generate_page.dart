import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:race_flutter/components/big_card.dart';

import 'generate_logic.dart';

class GeneratePage extends StatelessWidget {
  GeneratePage({Key? key}) : super(key: key);

  final logic = Get.put(GenerateLogic());
  final state = Get.find<GenerateLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => BigCard(pair: state.current.value),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => ElevatedButton.icon(
                  onPressed: () {
                    logic.toggleFavorite();
                  },
                  icon: Icon(state.favor.value
                      ? Icons.favorite
                      : Icons.favorite_border),
                  label: const Text('like'),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  logic.getNext();
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
