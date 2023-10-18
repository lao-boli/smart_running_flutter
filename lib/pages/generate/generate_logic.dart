import 'package:english_words/english_words.dart';
import 'package:get/get.dart';

import 'generate_state.dart';

class GenerateLogic extends GetxController {
  final GenerateState state = GenerateState();

  void toggleFavorite() {
    var favorites = state.favorites;
    var current = state.current;
    var favor = state.favor;
    if (favorites.contains(current.value)) {
      favorites.remove(current.value);
      favor.value = false;
    } else {
      favorites.add(current.value);
      favor.value = true;
    }
  }

  void getNext() {
    var current = state.current;
    var favor = state.favor;
    favor.value = false;
    current.value = WordPair.random();
  }
}
