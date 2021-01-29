import 'package:flutter/cupertino.dart';

class SortingTabSetting extends ChangeNotifier{
  

  String _currentProviderTab = "ALL";

  String get getCurrentProviderTab  => _currentProviderTab;


  

  void setCurrentProviderTab(String value){
    _currentProviderTab = value;
    notifyListeners();
  }

}