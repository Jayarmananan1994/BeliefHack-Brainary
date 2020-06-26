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
              IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () => Navigator.of(context).pop()),
              SizedBox(height: 25),
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text('About ',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300)),
                    Text('Leon Morton',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
                  ])),
              SizedBox(height: 25),
              ClipRRect( borderRadius: BorderRadius.circular(20), child: Container(color: Colors.white, height: height*0.4, width: width*0.7)),
              SizedBox(height: 20),
              Container(height: 10, width: 50,color: Colors.blue),
              SizedBox(height: 20),
              Container(
                width: 250,
                child: Text(aboutContent(), textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }

  String aboutContent(){
    return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In cursus turpis massa tincidunt. Ut sem viverra aliquet eget sit amet tellus. Eu ultrices vitae auctor eu.";
  }

}
