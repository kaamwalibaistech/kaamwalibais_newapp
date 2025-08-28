import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  TextStyle get headingStyle => GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      );

  TextStyle get bodyStyle => GoogleFonts.openSans(
        fontSize: 15,
        color: Colors.black87,
        height: 1.7,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.grey.shade100,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: SelectableText.rich(
            TextSpan(
              style: bodyStyle,
              children: [
                TextSpan(
                  text:
                      'Terms and Conditions\nKaamwalijobs.com\nEffective Date: 27/02/2025\n\n',
                  style: headingStyle.copyWith(fontSize: 22),
                ),
                TextSpan(
                    text:
                        'Welcome to Kaamwalijobs.com! By accessing or using the services provided by Kaamwalijobs.com ("Company", "we", "our", "us"), including our job portal, you ("Client", "you", "your") agree to comply with and be bound by the following Terms and Conditions ("Terms"). These Terms govern your use of our website, services, and all related functionalities. If you do not agree to these Terms, please do not use our services.\n\n'),

                // Section 1
                TextSpan(text: '1. Services Provided\n', style: headingStyle),
                TextSpan(
                    text:
                        'Kaamwalijobs.com is a maid recruitment platform that connects clients (individuals or organizations) with potential candidates for maid, housekeeping, and related employment. Our process works as follows:\n'
                        '1.1. You can sign up for our platform by creating an account using your mobile number.\n'
                        '1.2. Search for candidates based on criteria such as location, age, gender, and other filters.\n'
                        '1.3. Select from a variety of subscription packages tailored to your needs, from basic to advanced.\n'
                        '1.4. Access verified contact details of candidates and reach out to them directly for your requirements.\n\n'),

                // Section 2
                TextSpan(
                    text: '2. Client Responsibilities\n', style: headingStyle),
                TextSpan(
                    text:
                        '2.1 As the Client, you are solely responsible for paying the salary directly to the Candidate in a timely manner, as agreed upon during the hiring process.\n'
                        '2.2 Kaamwalijobs.com is not liable for any disputes, disagreements, or issues arising with the Candidate regarding their salary, work conditions, or employment after placement.\n'
                        '2.3 We strongly advise that you conduct a police verification and medical tests for the Candidates independently to ensure your safety and peace of mind. Kaamwalijobs.com is not responsible for any criminal activity, misconduct, or harmful behaviour by the Candidate.\n'
                        '2.4 Kaamwalijobs.com expressly disclaims any and all liability for the actions or omissions of any Candidate. The Client is responsible for all issues arising from misconduct, theft, damage, or any other issue involving the Candidate.\n'
                        '2.5 The Client agrees to indemnify and hold harmless Kaamwalijobs.com, its officers, employees, and affiliates, from any and all claims, actions, losses, damages, liabilities, or expenses (including legal fees) arising out of or in connection with the Client\'s use of the platform and employment of Candidates.\n\n'),

                // Section 3
                TextSpan(
                    text: '3. Employment Status of Candidates\n',
                    style: headingStyle),
                TextSpan(
                    text:
                        '3.1 The Candidate(s) introduced to the Client through our platform will be considered employees of the Client, and not employees of Kaamwalijobs.com.\n'
                        '3.2 Kaamwalijobs.com shall not be held responsible or liable under the doctrine of vicarious liability for any actions, omissions, or wrongdoing of the candidate(s) employed by the Client.\n'
                        '3.3 The Client is solely responsible for the supervision, management, and control of the Candidate(s) and must ensure compliance with all relevant labour laws and employment regulations.\n\n'),

                // Section 4
                TextSpan(text: '4. Refund Policy\n', style: headingStyle),
                TextSpan(
                    text:
                        '4.1 No Refund After Subscription: Once you subscribe to any of our service packages, the payment is non-refundable. This includes cases where you fail to contact a Candidate or miss a profile after subscribing to a plan.\n'
                        '4.2 Non-Transferable: The subscription to the service is non-transferable and is exclusively for the Client who subscribed.\n'
                        '4.3 No Refund for Missed Profiles: Kaamwalijobs.com cannot be held liable for any missed profiles after subscribing to a plan. It is the Client’s responsibility to actively engage with available profiles.\n'
                        '4.4 Special Circumstances: Kaamwalijobs.com will only provide a refund if the service is found to be unavailable or discontinued on our part, and we may issue refunds at our sole discretion in exceptional cases.\n\n'),

                // Section 5
                TextSpan(
                    text: '5. Candidate Information\n', style: headingStyle),
                TextSpan(
                    text:
                        '5.1 The details of the Candidates available on our platform are submitted and uploaded by the Candidates themselves. Kaamwalijobs.com does not verify the accuracy of the information provided by the Candidates and makes no representations or warranties about the truthfulness, completeness, or reliability of the Candidate details.\n'
                        '5.2 Kaamwalijobs.com is not responsible for any inaccuracies or discrepancies in the data provided by the Candidate. Clients should independently verify the information and qualifications of the Candidates before making any employment decisions.\n'
                        '5.3 It is strongly recommended that Clients conduct thorough background checks, including police verification, work history, and medical tests before employing any Candidate found through our platform.\n\n'),

                // Section 6
                TextSpan(
                    text: '6. Limitation of Liability\n', style: headingStyle),
                TextSpan(
                    text:
                        '6.1 Kaamwalijobs.com is not liable for any financial, personal, or other losses incurred by the Client or any third party due to the actions of the Candidate(s). This includes theft, property damage, or misconduct by the Candidate(s).\n'
                        '6.2 Kaamwalijobs.com does not guarantee that the Candidates available on the platform will meet the Client\'s specific requirements, nor do we guarantee the success of any employment relationship.\n'
                        '6.3 Kaamwalijobs.com will not be held responsible for any failure or delay in the performance of services due to circumstances beyond our control, including technical failures, natural disasters, or actions of third parties.\n\n'),

                // Section 7
                TextSpan(
                    text: '7. Termination of Services\n', style: headingStyle),
                TextSpan(
                    text:
                        '7.1 The Client can terminate their subscription at any time. However, no refunds will be issued for unused portions of the subscription.\n'
                        '7.2 Kaamwalijobs.com reserves the right to suspend or terminate access to the platform for any Client who violates these Terms or engages in fraudulent activity. Any outstanding balances owed by the Client will remain due and payable.\n\n'),

                // Section 8
                TextSpan(
                    text: '8. Privacy and Data Protection\n',
                    style: headingStyle),
                TextSpan(
                    text:
                        '8.1 By using our services, you agree to our Privacy Policy, which outlines how your personal information and data will be collected, used, and protected.\n'
                        '8.2 We may share data with third parties where necessary for the fulfilment of services, but we are committed to ensuring the security and confidentiality of your personal and business information.\n\n'),

                // Section 9
                TextSpan(text: '9. Amendments to Terms\n', style: headingStyle),
                TextSpan(
                    text:
                        'Kaamwalijobs.com reserves the right to amend or modify these Terms and Conditions at any time. Any changes will be effective immediately upon posting on the platform. It is the Client’s responsibility to review these Terms periodically for updates.\n\n'),

                // Section 10
                TextSpan(
                    text: '10. Governing Law and Dispute Resolution\n',
                    style: headingStyle),
                TextSpan(
                    text:
                        '10.1 These Terms will be governed by and construed in accordance with the laws of India Jurisdiction Mumbai, without regard to its conflict of law principles.\n'
                        '10.2 Any dispute arising out of or relating to these Terms shall be resolved through binding arbitration in Mumbai, in accordance with the rules of the Arbitration and Conciliation Act, 1996.\n\n'),

                // Section 11
                TextSpan(
                    text: '11. Contact Information\n', style: headingStyle),
                TextSpan(
                    text:
                        'If you have any questions or concerns about these Terms and Conditions, please contact us at:\n\n'
                        'Kaamwalijobs.com\n'
                        'Email: support@kaamwalijobs.com\n'
                        'Phone:  +917666900800\n'),

                TextSpan(
                  text:
                      'By using Kaamwalijobs.com, you agree to these Terms and Conditions.\n',
                  style: bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
