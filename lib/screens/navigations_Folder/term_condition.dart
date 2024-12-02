import 'package:flutter/material.dart';

class TermCondition extends StatelessWidget {
  const TermCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Terms & Conditions",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14.0),
                child: Text(
                  "INTRODUCTION : THE KAAMWALIJOBS.COM",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "1. A Company incorporated under the company act 1956. Kaamwalijobs.com services like (Maid, Cook, Babysitter, Nanny, Patient Care, Driver, and more ) selected tons and cities in India. We are providing candidates in residential commercial and more information visit website: www.kaamwalijobs.com",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "2. The registration & services charge for the candidate is one salary + gst. Clients have to pay 50% at time of registration and 50% after maid is selected within 3 days.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "3. The contract period is for 1 year and 6 months replacement : max 3 replacements if any reason the client cancel the contract there would be no refund.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "4. During the 6 months replacement time, if you wish to cancel the contract for any reason, the services charge /recruitment fees paid to us will not be refunded.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "5. The client will check the bag, purse or any other thing that the maid is carrying before the maid enter the home and before the maid leaves the hoe .This is for safety of the client.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "6. The client under takes to notify kaamwalijobs.com immediately upon agreeing to hire a candidates introduced by Kaamwalijobs.com",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "7. We are not responsible for any wrong behaviour characteristic between Candidates & Client.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "8. A receipt will send to the client open commitment of employment and placement fee payable after the balance amount.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "9. Instructions are strictly confidential. If kaamwalijobs.com introduces candidates to the client then that introduces to the third party who hires the candidate on either full time or part time, the client agrees to pay kaamwalijobs.com the placement charges . If candidate is not finally selected after trial period of the days, then the compiler has to pay the salary for such days work by the maid or other staff.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "10. Any payment made to candidate the company will not responsible for money matter. ",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "11. While every endeavour is made by Kaamwalijobs.com to introduce satisfactory candidates to the client. It is the responsibility of the client to satisfy themselves of the suitability of an applicant before hiring them. If required the client may arrange medical examination.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "12. Prior to the placement of the maid, the client has to give us the job description of the type of work the maid needs to do, the client cannot make the maid to anything outside the job description then kaamwalijobs.com will not replace the maid and neither refunds the placement charges paid by the client. The maid which has been sent for replacement cannot be change by the client.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "13. Although we do a document verification of the maid, we strongly suggest that the client themself to do a police verification of the maid. Kaamwalijobs.com may assist the client in with the details of the maid provided to us by the maid when the maid registered with us.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "14. If the invoices are settled and due to any reason the candidate resigns then a free replacement is 7 days but it may be depending or the availability.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "15. The document will be given to you after the full and final payment is done and will sent by courier.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "16. Check candidate background document & reference based on candidate communication and details provided, but we are not giving any clarification. If any medical unfit found or candidate missed behaviour found then our company is not responsible for any misdeed. If any advance payment asked by candidate for then our respect client has responsibility to inform concerned person of our company of monetary. If with any reason we are unable to fulfil your services than 50% amount will be refunded within 45 days by courier.",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  textAlign: TextAlign.justify,
                  "17. The payment has to be made in favour of Kaamwalijobs.com",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
