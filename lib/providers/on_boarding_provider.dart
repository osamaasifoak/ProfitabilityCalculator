import 'package:flutter/cupertino.dart';

class OnBoardingProvider extends ChangeNotifier {
  int _index = 0;

  setIndexValue(int i) {
    _index = i;
    notifyListeners();
  }

  get getIndexValue => _index;
}
