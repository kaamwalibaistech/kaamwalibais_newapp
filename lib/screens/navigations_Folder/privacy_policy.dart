import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        title: const Text(
          "Privacy & Policy",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                textAlign: TextAlign.justify,
                "The Kaamwalijobs.com provides Services like (Maid, Cook, Nanny, Babysitter, Driver, Patient Care and more) at selected towns and cities in India. We are providing candidates in Residential & Commercial and more information, visit website: www.kaamwalijobs.com.",
                style: TextStyle(fontSize: 13),
              ),
            ),
            ListTile(
              title: Text(
                textAlign: TextAlign.justify,
                "Kaamwalijobs.com offers various services to help its users find, coordinate, and maintain fast services. Kaamwalijobs.com’s Privacy Policy (Privacy Policy) is designed to provide a clear understanding of the information we collect and how we use it to provide our services and give users a better experience. It applies to any users of www.kaamwalijobs.com and any Html websites, web pages, mobile applications and websites operated by Kaamwalijobs.com (the Site), including those who are seeking to find a service provider through Kaamwalijobs.com (Employers) as well as those who are looking to promote their services through Kaamwalijobs.com (Jobseekers/Maid or any other individual), and any users of any of the various services that Kaamwalijobs.com provides through the Site or any other channels, including over the telephone (Services). For purposes of this Agreement, the terms  Kaamwalijobs.com, we, us, and our refer to Kaamwalijobs.com, Inc. You refers to you, as a visitor or user or the Site or the Services. Please note that our subsidiaries have separate privacy policies. In addition, this Privacy Policy does not apply to third party entities that may use the Kaamwalijobs.com Site or Services. Such entities use of the Kaamwalijobs.com Site and Services are subject to separate terms that they agreed when they registered with Kaamwalijobs.com.",
                style: TextStyle(fontSize: 13),
              ),
            ),
            ListTile(
              title: Text(
                textAlign: TextAlign.justify,
                "The Kaamwalijobs.com provides Services like (Maid, Cook, Nanny, Babysitter, Driver, Patient Care and more) at selected towns and cities in India. We are providing candidates in Residential & Commercial and more information, visit website: www.kaamwalijobs.com.",
                style: TextStyle(fontSize: 13),
              ),
            )
          ],
        ),
      ),
    );
  }
}
