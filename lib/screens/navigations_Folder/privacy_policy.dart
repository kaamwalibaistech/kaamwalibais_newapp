import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: scaffoldColor,
        title: const Text(
          "Privacy & Policy",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: scaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10),
              child: Row(
                children: [
                  Text(
                    "1.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Confidentiality Agreement:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                textAlign: TextAlign.justify,
                "Service providers (maids, caregivers, cooks, and babysitters) must agree not to disclose any personal, financial, or private information about the clients or their households.",
                style: TextStyle(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10),
              child: Row(
                children: [
                  Text(
                    "2.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Data Protection:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                textAlign: TextAlign.justify,
                "Any personal data collected (names, contact details, payment information) will be stored securely and will only be used for the purposes of providing the service.",
                style: TextStyle(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15, top: 10),
              child: Text(
                textAlign: TextAlign.justify,
                "Adhere to relevant data protection laws (e.g., GDPR, CCPA) depending on the region.",
                style: TextStyle(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10),
              child: Row(
                children: [
                  Text(
                    "3.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Background Checks:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15,
              ),
              child: Text(
                textAlign: TextAlign.justify,
                "All service providers undergo thorough background checks, including criminal records and references, to ensure safety and trustworthiness.",
                style: TextStyle(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10),
              child: Row(
                children: [
                  Text(
                    "4.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Service Scope:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15,
              ),
              child: Text(
                textAlign: TextAlign.justify,
                "Clearly define what services will and will not be provided (e.g., cleaning, cooking, eldercare assistance, child care and Many More).",
                style: TextStyle(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15, top: 10),
              child: Text(
                textAlign: TextAlign.justify,
                "Explain that service providers are not responsible for tasks outside the scope of their agreement.",
                style: TextStyle(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10),
              child: Row(
                children: [
                  Text(
                    "5.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Client Privacy:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15,
              ),
              child: Text(
                textAlign: TextAlign.justify,
                "The privacy of clients and their household information must be respected at all times.",
                style: TextStyle(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15, top: 10),
              child: Text(
                textAlign: TextAlign.justify,
                "Service providers should avoid sharing any details about the client’s home, family, or personal life with others.",
                style: TextStyle(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10),
              child: Row(
                children: [
                  Text(
                    "6.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Safety Protocols:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15,
              ),
              child: Text(
                textAlign: TextAlign.justify,
                "Outline any safety protocols for the service (e.g., emergency procedures, COVID-19 safety measures, etc.)",
                style: TextStyle(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15, top: 10),
              child: Text(
                textAlign: TextAlign.justify,
                "Emergency contact information for clients should be kept confidential and shared only with relevant parties in case of emergencies.",
                style: TextStyle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: blueColor),
                child: const Center(
                    child: Text(
                  "Know More ...",
                  style: TextStyle(color: whiteColor),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
