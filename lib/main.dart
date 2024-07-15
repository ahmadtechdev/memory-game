import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_game/utils/game_logic.dart';
import 'package:memory_game/widgets/score_board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Game _game = Game();
  int tries = 0;
  int score = 0;
  bool gameCompleted = false;
  late DateTime startTime;
  late Duration elapsedTime;
  String selectedLevel = "";

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
  }

  void startGame(String level) {
    setState(() {
      selectedLevel = level;
      _game.initGame(level);
      tries = 0;
      score = 0;
      gameCompleted = false;
      startTime = DateTime.now();
    });
  }

  void checkGameCompletion() {
    if (!_game.gameImg!.contains(_game.hiddenCardPath)) {
      setState(() {
        gameCompleted = true;
        elapsedTime = DateTime.now().difference(startTime);
      });
    }
  }

  void resetGame() {
    setState(() {
      selectedLevel = "";
      _game = Game();
      tries = 0;
      score = 0;
      gameCompleted = false;
      startTime = DateTime.now();
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    if (duration.inMinutes == 0) {
      return "$seconds seconds";
    } else if (duration.inHours == 0) {
      return "$minutes minutes, $seconds seconds";
    } else {
      return "$hours hours, $minutes minutes, $seconds seconds";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    int crossAxisCount;

    switch (selectedLevel) {
      case "easy":
        crossAxisCount = 3;
        break;
      case "medium":
        crossAxisCount = 4;
        break;
      case "hard":
        crossAxisCount = 5;
        break;
      default:
        crossAxisCount = 3;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF508D4E),
      body: selectedLevel.isEmpty
          ? Center(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            const Text(
            "Memory Game",
            style: TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF3FF90),
            ),
          ),
              const SizedBox(height: 24.0),
              const Text(
                "Select Level",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD6EFD8),
                ),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  levelButton("Easy", Color(0xFF50B498), "easy"),
                  const SizedBox(width: 16.0),
                  levelButton("Medium", Color(0xFFF4CE14), "medium"),
                  const SizedBox(width: 16.0),
                  levelButton("Hard", Color(0xFFFF0000), "hard"),
                ],
              ),
              const SizedBox(height: 24.0),
              const Text(
                "Develop by: Ahmad Raza!",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF3FF90),
                ),
              ),
            ],
          ),
        ),
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Memory Game",
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF3FF90),
              ),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              scoreBoard("Tries", "$tries"),
              scoreBoard("Score", "$score"),
            ],
          ),
          const SizedBox(height: 16.0),
          if (!gameCompleted)
            SizedBox(
              height: screen_width,
              width: screen_width,
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: _game.gameImg!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (!_game.matchCheck.any(
                              (element) => element.containsKey(index))) {
                        setState(() {

                          _game.gameImg![index] =
                          _game.cards_list[index];
                          _game.matchCheck
                              .add({index: _game.cards_list[index]});
                        });
                        if (_game.matchCheck.length == 2) {
                          tries++;
                          if (_game.matchCheck[0].values.first ==
                              _game.matchCheck[1].values.first) {
                            score += 10;
                            _game.matchCheck.clear();
                            checkGameCompletion();
                          } else {
                            score -= 2;
                            Future.delayed(
                                const Duration(milliseconds: 500), () {
                              setState(() {
                                _game.gameImg![
                                _game.matchCheck[0].keys.first] =
                                    _game.hiddenCardPath;
                                _game.gameImg![
                                _game.matchCheck[1].keys.first] =
                                    _game.hiddenCardPath;
                                _game.matchCheck.clear();
                              });
                            });
                          }
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A5319),
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(_game.gameImg![index]),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 24.0),
                  Text(
                    "Congratulations! You completed the game in ${formatDuration(elapsedTime)}.",
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD6EFD8),
                    ),
                  ),
                  const SizedBox(height: 24.0),

                  const SizedBox(height: 24.0),
                  Text(
                    "This game is created by Ahmad Raza!",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF3FF90),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: resetGame,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: const Color(0xFFEEEEEE),
              padding: const EdgeInsets.symmetric(
                  horizontal: 32.0, vertical: 16.0),
              textStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            child: const Text("Quit"),
          ),
        ],
      ),
    );
  }

  Widget levelButton(String text, Color color, String level) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => startGame(level),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: const Color(0xFFD6EFD8),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          textStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        child: Text(text),
      ),
    );
  }
}
