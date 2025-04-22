import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Who We Are",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Image.asset("lib/assets/images/whoweare.png"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                  textAlign: TextAlign.justify,
                  "Welcome to KaamWaliBais.com, where we specialize in providing high-quality, trustworthy, and compassionate services tailored to meet the needs of individuals and families. Whether you're looking for a maid service, eldercare assistance, cooking services, or a babysitter, we are dedicated to ensuring your home runs smoothly and your loved ones are cared for with the utmost attention and respect."),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0, left: 15, right: 15),
              child: Text(
                  textAlign: TextAlign.justify,
                  "At KaamWaliBais.com, we understand that inviting someone into your home is a big decision. That’s why we take extra steps to ensure that all of our service providers are not only skilled and experienced, but also thoroughly vetted for trustworthiness and reliability. Our goal is to provide you with peace of mind, knowing that you can count on our team for exceptional service, confidentiality, and care."),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0, left: 15, right: 15),
              child: Text(
                  textAlign: TextAlign.justify,
                  "At KaamWaliBais, our mission is simple: to provide high-quality services that help make your life easier and more enjoyable. We believe that excellent service starts with understanding the unique needs of each client, and we are committed to building lasting relationships based on trust, reliability, and respect. Whether it’s assisting with household chores, supporting elderly loved ones, preparing home-cooked meals, or caring for children, our focus is always on delivering exceptional service with the highest level of professionalism."),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0, left: 15, right: 15),
              child: Text(
                  textAlign: TextAlign.justify,
                  "We would love the opportunity to serve you and your family. If you have any questions or would like to schedule a consultation, please don't hesitate to contact us. Our team is here to help make your life easier, one service at a time."),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(top: 10, left: 15, right: 15),
            //   child: Text(
            //     textAlign: TextAlign.justify,
            //     "Contact Information:",
            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            //   ),
            // ),
            // const Padding(
            //   padding: EdgeInsets.only(top: 1.0, left: 15, right: 15),
            //   child: Text(
            //     textAlign: TextAlign.justify,
            //     "Email:support@kaamwalijobs.com",
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            // ),
            // const Padding(
            //   padding: EdgeInsets.only(top: 3.0, left: 15, right: 15),
            //   child: Text(
            //     textAlign: TextAlign.justify,
            //     "Contact NO.:7666900800",
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
