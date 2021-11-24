import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CountProvider extends ChangeNotifier {
  var _count = 0;
  int get count => _count;

  add() {
    _count++;
    notifyListeners();
  }

  remove() {
    _count--;
    notifyListeners();
  }
}