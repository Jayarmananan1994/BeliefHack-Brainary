import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  static const String PATH = '/privacy';
  final TextStyle _textStyle = TextStyle(color: Color(0xff2b4185));
  final TextStyle _textStyleBold =
      TextStyle(color: Color(0xff2b4185), fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Privacy')),
      body: Container(
        // height: height,
        width: width,
        color: Colors.white,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[SizedBox(height: 15), privacy()],
            ),
          ),
        ),
      ),
    );
  }

  privacy() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
                text: TextSpan(text: '', children: [
              TextSpan(text: 'BeiefHack Brainery LLC', style: _textStyleBold),
              TextSpan(
                  text: ' (“the Organization,” or “we,” “us,” “our”) respect your concerns about' +
                      'privacy and value our relationship with you. This Privacy Policy (“Policy”) applies solely to' +
                      'information collected through the web sites, web pages, interactive features, applications, and' +
                      'their respective contents at BeliefHack.com and the “BeliefHack Brainery” application, whether' +
                      'accessed via computer, mobile device or other technology (collectively, the “Services”).',
                  style: _textStyle)
            ])),
            Text(
                'This Policy describes the types of information we collect through the Services, how that' +
                    'information may be used and/or with whom it may be shared; and how you can reach us to get' +
                    'answers to questions you may have about our privacy practices on these Services. Please read' +
                    'this Policy carefully, because by using the Services you are acknowledging that you understand' +
                    'and agree to the terms of this Policy. In addition, please review our Terms of Service, which' +
                    'governs your use of the Services and any content you submit to the Services.',
                style: _textStyle),
            Text('1. WHAT IS PERSONAL INFORMATION?', style: _textStyle),
            Text(
                'As used herein, the term “Personal Information” means information that specifically identifies' +
                    'an individual (such as a name, address, telephone number, mobile number, e-mail address, or' +
                    'photograph), or information about that individual that is directly linked to personally' +
                    'identifiable information. Personal Information does not include “aggregate information”, which' +
                    'is data we collect about the use of the Services or about a group or category of services or users' +
                    'from which individual identities or other Personal Information has been removed. Personal' +
                    'Information also does not include Usage Information (as defined below) or Device Identifier (as' +
                    'defined below) that is not connected to Personal Information. This Policy in no way restricts or' +
                    'limits our collection and use of aggregate or Usage Information that is not connected to' +
                    'Personal Information.',
                style: _textStyle),
            Text('2. INFORMATION COLLECTED ON OUR SERVICES', style: _textStyle),
            Text('Information You Provide To Us', style: _textStyle),
            Text('You may choose to provide Personal Information through the Services. The Organization will'+
'collect Personal Information when you contact us through the Services or otherwise'+
'communicate or interact with us. In addition, you may submit Personal Information about other'+
'people. The Organization will use any information that we collect from you about another'+
'person to carry out your request. If you do not want your Personal Information collected,'+
'please do not submit it.', style: _textStyle),
            Text('Information Collected by Automated Means', style: _textStyle),
            Text('Whenever you visit or interact with the Services, the Organization, as well as any third-party'+
'advertisers and/or service providers, may use a variety of technologies that automatically or'+
'passively collect information about how the Services are accessed and used (“Usage'+
'Information”). Usage Information may include, in part, browser type, operating system, the'+
'page served, the time, how many users visited the Services, and the preceding page views. This'+
'statistical data provides us with information about the use of the Services, such as how many'+
'visitors visit a specific page on the Services, how long they stay on that page, and which'+
'hyperlinks, if any, they “click” on. This information helps us to keep the Services fresh and'+
'interesting to our visitors and to tailor content to a visitor’s interests. Usage Information is'+
'generally non-identifying, but if the Organization associates it with you as a specific and'+
'identifiable person, the Organization treats it as Personal Information.', style: _textStyle),

            Text('In the course of collecting Usage Information, the Organization also automatically collects your'+
'IP address or other unique identifier (“Device Identifier”) for the computer, mobile device,'+
'technology or other device (collectively, “Device”) you use to access the Services. A Device'+
'Identifier is a number that is automatically assigned to your Device when you access a web site'+
'or its servers, and our computers identify your Device by its Device Identifier. When you visit'+
'the Services, we may view your Device Identifier. We use this information to determine the'+
'general physical location of your Device and understand from what regions of the world the'+
'visitors to the Services come. We also may use this information to enhance the Services.', style: _textStyle),


            Text('The technologies used on the Services to collect Usage Information, including Device Identifiers,'+
'may include, without limitation:', style: _textStyle),



            Text('Cookies. Like many companies, we use “cookies” on the Services. Cookies are data files placed'+
'on a Device when it is used to visit the Services. The Organization may place cookies or similar'+
'files on your Device for security purposes, to tell us whether you have visited the Services'+
'before, if you are a new visitor or to otherwise facilitate site navigation, and to personalize your'+
'experience while visiting our Services. Cookies allow us to collect technical and navigational'+
'information, such as browser type, time spent on our Services and pages visited. Cookies may'+
'enhance your online experience by saving your preferences while you are visiting a particular'+
'Service. If you would prefer not to accept cookies, most browsers will allow you to: (i) change'+
'your browser settings to notify you when you receive a cookie, which lets you choose whether '+
'or not to accept it; (ii) to disable existing cookies; or (iii) to set your browser to automatically'+
'reject any cookies. However, please be aware that if you disable or reject cookies, some'+
'features and services on our Services may not work properly because we may not be able to'+
'recognize and associate you with your profile. In addition, the offers we provide when you visit'+
'us may not be as relevant to you or tailored to your interests.', style: _textStyle),
            Text('', style: _textStyle),
            Text('', style: _textStyle),
            Text('', style: _textStyle),
            Text('', style: _textStyle),
          ],
        ));
  }
}
