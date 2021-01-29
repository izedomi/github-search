import 'package:GitHubSearch/data/constants.dart';
import 'package:GitHubSearch/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

    final introKey = GlobalKey<IntroductionScreenState>();

    void _onIntroEnd(context) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }

    Widget _buildImage(String assetName) {

      return ClipRRect(
          borderRadius: BorderRadius.circular(120.0),
          child: Container(
          height: 60,
          width: 60,
          padding: EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(120),
            color: Colors.white
          ),
          child: Image(
            image: AssetImage(assetName),
            width: 60,
            height: 60,
            fit: BoxFit.contain,
          ),
        ),
      );
      
    }

    @override
    void initState() {
      super.initState();
        SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
      );

    }
 
  @override
  Widget build(BuildContext context) {

    const bodyStyle = TextStyle(fontSize: 20.0, color: Colors.grey);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700, color: Color(0xffffffff)),
      bodyTextStyle: bodyStyle,
      pageColor: Color(0xff094063),
      imagePadding: EdgeInsets.all(60),
    );

    return Scaffold(
        body: Center(
          child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: IntroductionScreen(
            key: introKey,
            pages: [
              PageViewModel(
                title: "GitHub Search",
                body:
                    "SBSC....delivery differently",
                image: _buildImage(BACKGROUND_IMAGE),
                decoration: pageDecoration,
              ),
            ],
            onDone: () => _onIntroEnd(context),
            done: const Text('Continue', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xffffffff))),
            dotsDecorator: const DotsDecorator(
              activeSize: Size(0.0, 0.0),
            ),
          ),
      ),
        ),
    );
    
  }
}