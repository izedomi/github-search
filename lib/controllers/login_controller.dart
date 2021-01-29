import 'dart:convert';



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/constants.dart';
import '../models/user.dart';


class LoginController{


    logout() async{
        
          http.Response response;
      
          var url = BASE_URL+"logout";
          print(url);
          response = await http.post(url, 
              body: {
                'user_id': authenticatedUser.id.toString(),
              }
          );
    }


    Future<Map<String, dynamic>> login({@required email, @required password}) async{
       

      try{

          http.Response response;
          Map<String,dynamic> res;

          var url = BASE_URL+"login";
          print(url);
          response = await http.post(url, 
              body: {
                'email': email,
                'password': password
              }
          );

          if(response.statusCode == 200){
             res = json.decode(response.body);

             print("ressss: " + res.toString());

             authenticatedUser = User.createUser(res["data"]["user"]);

             //set user details
          }
          else if(response.statusCode == 404){
              res = {
                'success' : false,
                'title': "Something went wrong",
                'message' : "404 error occured. The url resource couldn't be found",
                'data': []
              }; 
          }
          else{
             res = json.decode(response.body);
          }
          
          return res;

      }
      catch(error){
          return {
            'success' : false,
            'title': "Something went wrong",
            'message' : "We couldn't connect to the server. please refresh or try again later",
            'data': []
          }; 
      }
        
    }
}