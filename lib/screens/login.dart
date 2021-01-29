import 'dart:io';

import 'package:GitHubSearch/controllers/login_validation_controller.dart';
import 'package:GitHubSearch/data/constants.dart';
import 'package:GitHubSearch/data/styles.dart';
import 'package:GitHubSearch/screens/home.dart';
import 'package:GitHubSearch/shared/helpers/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  userLogin(LoginValidation lv, BuildContext context) async {
    await lv.login();

    if (lv.response != null) {
     
      print("signup response: " + lv.response.toString());
      if (lv.response["success"]) {
        if (lv.response["title"] == "success") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
         
        } else {
          print(lv.response["message"]);
          displayDialog(
            context: context,
            heading: lv.response["title"],
            body: lv.response["message"],
            type: "info",
          );
        }
        //lv.changeLoadingState();
      } else {
        //print("error occured while connecting");
        displayDialog(
          context: context,
          heading: lv.response["title"],
          body: lv.response["message"],
          type: "error",
        );
      }

      lv.changeLoadingState();
    }
  }

  invalidInput(BuildContext context) async {
    displayDialog(
        context: context,
        heading: "Invalid input",
        body: "Please complete the necesary fields",
        type: "error");
  }

 
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    LoginValidation lv = Provider.of<LoginValidation>(context);
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                height: deviceHeight,
                width: deviceWidth,
                padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 24),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(BACKGROUND_IMAGE),
                        repeat: ImageRepeat.noRepeat,
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.1), BlendMode.dstATop))),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              height: 48,
                            ),
                            Text("Welcome back,",
                                style: textStyleBlack(isTitle: true, size: 28)),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: 40,
                              height: 6,
                            ),
                            SizedBox(height: 24),
                            Container(
                                width: 275.0,
                                child: Text(
                                    "Login to continue",
                                    style: textStyleBlack(
                                        size: 16.0,
                                        color: Colors.grey,
                                        isTitle: true))),
                            SizedBox(height: 45.0),
                            Container(
                              //height: 40.0,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Email must contain @",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                  errorText: lv.email.error,
                                  //icon: Icon(Icons.person),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 10),
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    size: 20.0,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Theme.of(context).accentColor)),
                                  //disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                                  //focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
                                  border: OutlineInputBorder(
                                      //borderRadius: const BorderRadius.all(
                                      //const Radius.circular(25.0),
                                      ),
                                  //),
                                ),
                                onChanged: (value) => lv.changeEmail(value),
                              ),
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            Container(
                              //height: 40.0,
                              child: TextField(
                                obscureText: lv.isPasswordVisible,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  errorText: lv.password.error,
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 10),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    size: 20.0,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  suffixIcon: IconButton(
                                      onPressed: () =>
                                          lv.changePasswordVisiblity(),
                                      icon: Icon(
                                        !lv.isPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      iconSize: 20.0),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Theme.of(context).accentColor)),
                                  border: OutlineInputBorder(
                                      //borderSide: BorderSide(color: Colors.red, width: 3, style: BorderStyle.solid)
                                      ),
                                ),
                                onChanged: (value) => lv.changePassword(value),
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                           
                            SizedBox(
                              height: 30.0,
                            ),
                            GestureDetector(
                              //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())),
                              onTap: !lv.isLoading
                                  ? lv.isValid
                                      ? () {
                                          userLogin(lv, context);
                                        }
                                      : () {
                                          invalidInput(context);
                                        }
                                  : null,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 1000),
                                    curve: Curves.easeInOutQuad,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    //width: lv.isLoading ? 40 : 10,
                                    height: 50.0,
                                    child: lv.isLoading
                                        ? Row(
                                            children: <Widget>[
                                              CircularProgressIndicator(
                                                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                                                //radius: 15,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                "Authenticating...",
                                                style: textStyleWhite(
                                                    isTitle: true),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            children: <Widget>[
                                              Text("Login",
                                                  style: textStyleBlack(
                                                      isTitle: true,
                                                      size: 18.0,
                                                      color: Colors.white)),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Platform.isIOS
                                                  ? Icon(
                                                      Icons.arrow_forward_ios,
                                                      color: Colors.white,
                                                    )
                                                  : Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.white,
                                                    ),
                                              //Icon(Icons.arrow_forward, color: Colors.white,)
                                            ],
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
              
            ],
          ),
        ));
  }
}
