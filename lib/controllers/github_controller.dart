import 'dart:convert';
import 'package:GitHubSearch/models/github_user.dart';
import 'package:GitHubSearch/models/github_user_details.dart';
import 'package:http/http.dart' as http;


class GitHubController{

    Future<Map<String, dynamic>> getUsers(String query, int page) async{
       
      try{

          http.Response response;
          Map<String,dynamic> res;
          List results = List();
  
          response = await http.get("https://api.github.com/search/users?q=$query&page=$page&per_page=10");

          if(response.statusCode == 200){
              
              var content = json.decode(response.body);

              if(content.length > 0){
                 results  = content["items"].map((e) => GitHubUser.createGitHubUser(e)).toList();
              }
             
              res = {
                'success' : true,
                'title': "success",
                'results' : results,
                'totalCount': content["total_count"]
              }; 

          }
          else if(response.statusCode == 404){
              res = {
                'success' : false,
                'title': "Something went wrong",
                'message' : "404 Not found",
                'results' : results
              }; 
          }
          else{
             res = json.decode(response.body);
          }
          
          return res;

      }
      catch(error){
          print(error);
          return {
            'success' : false,
            'title': "Something went wrong",
            'message' : "We couldn't connect to the server. please refresh or try again later",
          }; 
      }
        
    }


     Future<Map<String, dynamic>> getUserDetail(String url) async{
       
      try{

          http.Response response;
          Map<String,dynamic> res;
          GitHubUserdetail user;
  
          response = await http.get(url);

          print('Response result status: ${response.statusCode}');
         
          if(response.statusCode == 200){
              
              var content = json.decode(response.body);

              user = GitHubUserdetail.createGitHubUserDetail(content);
             
              res = {
                'success' : true,
                'title': "success",
                'results' : user,
              }; 

          }
          else if(response.statusCode == 404){
              res = {
                'success' : false,
                'title': "Something went wrong",
                'message' : "404 Not found",
                'results' : user,
              }; 
          }
          else{
             res = json.decode(response.body);
          }
          
          return res;

      }
      catch(error){
          print(error);
          return {
            'success' : false,
            'title': "Something went wrong",
            'message' : "We couldn't connect to the server. please refresh or try again later",
          }; 
      }
        
    }
        
        
    
 
}