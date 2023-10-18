import 'package:english_words/english_words.dart';
import 'package:get/get.dart';

class GenerateState {
  var current = WordPair.random().obs;
  var favorites = <WordPair>[];
  var favor = false.obs;

  GenerateState() {}
}
