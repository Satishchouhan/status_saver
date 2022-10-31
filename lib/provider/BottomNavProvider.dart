import 'package:flutter/cupertino.dart';

class BottomNavProvider extends ChangeNotifier{

  int _curruntindex=0;
  int get curruntIndex=>_curruntindex;
  void changeIndex(int value){
    _curruntindex=value;
    notifyListeners();
  }

}