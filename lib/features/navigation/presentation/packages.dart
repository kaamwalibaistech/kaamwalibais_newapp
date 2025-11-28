import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaamwalijobs_new/assets/shimmer_effect/packages_shimmer.dart';
import 'package:kaamwalijobs_new/assets/widgets/packages_image.dart';
import 'package:kaamwalijobs_new/bloc/packages_bloc.dart';
import 'package:kaamwalijobs_new/bloc/packages_events.dart';
import 'package:kaamwalijobs_new/bloc/packages_state.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../Client/homepage_api.dart';
import '../../../core/local_storage.dart';
import '../../../models/transcation_model.dart';
import '../../auth/presentation/login_popup.dart';
import '../bloc/packages_bloc.dart';
import '../bloc/packages_event.dart';

class Packages extends StatefulWidget {
  const Packages({super.key});

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  late PackagesBloc _packageBloc;
  late Razorpay _razorpay;
  late PurchasedPackageDataBloc _purchasedPackageData;
  // bool? candidatePlan;

  @override
  void initState() {
    super.initState();
    _purchasedPackageData =
        BlocProvider.of<PurchasedPackageDataBloc>(context, listen: false);

    _razorpay = Razorpay();

    _packageBloc = BlocProvider.of<PackagesBloc>(context);
    fetch();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  checkLoginPopup() async {
    showDialog(
        context: context,
        builder: (context) => const Dialog(
            backgroundColor: Colors.transparent, child: LoginPopup()));
  }

  String? packageId;
  String? price;

  void openCheckOut(String price, String packagename) async {
    final data = LocalStoragePref().getUserProfile();

    var options = {
      'key': 'rzp_live_RjrYDqvGXclgMf',
      'amount': int.parse(price) * 100,
      'name': 'KaamWaliJobs',
      'description': packagename,
      'prefill': {
        'contact': data?.mobileNo ?? "",
        'email': data?.emailId ?? ""
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('error $e');
    }
  }

  fetch() {
    _packageBloc.add(GetPackagesEvent());
  }

  @override
  void dispose() {
    super.dispose();

    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    LocalStoragePref localStoragePref = LocalStoragePref();
    String userId = localStoragePref.getUserProfile()!.userId;

    Repositiory repositiory = Repositiory();
    RazorpaytranscationModel transactionData = await repositiory
        .getTransactionstatus(userId, response.paymentId, price, packageId);

    _purchasedPackageData.add(PurchasedPackageEvent());

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("🎉 Payment Successful"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 60),
              const SizedBox(height: 12),
              Text("Payment ID: ${response.paymentId}"),
              const SizedBox(height: 8),
              const Text("Thank you for your purchase!",
                  style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.popUntil(context, (route) => route.isFirst);
                // or push to a success screen if you want
              },
            ),
          ],
        );
      },
    );

    // Navigator.pop(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showPaymentCancelledDialog(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("object");
  }

  void showPaymentCancelledDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // prevent closing by tapping outside
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Cancel Icon
                Icon(Icons.cancel_outlined, size: 80, color: Colors.redAccent),
                const SizedBox(height: 15),

                // Title
                const Text(
                  "Payment Cancelled",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  "Transaction not completed",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                const Text(
                  "You cancelled the payment. Please try again if you wish to continue with the purchase.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 20),

                // Retry Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Try Again"),
                ),

                const SizedBox(height: 15),

                // Footer "Secured by Razorpay"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Secured by ",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    Image.network(
                      "https://razorpay.com/favicon.png",
                      height: 18,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: BlocBuilder<PackagesBloc, PackagesState>(
          buildWhen: (previous, current) {
        if (current is PackagesLoadedState) {
          return true;
        }
        return false;
      }, builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(Icons.arrow_back),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                    child: RichText(
                        text: TextSpan(children: [
                  TextSpan(
                    text: "Choose a ",
                    style: GoogleFonts.poltawskiNowy(
                        fontSize: 18, color: blueColor),
                  ),
                  TextSpan(
                    text: "Candidate Plan",
                    style: GoogleFonts.poltawskiNowy(
                        fontSize: 18,
                        color: blueColor,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: " That's right for you",
                    style: GoogleFonts.poltawskiNowy(
                        fontSize: 18, color: blueColor),
                  )
                ]))),
              ),
              if (state is PackagesLoadedState)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                      itemCount:
                          state.candidatePackagesModel.candidatePackage.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: ShapeDecoration(
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              color: whiteColor,
                            ),
                            child: Stack(children: [
                              Image.asset(
                                image[index],
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        state
                                            .candidatePackagesModel
                                            .candidatePackage[index]
                                            .packageName,
                                        style: GoogleFonts.poltawskiNowy(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      "for ${state.candidatePackagesModel.candidatePackage[index].validFor} days",
                                      style: GoogleFonts.poltawskiNowy(
                                          fontSize: 18, color: blueColor),
                                    ),
                                    Text(
                                        "Total Candidate${state.candidatePackagesModel.candidatePackage[index].totalCount}"),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: state
                                                        .candidatePackagesModel
                                                        .candidatePackage[index]
                                                        .description
                                                        .length >
                                                    5
                                                ? 5
                                                : state
                                                    .candidatePackagesModel
                                                    .candidatePackage[index]
                                                    .description
                                                    .length,
                                            itemBuilder: (context, index1) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Center(
                                                  child: Text(
                                                      state
                                                          .candidatePackagesModel
                                                          .candidatePackage[
                                                              index]
                                                          .description[index1],
                                                      style:
                                                          GoogleFonts.quicksand(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  color: blackColor),
                                              children: [
                                            TextSpan(
                                                text:
                                                    "RS. ${state.candidatePackagesModel.candidatePackage[index].price}",
                                                style:
                                                    GoogleFonts.poltawskiNowy(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20)),
                                            const TextSpan(
                                                text: "/",
                                                style: TextStyle(fontSize: 22)),
                                            TextSpan(
                                                text:
                                                    "${state.candidatePackagesModel.candidatePackage[index].validFor} days",
                                                style: const TextStyle(
                                                    color: blackColor))
                                          ])),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // setState(() {
                                          //   candidatePlan = true;
                                          // });
                                          final userLogIn = LocalStoragePref()
                                              .getUserProfile();

                                          if (userLogIn == null) {
                                            checkLoginPopup();
                                          } else {
                                            packageId = state
                                                .candidatePackagesModel
                                                .candidatePackage[index]
                                                .packageId;
                                            price = state.candidatePackagesModel
                                                .candidatePackage[index].price;
                                            openCheckOut(
                                                state
                                                    .candidatePackagesModel
                                                    .candidatePackage[index]
                                                    .price,
                                                state
                                                    .candidatePackagesModel
                                                    .candidatePackage[index]
                                                    .packageName);
                                            _razorpay.on(
                                                Razorpay.EVENT_PAYMENT_SUCCESS,
                                                _handlePaymentSuccess);
                                            _razorpay.on(
                                                Razorpay.EVENT_PAYMENT_ERROR,
                                                _handlePaymentError);
                                            _razorpay.on(
                                                Razorpay.EVENT_EXTERNAL_WALLET,
                                                _handleExternalWallet);
                                          }
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: blackColor),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.30,
                                            child: Center(
                                              child: Text(
                                                "Buy Now",
                                                style: GoogleFonts.roboto(
                                                    color: whiteColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]),
                          ),
                        );
                      }),
                )
              else
                const PackageLoader(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                    child: RichText(
                        text: TextSpan(children: [
                  TextSpan(
                    text: "Choose a ",
                    style: GoogleFonts.poltawskiNowy(
                        fontSize: 18, color: blueColor),
                  ),
                  TextSpan(
                    text: "Job Posting Plan",
                    style: GoogleFonts.poltawskiNowy(
                        fontSize: 18,
                        color: blueColor,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: " That's right for you",
                    style: GoogleFonts.poltawskiNowy(
                        fontSize: 18, color: blueColor),
                  )
                ]))),
              ),
              if (state is PackagesLoadedState)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                      itemCount: state.candidatePackagesModel.jobPackage.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: ShapeDecoration(
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              color: whiteColor,
                            ),
                            child: Stack(children: [
                              Image.asset(
                                image[index],
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        state.candidatePackagesModel
                                            .jobPackage[index].packageName,
                                        style: GoogleFonts.poltawskiNowy(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      "for ${state.candidatePackagesModel.jobPackage[index].validFor} days",
                                      style: GoogleFonts.poltawskiNowy(
                                          fontSize: 18, color: blueColor),
                                    ),
                                    Text(
                                        "Total Job Posting ${state.candidatePackagesModel.jobPackage[index].totalCount}"),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.04,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: state
                                                        .candidatePackagesModel
                                                        .jobPackage[index]
                                                        .description
                                                        .length >
                                                    5
                                                ? 5
                                                : state
                                                    .candidatePackagesModel
                                                    .jobPackage[index]
                                                    .description
                                                    .length,
                                            itemBuilder: (context, index1) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Center(
                                                  child: Text(
                                                      state
                                                          .candidatePackagesModel
                                                          .jobPackage[index]
                                                          .description[index1],
                                                      style:
                                                          GoogleFonts.quicksand(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: RichText(
                                          text: TextSpan(
                                              style: const TextStyle(
                                                  color: blackColor),
                                              children: [
                                            TextSpan(
                                                text:
                                                    "RS. ${state.candidatePackagesModel.jobPackage[index].price}",
                                                style:
                                                    GoogleFonts.poltawskiNowy(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20)),
                                            const TextSpan(
                                                text: "/",
                                                style: TextStyle(fontSize: 22)),
                                            TextSpan(
                                                text:
                                                    "${state.candidatePackagesModel.jobPackage[index].validFor} days",
                                                style: const TextStyle(
                                                    color: blackColor))
                                          ])),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // setState(() {
                                          //   candidatePlan = false;
                                          // });
                                          final userLogIn = LocalStoragePref()
                                              .getUserProfile();

                                          if (userLogIn == null) {
                                            checkLoginPopup();
                                            Fluttertoast.showToast(
                                                msg: "Please LogIn ");
                                          } else {
                                            packageId = state
                                                .candidatePackagesModel
                                                .jobPackage[index]
                                                .packageId;
                                            price = state.candidatePackagesModel
                                                .jobPackage[index].price;
                                            openCheckOut(
                                                state.candidatePackagesModel
                                                    .jobPackage[index].price,
                                                state
                                                    .candidatePackagesModel
                                                    .jobPackage[index]
                                                    .packageName);
                                            _razorpay.on(
                                                Razorpay.EVENT_PAYMENT_SUCCESS,
                                                _handlePaymentSuccess);
                                            _razorpay.on(
                                                Razorpay.EVENT_PAYMENT_ERROR,
                                                _handlePaymentError);
                                            _razorpay.on(
                                                Razorpay.EVENT_EXTERNAL_WALLET,
                                                _handleExternalWallet);
                                          }

                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(SnackBar(
                                          //         duration:
                                          //             Duration(seconds: 1),
                                          //         backgroundColor: blueColor,
                                          //         content: Text(
                                          //             "you will able to purchase this app soon")));
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: blackColor),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.30,
                                            child: Center(
                                              child: Text(
                                                "Buy Now",
                                                style: GoogleFonts.roboto(
                                                    color: whiteColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]),
                          ),
                        );
                      }),
                )
              else
                const PackageLoader(),
            ],
          ),
        );
      }),
    );
  }
}

class packageData {
  List<String> package = [];
  static final _instance = packageData._internal();

  static packageData get instance => _instance;

  packageData._internal();
}
