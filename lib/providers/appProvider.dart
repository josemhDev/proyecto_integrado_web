import 'package:flutter/cupertino.dart';

class AppProvider extends ChangeNotifier{

  bool fileSelected = false;
  String fileSelectedType = '';
  bool gridMode = false;

  
  void changeFileSelected(){ 
    fileSelected = !fileSelected;
    gridMode = false;

    notifyListeners();
    }

    turnOnGrid(){
    gridMode = true;
    notifyListeners();
  }

  turnOffGrid(){
    gridMode = false;
    notifyListeners();
  }

  void changeFileType(String type){
    fileSelectedType = type;
    notifyListeners();
  }

}