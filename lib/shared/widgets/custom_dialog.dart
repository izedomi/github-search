import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {


  final String heading;
  final String body;
  final String dialogType;
  final String navigateTo;

  CustomDialog({this.heading, this.body, this.dialogType, this.navigateTo});

  @override
  Widget build(BuildContext context) {

    String imagePath;
    Color dialogColor;
    if(dialogType == 'success'){imagePath = "assets/images/thumps_up.png"; dialogColor = Theme.of(context).primaryColor;}
    else if(dialogType == 'error'){imagePath = "assets/images/d1.png"; dialogColor = Colors.redAccent;}
    else if(dialogType == 'info'){imagePath = "assets/images/d2.png"; dialogColor = Colors.cyanAccent;}

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context, imagePath, dialogColor),
    );
  }

  _buildChild(BuildContext context, String imagePath, Color dialogColor) => Container(
    height: 300,
    decoration: BoxDecoration(
      color: dialogColor,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(12))
    ),
    child: Column(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(imagePath, height: 80, width: 80,),
          ),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
          ),
        ),
        SizedBox(height: 24,),
        Text(heading, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
        SizedBox(height: 8,),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Text(body, style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
        ),
        SizedBox(height: 24,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(onPressed: (){
             
              if(navigateTo != null){
                 Navigator.pushReplacementNamed(context, navigateTo);
              }
              else{
                  return Navigator.of(context).pop(true);
              }
            }, child: Text("OK"), color: Colors.white, textColor: Colors.redAccent,)
          ],
        )
      ],
    ),
  );
}
