import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';

class EmolpyerRegisterOtpscreen extends StatelessWidget {
  const EmolpyerRegisterOtpscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Verification code",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Text(
              "We have send the Verification code to",
              style: TextStyle(fontSize: 13, color: textGreyColor),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Row(
                children: [
                  const Text("816****043"),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Change Phone number?",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: blueColor,
                            color: blueColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: 64.0,
                      width: 56.0,
                      child: Card(
                          color: Color.fromRGBO(40, 75, 146, 0.698),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            // child: TextEditorForPhoneVerify(this.codeOne)
                          ))),
                  SizedBox(
                      height: 64.0,
                      width: 56.0,
                      child: Card(
                          color: Color.fromRGBO(40, 75, 146, 0.698),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            // child: TextEditorForPhoneVerify(this.codeOne)
                          ))),
                  SizedBox(
                      height: 64.0,
                      width: 56.0,
                      child: Card(
                          color: Color.fromRGBO(40, 75, 146, 0.698),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            // child: TextEditorForPhoneVerify(this.codeOne)
                          ))),
                  SizedBox(
                      height: 64.0,
                      width: 56.0,
                      child: Card(
                          color: Color.fromRGBO(40, 75, 146, 0.698),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            // child: TextEditorForPhoneVerify(this.codeOne)
                          ))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.50,
                  decoration: BoxDecoration(
                      color: blueColor, borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                      child: Text(
                    "Confirm",
                    style: TextStyle(color: whiteColor),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
