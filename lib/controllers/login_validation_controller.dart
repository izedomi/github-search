


import '../models/validation.dart';
import 'package:flutter/cupertino.dart';

import 'login_controller.dart';

class LoginValidation extends ChangeNotifier{

  bool _isPasswordVisible = true;
  bool _isLoading = false;
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);
  Map<String,dynamic> response;

  //getters
  ValidationItem get email => _email;
  ValidationItem get password => _password;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isLoading => _isLoading;
 
  bool get isValid{
    if(email.value != null && password.value != null){
      return true;
    }
    else{
      return false;
    }
  }

  void changePasswordVisiblity(){
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  } 

  void changeLoadingState(){
    _isLoading = !_isLoading;
    notifyListeners();
  }
 
  void changeEmail(String value){

      if(value.length < 1){
         _email = ValidationItem(null, null);
      }else{
        if(value.contains("@")){
          _email = ValidationItem(value, null);
        }
        else{
            _email = ValidationItem(null, "Invalid Email Address");
        }
      }
     
      notifyListeners();
  }

  void changePassword(String value){

      String val = value.trim();

      if(val.length == 0){
        _password = ValidationItem(null, null);
      }
      else if((val.length > 0) && (val.length < 6)){
         _password = ValidationItem(null, "Atleast 6 characters are needed");
      }
      else if(val.length > 6){
         /*if(confirmPassword.value.trim().length > 0 && val != confirmPassword.value){
           _password = ValidationItem(null, "Passsword do not match");
         }
         else{
            _password = ValidationItem(value, null);
         }
         */
         
          _password = ValidationItem(value, null);

      }
      notifyListeners();
    
  }

  Future<Map<String,dynamic>> login() async{
    
    changeLoadingState();
    LoginController lc = LoginController();
    response = await lc.login(email: email.value, password: password.value);
    return response;

  }

  logout() async{
    LoginController lc = LoginController();
    await lc.logout();
  }


}