import 'package:flutter/material.dart';

class GitHubUserdetail{
    
    String username;
    String url;
    String avatarUrl;
    String name;
    String email;
    String company;
    String location;
    String bio;
    String publicRepos;
    String followers;
    String following;
    String createdAt;
   

    GitHubUserdetail({
      @required this.username,
      @required this.url,
      this.avatarUrl,
      this.name,
      this.email,
      this.company,
      this.location,
      this.bio,
      this.publicRepos,
      this.followers,
      this.following,
      this.createdAt
    });

    factory GitHubUserdetail.createGitHubUserDetail(Map<String, dynamic> json){
        
        return GitHubUserdetail(
          username: json['login'].toString(),
          url: json['url'].toString(),
          avatarUrl: json['avatar_url'].toString(),
          name: json['name'] == null ? "Not available" : json['name'].toString(),
          email: json['email'] == null ? "Not available" : json['email'].toString(),
          company: json['company'] == null ? "Not available" : json['company'].toString(),
          location: json['location'] == null ? "Not available" : json['location'].toString(),
          bio: json['bio'] == null ? "Not available" : json['bio'].toString(),
          publicRepos: json['public_repos'] == null ? "Not available" : json['public_repos'].toString(),
          followers: json['followers'] == null ? "Not available" : json['followers'].toString(),
          following: json['following'] == null ? "Not available" : json['following'].toString(),
          createdAt: json['created_at'].toString(),
        );
    }
}