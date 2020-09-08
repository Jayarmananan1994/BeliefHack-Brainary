import 'package:flutter/material.dart';

class Faq extends StatelessWidget {
  static const String PATH = '/faq';
  final TextStyle _questionStyle = TextStyle(color: Colors.blue, fontSize: 18);
  final TextStyle _answerStyle = TextStyle(color: Color(0xff2b4185));
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('FAQ'),),
      body: Container(
        // height: height,
        width: width,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // IconButton(
                //     icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                //     onPressed: () => Navigator.of(context).pop()),
                // SizedBox(height: 25),
                // Text('FAQ',
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 20,
                //         fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                questions()
              ],
            ),
          ),
        ),
      ),
    );
  }

  questions() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('What is the cost of the BeliefHack Brainery App Courses?',
                style: _questionStyle),
            SizedBox(height: 10),
            Text(
                'The app is free to download and offers an several lessons over a variety of Personal ' +
                    'transformation topics. Also included for the basic free user is the Mindfulness Towards Successful Living course which teaches and ' +
                    ' guides the user through multiple meditation and mindfulness techniques and practices.',
                style: _answerStyle),
            Text(
                'Any content not accessible for free will display with a lock symbol. To access the full Library of' +
                    'all courses and content you will need to purchase an in app subscription for either \$7.99' +
                    'US/month or an annual discounted subscription. All monthly users agree to a minimum of 6 months and will be charged \$47.94 up front with ' +
                    'the \$7.99 monthly rate resuming on month 7 renewable each month after that.',
                style: _answerStyle),
            Text(
                '*in the spirit of fair value and fair exchange, the new user will have access to all material' +
                    'immediately without restrictions thus the minimum charge. In addition a discounted annual' +
                    'rate of \$85 per year renewed each year is also available.'
                        'There will be no prorated refunds for any subscription.',
                style: _answerStyle),
            SizedBox(height: 10),
            Text('Can I cancel my subscription?', style: _questionStyle),
            SizedBox(height: 10),
            Text('Yes, you can cancel your subscription at any time:',
                style: _answerStyle),
            SizedBox(height: 10),
            Text('What are the benefits of the subscription?',
                style: _questionStyle),
            SizedBox(height: 10),
            Text(
                'With your subscription you will have full access to all lessons, courses, and all special audio and video exclusive content.',
                style: _answerStyle),
            SizedBox(height: 10),
            Text('How do I become a subscriber?', style: _questionStyle),
            SizedBox(height: 10),
            Text(
                'You can become a subscriber by tapping on any of the locked content and selecting either the monthly or yearly option.',
                style: _answerStyle),
            SizedBox(height: 10),
            Text(
                'Are there organizational or enterprise account subscriptions available?',
                style: _questionStyle),
            Text('Contact us directly to discuss your specific needs. Each organizational or enterprise account is' +
                'created independently. Contact us at BeliefHack@gmail.com Subject line: Organizational' +
                'account.', style: _answerStyle),
            SizedBox(height: 10),    
            Text('All Subscriptions renew automatically.', style: _answerStyle,)
          ],
        ));
  }
}
