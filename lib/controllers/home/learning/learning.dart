import 'package:flutter/material.dart';

abstract class BaseLearningController {
  void wrongAnswerMC(BuildContext context, String choice, int i);
  void rightAnswerMC(BuildContext context, int i);
  List get answerRightMC;
}