import 'dart:math';

class Game {
  final String hiddenCardPath = 'assets/images/hidden.png';
  List<String>? gameImg;

  final List<String> cards_list = [
    "assets/images/circle.png",
    "assets/images/triangle.png",
    "assets/images/circle.png",
    "assets/images/heart.png",
    "assets/images/star.png",
    "assets/images/triangle.png",
    "assets/images/star.png",
    "assets/images/heart.png",
  ];

  List<Map<int, String>> matchCheck = [];

  final int cardCount = 8;

  void initGame() {
    // Shuffle the cardsList
    cards_list.shuffle(Random());

    // Initialize the gameImg with hidden cards
    gameImg = List.generate(cardCount, (index) => hiddenCardPath);
  }
}
