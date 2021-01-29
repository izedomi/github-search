
import 'package:GitHubSearch/controllers/login_controller.dart';
import 'package:GitHubSearch/data/constants.dart';
import 'package:GitHubSearch/data/styles.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {

   
  
  Widget accountItemCard(BuildContext context, IconData leadingIcon, Color color, String title, {isFirstItem = false}){

      double deviceWidth = MediaQuery.of(context).size.width;
      double deviceHeight = MediaQuery.of(context).size.height;

      return GestureDetector(
          onTap: (){
            if(title == "Logout"){
              LoginController lc = new LoginController();
              lc.logout();
              Navigator.pushNamed(context, '/login');
              print("logged out");
            }
          },
          child: Container(
          margin: isFirstItem ? 
          EdgeInsets.only(top: deviceHeight / 5.7, left: 24.0, right: 24.0, bottom: 8.0) : 
          EdgeInsets.only(top: 4, bottom: 4.0),
          padding: EdgeInsets.only(top: 12.0, left: 16.0, right: 16.0, bottom: 12.0),
          width: deviceWidth - 50,
          //height: 360,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0,2),
                blurRadius: 6.0
              )
            ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(   
                mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                crossAxisAlignment: CrossAxisAlignment.center,            
                children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(leadingIcon,size: 24.0, color: color,),
                        SizedBox(width: 5.0),
                        Text(title, style: textStyleBlack(isTitle:true, color: Colors.grey),)
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.grey,)
                ]
              ),
              
            ],
          ),
      ),
    );
      
  }
  
  @override
  Widget build(BuildContext context) {

      return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  //color: Colors.blue,
                  width: double.infinity,
                  decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(BACKGROUND_IMAGE),
                      repeat: ImageRepeat.repeat,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop)
                    ),
                    color: Theme.of(context).primaryColor,
                    //color: Color(0xfff4f4f4),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0))
                  ),
                  height: MediaQuery.of(context).size.height / 5,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Hi, Emmanuel", overflow: TextOverflow.ellipsis, style: textStyleWhite(isTitle: true, size: 16.0),),
                          SizedBox(height: 3.0),
                          Text("emmanuel.izedomi1@gmail.com", overflow: TextOverflow.ellipsis, style: textStyleBlack(isTitle: false, size: 13.0, color: Colors.white)),
                        ],
                      ),
                    ]
                  )
                ),
                accountItemCard(context, Icons.exit_to_app, Theme.of(context).accentColor, "Logout", isFirstItem: true),
              ],
            ),              
            
          ],
        ),
    );
  }
}