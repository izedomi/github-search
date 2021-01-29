import 'package:flutter/material.dart';

class GitHubUser {
    
    String username;
    String url;
    String htmlUrl;
    String avatarUrl;
   

    GitHubUser({
      @required this.username,
      @required this.url,
      this.htmlUrl,
      this.avatarUrl,
    });

    factory GitHubUser.createGitHubUser(Map<String, dynamic> json){

    
        return GitHubUser(
          username: json['login'] == null ? "NA" : json['login'].toString(),
          url: json['url'] == null ? "NA" : json['url'].toString(),
          htmlUrl: json['html_url'] == null ? "NA" : json['html_url'].toString(),
          avatarUrl: json['avatar_url'] == null ? "NA" : json['avatar_url'].toString(),
          
        );
    }
}