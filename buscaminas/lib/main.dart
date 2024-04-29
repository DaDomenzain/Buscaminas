import 'package:buscaminas/app_colors.dart';
import 'package:buscaminas/check_word.dart';
import 'package:buscaminas/game_functions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Game());
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<GameScreen> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  String correctWord = selectWord(GameList.wordList);
  String guess = '';
  int guesses = 0;
  List values = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text('Wordle',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white))),
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 12,
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 30,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 5,
              ),
              itemBuilder: (context, index) {
                if (0 + (guesses * 5) - 5 <= index &&
                    index < 5 + (guesses * 5) - 5) {
                  return Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: AppColors.bordersColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: getCorrectColor(
                              values[0][index - ((guesses - 1) * 5)])),
                      child: Center(
                          child: Text(
                        values[1][index - ((guesses - 1) * 5)],
                        style: TextStyle(
                          color: AppColors.letterColor,
                          fontSize: 30,
                        ),
                      )));
                } else {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: AppColors.bordersColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.backgroundColor),
                  );
                }
              },
            ),
          ),
          Expanded(
              flex: 3,
              child: SizedBox(
                  width: 200,
                  child: TextField(
                      controller: myController,
                      textAlign: TextAlign.center,
                      maxLength: 5,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.bordersColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.letterColor)),
                          counterStyle:
                              TextStyle(color: AppColors.letterColor)),
                      style: TextStyle(color: AppColors.letterColor)))),
          Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                  width: 200,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.bordersColor,
                    onPressed: () {
                      setState(() {
                        guesses += 1;
                        guess = myController.text;
                        values = checkWord(guess, correctWord);
                      });
                    },
                    child: Text(
                      'ENVIAR',
                      style: TextStyle(
                        color: AppColors.letterColor,
                        fontSize: 20,
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}
