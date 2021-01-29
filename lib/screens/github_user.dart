
import 'package:GitHubSearch/controllers/github_controller.dart';
import 'package:GitHubSearch/data/constants.dart';
import 'package:GitHubSearch/data/styles.dart';
import 'package:GitHubSearch/models/github_user.dart';
import 'package:GitHubSearch/screens/github_user_details.dart';
import 'package:GitHubSearch/shared/helpers/custom_dialog.dart';
import 'package:GitHubSearch/shared/widgets/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class GithubSearchScreen extends StatefulWidget {
  @override
  _GithubSearchScreenState createState() => _GithubSearchScreenState();
}

class _GithubSearchScreenState extends State<GithubSearchScreen> {


    bool isLoading = false;
    bool isAddingMoreContent = false;
    String username;
    String totalCount;
    double _opacity = 0;
    int pageCount = 1;
    List searchResults = List();
    Map<String,dynamic> res;

    GitHubController ghc = GitHubController();
    ScrollController _scrollController = ScrollController();
 
  
    @override
    void initState() {
      super.initState();
      _scrollController.addListener(() {
          if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
             
             //return is we are already loading content
             if(isAddingMoreContent) return;
             setState(() => isAddingMoreContent = true);
             loadMoreUsers();
          }
      });
    }

    @override
    void dispose() {
      super.dispose();
      _scrollController.dispose();

    }

    void getGitHubUsers() async{

        //for every new user search, clear existing list and show loading indicator
        setState(() {
            searchResults.clear();
            isLoading = true;  
        });

       res = await ghc.getUsers(username.trim(), pageCount);
       
        if(res["success"] && res["title"] == 'success'){

            setState(() {
                totalCount = res["totalCount"].toString();
                searchResults = res["results"];
                isLoading = false;
                _opacity = 1;
            });
        }
        else{
           setState(() => isLoading = false);
           displayDialog(
            context: context,
            heading: res["title"],
            body: res["message"],
            type: "error",
          );
        }
       
        print("dsdssd: " + searchResults.toString());
    }

    void loadMoreUsers() async{

          pageCount = pageCount + 1; 
         res = await ghc.getUsers(username.trim(), pageCount);
         if(res["success"] && res["title"] == 'success'){

            //Future.delayed(Duration(seconds: 3), () => setState(() => isAddingMoreContent = false));

            List newList =  List();
            newList = res["results"];
          
            for(var i = 0; i < newList.length; i++){
                 searchResults.add(newList[i]);  
            }

            setState(() {
              isAddingMoreContent = false;
            });
        }
        else{
          displayDialog(
            context: context,
            heading: res["title"],
            body: res["message"],
            type: "error",
          );
           setState(() => isLoading = false);
        }
    }

    githubSearch(){

          if(username == null || username.trim().length == 0){

              displayDialog(
                context: context,
                heading: "Action Required!",
                body: "Enter a username",
                type: "error",
              );
              return;
          }

          getGitHubUsers();  
    }


    launchURL(String path) async {

        if (await canLaunch(path)) {
          await launch(path);
        } else {
          throw 'Could not launch $path';
        }
    
    }
  
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
      return SingleChildScrollView(
        child: Column(
        children: <Widget>[        
          Container(
            width: deviceWidth,
            height: deviceHeight / 8.0,
            //alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(BACKGROUND_IMAGE),
                repeat: ImageRepeat.repeat,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop)
              ),
              color: Theme.of(context).primaryColor,
              //color: Color(0xfff4f4f4),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(50.0))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.search, size: 36.0, color: Colors.white,),
                //FaIcon(FontAwesomeIcons.transgender),
                SizedBox(width: 20.0),
                Text("GitHub Search", style: textStyleWhite(isTitle: true, size: 18))
              ],
            ),
          ),
        SizedBox(height: 10.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                  flex: 8,
                  child: TextField(
                  decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      labelText: "Enter username",
                      contentPadding: EdgeInsets.all(10)
                  ),
                  onChanged: (value) => setState(() => username = value),
                ),
              ),
              Expanded(
                flex: 2,
                  child: IconButton(
                    icon: Icon(Icons.search),
                    color: Theme.of(context).primaryColor,
                    onPressed: (){githubSearch();}
                  ),
              )
            ],
          ),
        ),
        searchResults.length > 0 ? Align(
            alignment: Alignment.centerLeft,
            child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 6),
            child: Text(
              "showing ${searchResults.length.toString()} / $totalCount",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ):SizedBox(),
        SizedBox(height: 10.0),
        Container(
          height: deviceHeight - 235,
          //height: 200,
          // padding: EdgeInsets.only(bottom: 50),
          child: pageContent(),
        ),
             

          ],
        ),
      );
  }


  Widget pageContent(){
    
      if(searchResults.length == 0 && !isLoading){
        return SizedBox();
      }
      else if(searchResults.length == 0 && isLoading){
        return Center(
          child: CircularProgressIndicator()
        );
      }
      else{
          return buildListView();
      }
  }


  Widget buildListView(){
        return  AnimatedOpacity(
          duration: Duration(milliseconds: 1000),
          opacity: _opacity,
          child: ListView.builder(              
          itemCount: searchResults.length + 1,
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index){

            if(index < searchResults.length){

              GitHubUser gitHubUser = searchResults[index];
              return Container(
              // constraints: ,
                margin: EdgeInsets.only(left: 15, top: 4.0, right: 15.0, bottom: 8.0),
                padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 3.0, bottom: 3.0),
                alignment: Alignment.center,   
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                      BoxShadow(color: Colors.black12, offset: Offset(0,0), blurRadius: 3.0)
                  ],
                  //borderRadius: BorderRadius.circular(10.0)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ProfileImageUpload(url: gitHubUser.avatarUrl),
                          SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(gitHubUser.username, 
                              style: textStyleBlack(isTitle: true, size: 12.0, color: Colors.grey),
                              overflow: TextOverflow.ellipsis
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => ProviderDetails(gitHubUser.url)),
                                        ),

                                    child: Icon(Icons.bookmark, size: 24.0, color: Theme.of(context).accentColor)
                                  ),
                                  SizedBox(width: 30.0),
                                  GestureDetector(
                                    onTap: (){
                                      launchURL(gitHubUser.htmlUrl);
                                    },
                                    child: FaIcon(FontAwesomeIcons.github, size: 20, color: Theme.of(context).primaryColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),  
                    ],
                  ),
                )
              );
           }
          else{
            return  isAddingMoreContent ? Container(
              height: 45,
              width: 45,
              child: Center(child: CircularProgressIndicator())
            ): SizedBox();
          }
          
          }
              ),
        );
  }

}