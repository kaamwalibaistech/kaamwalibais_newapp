import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          Center(
            child: Image.asset(
              "lib/assets/images/kaamwalijobs.png",
              height: 80,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: whiteColor,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 200, 197, 197),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ]),
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Reset Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.75,
                  decoration: BoxDecoration(
                      border: Border.all(color: blackColor),
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: const TextField(
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    // controller: _controller,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                      hintText: "Mobile No.",
                      hintStyle: TextStyle(color: textGreyColor),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.circular(10)),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width * 0.78,
                  child: const Center(
                      child: Text(
                    "Send OTP",
                    style: TextStyle(color: whiteColor, fontSize: 16),
                  )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
