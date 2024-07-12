import 'dart:math';

class Game {
  final String hiddenCardPath = 'assets/images/hidden.png';
  List<String>? gameImg;
  List<String> cards_list = [];

  final List<String> easyCards = [
    "assets/images/circle.png",
    "assets/images/triangle.png",
    "assets/images/circle.png",
    "assets/images/triangle.png",
    "assets/images/star.png",
    "assets/images/heart.png",
    "assets/images/star.png",
    "assets/images/heart.png",
  ];

  final List<String> mediumCards = [
    "assets/images/snake.png",
    "assets/images/deer.png",
    "assets/images/lion.png",
    "assets/images/tiger.png",
    "assets/images/monkey.png",
    "assets/images/elephant.png",
    "assets/images/snake.png",
    "assets/images/deer.png",
    "assets/images/lion.png",
    "assets/images/tiger.png",
    "assets/images/monkey.png",
    "assets/images/elephant.png",
  ];

  final List<String> hardCards = [
    "assets/images/circle.png",
    "assets/images/deer.png",
    "assets/images/elephant.png",
    "assets/images/heart.png",
    "assets/images/lion.png",
    "assets/images/man.png",
    "assets/images/monkey.png",
    "assets/images/snake.png",
    "assets/images/star.png",
    "assets/images/tiger.png",
    "assets/images/triangle.png",
    "assets/images/woman.png",
    "assets/images/circle.png",
    "assets/images/deer.png",
    "assets/images/elephant.png",
    "assets/images/heart.png",
    "assets/images/lion.png",
    "assets/images/man.png",
    "assets/images/monkey.png",
    "assets/images/snake.png",
    "assets/images/star.png",
    "assets/images/tiger.png",
    "assets/images/triangle.png",
    "assets/images/woman.png",
  ];

  List<Map<int, String>> matchCheck = [];

  void initGame(String level) {
    if (level == "easy") {
      cards_list = easyCards;
    } else if (level == "medium") {
      cards_list = mediumCards;
    } else {
      cards_list = hardCards;
    }

    cards_list.shuffle(Random());
    gameImg = List.generate(cards_list.length, (index) => hiddenCardPath);
    matchCheck.clear();
  }
}
