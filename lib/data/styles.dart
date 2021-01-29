 import 'package:flutter/material.dart';


TextStyle textStyleWhite({double size = 14,  bool isTitle = false, Color color = Colors.white}){
    return TextStyle(
      fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
      color: color,
      fontSize: size
    );
}

TextStyle textStyleBlack({double size = 14,  bool isTitle = false, Color color = Colors.black}){
    return TextStyle(
      fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
      color: color,
      fontSize: size
    );
}

//titles
TextStyle title1 = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: 24.0
);
TextStyle title2 = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: 18.0
);
TextStyle title3 = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: 16.0
);
TextStyle title4 = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: 14.0
);

TextStyle title5 = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: 16.0
);

TextStyle title6 = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontSize: 16.0
);








TextStyle screenSubTitle = TextStyle(
  color: Colors.white,
  fontSize: 14.0
);