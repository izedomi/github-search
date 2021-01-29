
import 'package:GitHubSearch/data/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ProfileImageUpload extends StatelessWidget {

  final String url;
  ProfileImageUpload({this.url});

  @override
  Widget build(BuildContext context) {

    return  Container(
      height: 45,
      width: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white, 
        boxShadow: authenticatedUser.imagePath != null ? [] : [
          BoxShadow(blurRadius: 8.0, offset: Offset(0,0), color: Colors.black26, spreadRadius:3)
        ],
        borderRadius: BorderRadius.circular(22.0)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.0),
        child: FadeInImage(
        placeholder: AssetImage(BACKGROUND_IMAGE),
        image: NetworkImage(url),
        fit: BoxFit.cover,
        width: 45.0,
        height: 45.0,
          ),
      ),
    );
  }
}