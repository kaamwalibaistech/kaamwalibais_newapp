import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Center(
                child: Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Text(
                "Who Are We",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )),
            SizedBox(
              height: 10,
            ),
            Text(
                textAlign: TextAlign.center,
                "At Kaamwalijobs, we bring a strong experience of over 12 years of offering maids service across Mumbai, India. We being best maids service agency in Mumbai, offer 24 hours maids service across Mumbai like maid services, domestic help, housemaids, cooks, caretakers, ayahs, peons, nurses, ward boys, babysitters, elderly care etc.")
          ],
        ),
      ),
    );
  }
}
