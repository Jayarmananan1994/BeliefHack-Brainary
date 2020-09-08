import 'package:brainery/commons/constants.dart';
import 'package:flutter/material.dart';

class AboutLeon extends StatelessWidget {
  static const String PATH = '/about-leon';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Color(0xff2b4185),
        child: SafeArea(
          child: Column(
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop()),
              SizedBox(height: 25),
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text('About ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300)),
                    Text('Leon Morton',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold))
                  ])),
              SizedBox(height: 25),
              Container(
                width: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(image: AssetImage(LEON_PROFILE_IMAGE)),
                ),
              ),
              SizedBox(height: 20),
              Container(height: 10, width: 50, color: Colors.blue),
              SizedBox(height: 20),
              Container(
                width: width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(aboutContent(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }

  String aboutContent() {
    return "Leon J Morton is the Founder of the BeliefHack Brainery, Creator of the Plasticity Programming Integrated Mind/Body stress management and performance enhancement curriculum, and Podcast Host. Leon is a seasoned Performance Psychology coach and Consultant with over 20 years working with organizations and high performing individuals ranging from an NFL Team, Super Bowl athletes, to corporate teams and one on one with people across the US. A father of two and a performing artist, Leon was inducted into the National Heritage Blues Hall of Fame in 2011.";
  }
}
