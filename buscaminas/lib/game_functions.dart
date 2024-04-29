import 'dart:math';
import 'package:buscaminas/app_colors.dart';
import 'package:flutter/material.dart';

String selectWord(wordList) {
  int i = Random().nextInt(wordList.length);
  String correctWord = wordList[i];
  return correctWord;
}

List checkWord(String guess, String correctWord) {
  List values = [];
  List letters = [];
  List numbers = [];
  List guessLetters = guess.split('');
  List correctWordLetters = correctWord.split('');
  for (var i = 0; i < guessLetters.length; i++) {
    var currentLetter = guessLetters[i];
    if (currentLetter == correctWordLetters[i]) {
      letters.add(currentLetter);
      numbers.add(2);
    } else if (correctWordLetters.contains(currentLetter)) {
      letters.add(currentLetter);
      numbers.add(1);
    } else {
      letters.add(currentLetter);
      numbers.add(0);
    }
  }
  values.add(numbers);
  values.add(letters);
  return values;
}

Color getCorrectColor(identifier) {
  Color correctColor = AppColors.backgroundColor;
  if (identifier == 1) {
    correctColor = AppColors.midColor;
  } else if (identifier == 2) {
    correctColor = AppColors.goodColor;
  }
  return correctColor;
}
