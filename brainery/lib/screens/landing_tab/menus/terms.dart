import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  static const String PATH = '/terms';
  final TextStyle _textStyle = TextStyle(color: Color(0xff2b4185));
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Terms')),
      body: Container(
        // height: height,
        width: width,
        color: Colors.white,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 15),
                terms()
              ],
            ),
          ),
        ),
      ),
    );
  }

  terms() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              'This Terms of Service Agreement (“Agreement”) is an agreement between you (“you” or “user”) and BeliefHack Brainery LLC (“the Organization,” “we,” or “us”). This Agreement' +
                  'governs your access and use of the web pages, interactive features, applications, widgets and' +
                  'their respective contents at BeliefHack.com and “BeliefHack Brainery” application (collectively,' +
                  'the “Services”) (the “Services”). By using the Services, you agree to be bound by the terms and' +
                  'conditions contained in this Agreement. If you do not agree to the terms and conditions' +
                  'contained in this Agreement, you may not access or otherwise use the Services.',
              style: _textStyle),
          Text(
              'We may, in our sole discretion, modify this Agreement with or without notice to you. The “Last' +
                  'Updated” date at the top of this Agreement will indicate when the latest modifications were' +
                  'made. By continuing to access and use the Services after this Agreement has been modified,' +
                  'you are agreeing to such modifications. Therefore, you should review this Agreement prior to' +
                  'each use of the Services. In addition, when using particular services or features, you shall be' +
                  'subject to any posted guidelines or policies applicable to such services, features or purchases' +
                  'that may be posted from time to time. All such guidelines or policies are hereby incorporated' +
                  'by reference into this Agreement.',
              style: _textStyle),
          Text(
              'If you are under the age of eighteen (18), you represent that you are either an emancipated' +
                  'minor, or have obtained the legal consent of your parent or legal guardian to enter into this' +
                  'Agreement, submit content, participate through the Services and fulfill the obligations set forth' +
                  'in this Agreement.',
              style: _textStyle),
          Text(
              'PLEASE READ THE AGREEMENT CAREFULLY BEFORE USING THE SERVICE. THIS AGREEMENT' +
                  'INCLUDES AN AGREEMENT TO MANDATORY ARBITRATION, WHICH MEANS THAT YOU AGREE' +
                  'TO SUBMIT ANY DISPUTE RELATED TO THE SERVICE TO BINDING INDIVIDUAL ARBITRATION' +
                  'RATHER THAN PROCEEDING IN COURT. THE DISPUTE RESOLUTION/ARBITRATION PROVISION' +
                  'ALSO INCLUDES A CLASS ACTION WAIVER, WHICH MEANS THAT YOU AGREE TO PROCEED WITH' +
                  'ANY DISPUTE INDIVIDUALLY AND NOT AS PART OF A CLASS ACTION. THIS AGREEMENT ALSO'
                      'INCLUDES A JURY WAIVER.',
              style: _textStyle),
          Text('II. CONNECTIVITY, COMMUNICATIONS, PRIVACY', style: _textStyle),
          Text(
              'Normal carrier charges and taxes may apply to any content you obtain from the Services' +
                  'through your cell phone or mobile device. The Organization is not responsible for any' +
                  'surcharges you incur from your cell phone or internet service provider as a result of the use of' +
                  'the Services.',
              style: _textStyle),
          Text(
              'You expressly agree that, as part of the Services, you may receive communications by email.' +
                  'You may stop receiving emails by clicking the unsubscribe links contained in such emails or by' +
                  'emailing your request to opt out to BeliefHack@gmail.com.',
              style: _textStyle),
          Text(
              'Use of the Services is subject to the terms of our Privacy Policy, which is hereby incorporated' +
                  'into and made part of this Agreement. Please carefully review our Privacy Policy. By using the' +
                  'Services, you acknowledge that you have read, and you agree to be bound by, the terms of our' +
                  'Privacy Policy. We reserve the right, and you authorize us, to use information regarding your' +
                  'use of the Services and any other personal information provided by you in accordance with our' +
                  'Privacy Policy. You further acknowledge and agree that any disputes related to the Privacy',
              style: _textStyle),
          Text('III. COPYRIGHT; TRADEMARKS', style: _textStyle),
          Text(
              'You acknowledge that all materials on the Services, including the Services’ design, graphics,' +
                  'text, sounds, pictures, videos, software and other files and the selection and arrangement' +
                  'thereof (collectively, “Materials”), are the property of the Organization or its licensors, and are' +
                  'subject to and protected by United States and international copyright and other intellectual' +
                  'property laws and rights. You will not obtain any ownership interest in the Materials or the' +
                  'Services through this Agreement or otherwise. All rights to Materials not expressly granted in' +
                  'this Agreement are reserved to their respective copyright owners. Except as expressly' +
                  'authorized by this Agreement or on the Services, you may not copy, reproduce, distribute,' +
                  'republish, download, perform, display, post, transmit, exploit, create derivative works or' +
                  'otherwise use any of the Materials in any form or by any means, without the prior written' +
                  'authorization of the Organization or the respective copyright owner. The Organization' +
                  'authorizes you to view and download the Materials only for personal, non-commercial use,' +
                  'provided that you keep intact all copyright and other proprietary notices contained in the' +
                  'original Materials. You may not modify or adapt the Materials in any way or otherwise use' +
                  'them for any public or commercial purposes. The trademarks, service marks, trade names,' +
                  'trade dress and logos (collectively, “Marks”) contained or described on the Services (including,' +
                  'without limitation, any marks associated with any products available on the Service) are the' +
                  'sole property of the Organization and/or its licensors and may not be copied, imitated or' +
                  'otherwise used, in whole or in part, without the prior written authorization of the Organization' +
                  'and/or licensors. In addition, all page headers, custom graphics, button icons and scripts are' +
                  'Marks of the Organization and may not be copied, imitated or otherwise used, in whole or in' +
                  'part, without the prior written authorization of the Organization. The Organization will enforce' +
                  'its intellectual property rights to the fullest extent of the law.',
              style: _textStyle),
          Text('IV. LINKS; THIRD PARTY WEBSITES', style: _textStyle),
          Text(
              'Links on the Services to third party websites may be provided as a convenience to you. If you' +
                  'use these links, you will leave the Services. Your dealings with third parties through links to such' +
                  'third party websites are solely between you and such third parties. You agree that the' +
                  'Organization and its Affiliated Parties will not be responsible or liable for any content, goods or' +
                  'services provided on or through these outside websites or for your use or inability to use such' +
                  'websites. You use these links at your own risk. You are advised that other websites on the' +
                  'Internet, including third party websites linked from the Services, might contain material or' +
                  'information that some people may find offensive or inappropriate; or that is inaccurate, untrue,' +
                  'misleading or deceptive; or that is defamatory, libelous, infringing of others’ rights or otherwise' +
                  'unlawful. The Organization expressly disclaims any responsibility for the content, legality,' +
                  'decency or accuracy of any information, and for any products and services, that appear on any' +
                  'third party website or application.'
              ,style: _textStyle),
          Text('Without limiting the foregoing, your correspondence or business dealings with, participation in' +
'promotions of or purchases from third-parties found on or through the use of the Services,' +
'including payment for and delivery of related goods or services, and any other terms,' +
'conditions, warranties or representations associated with such dealings, are solely between you' +
'and such third party. You agree that the Organization and its Affiliated Parties shall not be ' +
'responsible or liable for any loss or damage of any sort incurred as the result of any such' +
'dealings or as the result of the presence of such third parties on the Services.', style: _textStyle),
          Text('', style: _textStyle),
          Text('', style: _textStyle),
          Text('', style: _textStyle),
          Text('', style: _textStyle),
        ],
      ),
    );
  }
}
