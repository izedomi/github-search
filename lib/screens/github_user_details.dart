
import 'package:GitHubSearch/controllers/github_controller.dart';
import 'package:GitHubSearch/data/styles.dart';
import 'package:GitHubSearch/models/github_user_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class ProviderDetails extends StatefulWidget {

  final String url;
  ProviderDetails(this.url);

  @override
  _ProviderDetailsState createState() => _ProviderDetailsState();
}

class _ProviderDetailsState extends State<ProviderDetails> {

  bool isLoading = true;
  GitHubUserdetail user;
  Map<String, dynamic> res;
  GitHubController sc = GitHubController();

  @override
  void initState() {
    super.initState();
    getDetails();
  }


  void getDetails() async{


       res = await sc.getUserDetail(widget.url);
       print(res.toString());

        if(res["success"] && res["title"] == 'success'){

            setState(() {
                user = res["results"];
                isLoading = false;
            });
        }
       
        print(res.toString());
    }

  
  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: isLoading ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: deviceWidth,
                      height: deviceHeight / 4.0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80.0)),
                          child:FadeInImage(
                                placeholder: AssetImage("assets/images/luxA.jpg"),
                                image: NetworkImage(user.avatarUrl),
                                width: 85,
                                height: 110,
                                fit: BoxFit.cover,
                              ),
                      )
                    ),
                    Container(
                      width: deviceWidth,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        //borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                width: deviceWidth - 50,       
                                child: Text(
                                user.username,
                                style: textStyleBlack(isTitle: true, size: 14.0, color: Colors.white),
                                overflow: TextOverflow.visible,
                              ),
                            ), 
                            GestureDetector(
                                onTap: ()=> Navigator.pop(context),
                                child: Container(
                                width: 20,
                                height: 20,   
                                decoration: BoxDecoration(
                                  color: Colors.white38,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),                      
                                child: Icon(Icons.close, color: Colors.black, size: 14.0)
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
  
                  ],
                ),
                SizedBox(height: 24.0,),
                Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16.0),
                  padding: EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         buildDetailsCard(context, Icons.book, "Username", user.username),
                         buildDetailsCard(context, Icons.book, "Name",  user.name),
                         buildDetailsCard(context, Icons.book, "Email",  user.email),
                         buildDetailsCard(context, Icons.book, "Company",  user.company),
                         buildDetailsCard(context, Icons.book, "Location",  user.location),
                         buildDetailsCard(context, Icons.book, "Public Repos",  user.publicRepos),
                         buildDetailsCard(context, Icons.book, "Followers",  user.followers),
                         buildDetailsCard(context, Icons.book, "Following",  user.following),
                         buildDetailsCard(context, Icons.book, "Creation Date",  user.createdAt)
                      ]
                  ),
                ),
              ],
            ),

        ),
      );
  }


    Widget buildDetailsCard(BuildContext context, IconData icon, String title, String subTitle){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 10, 
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      icon == null ? Container() : Icon(icon, color: Colors.deepOrange,),
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(title, style:textStyleBlack(isTitle: true, size: 12.0, color: Colors.black54)),
                          SizedBox(height: 5.0,),
                          Text(subTitle, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.blue),),
                        ],
                      )
                    ]
                  ),
                  SizedBox(height: 20.0,),
                ],
              )
            ),
            // Expanded(flex: 4, child: buildDetailsCard(context, Icons.account_box, "Amount", "N120,000"))
          ],
        );
  }
}
