import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kaamwalijobs_new/Client/menupage_api.dart';
import 'package:kaamwalijobs_new/assets/shimmer_effect/book_maid_shimmer.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/features/auth/presentation/purchase_package_popup.dart';
import 'package:kaamwalijobs_new/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:kaamwalijobs_new/features/dashboard/bloc/dashboard_event.dart';
import 'package:kaamwalijobs_new/features/dashboard/bloc/dashboard_state.dart';
import 'package:kaamwalijobs_new/features/navigation/bloc/packages_event.dart';
import 'package:kaamwalijobs_new/features/navigation/presentation/packages.dart';
import 'package:kaamwalijobs_new/models/candidate_model.dart';
import 'package:kaamwalijobs_new/models/candidate_request.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/local_storage.dart';
import '../../navigation/bloc/packages.state.dart';
import '../../navigation/bloc/packages_bloc.dart';

class BookmaidScreen extends StatefulWidget {
  const BookmaidScreen({super.key});

  @override
  State<BookmaidScreen> createState() => _BookmaidScreenState();
}

class _BookmaidScreenState extends State<BookmaidScreen> {
  CandidateRequest candidateRequest = CandidateRequest();
  late DashboardBloc dashboardBloc;
  late PurchasedPackageDataBloc _packageBloc;

  final int _pageSize = 10;

  final PagingController<int, CandidateData?> _paginationController =
      PagingController(firstPageKey: 1);

  final ScrollController _scrollController = ScrollController();

  Future<void> _fetchPage(int pageKey) async {
    candidateRequest.page = pageKey.toString();
    dashboardBloc.add(
      GetCandidates(
        candidateRequest: candidateRequest,
        pageKey: pageKey,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _packageBloc = BlocProvider.of<PurchasedPackageDataBloc>(context);
    _packageBloc.add(PurchasedPackageEvent());

    dashboardBloc = BlocProvider.of<DashboardBloc>(context);

    _paginationController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    // 👇 ensures first load always starts clean
    _paginationController.refresh();
  }

  @override
  void dispose() {
    _paginationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  int count = 0;
  Widget _buildPackageInfoSection() {
    if (count != 0) return const SizedBox.shrink();

    return BlocBuilder<PurchasedPackageDataBloc, PackageState>(
      bloc: _packageBloc,
      buildWhen: (PackageState previous, PackageState current) =>
          current is PackageLoadedStates,
      builder: (context, state) {
        if (state is PackageLoadedStates) {
          if (state.currentPackagePlan.package?.isEmpty ?? false) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10),
              child: Row(
                children: [
                  Image.asset(
                    "lib/assets/images/kaamwalijobs.png",
                    height: 40,
                  ),
                ],
              ),
            );
          } else {
            return _buildPackageInfoCards(state);
          }
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildPackageInfoCards(PackageLoadedStates state) {
    final package = state.currentPackagePlan.package?.first;
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildInfoCard(
            "lib/assets/images/icons-package.png",
            "Current Package",
            package?.packageName ?? "",
          ),
          _buildInfoCard(
            "lib/assets/images/icons-resume.png",
            "Available Count",
            package?.avilableCount.toString() ?? "",
          ),
          _buildInfoCard(
            "lib/assets/images/icons-calendar.png",
            "Expire Date",
            package?.expDate.toString() ?? "",
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String iconPath, String title, String value) {
    return Column(
      children: [
        Image.asset(iconPath, height: 30),
        sizedBoxH10,
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.25,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String variablee = "v";
  @override
  Widget build(BuildContext context) {
    // purchasedPackageBloc =
    //     BlocProvider.of<PurchasedPackageDataBloc>(context, listen: false);
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: PreferredSize(
          preferredSize: Size(20, MediaQuery.of(context).size.height * 0.13),
          child: _buildPackageInfoSection()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<DashboardBloc, DashboardState>(
              bloc: dashboardBloc,
              listenWhen: (_, state) => state is CandidateListLoadedState,
              listener: (context, state) {
                if (state is CandidateListLoadedState) {
                  try {
                    final candidates = state.candidates;
                    final isLastPage = candidates.length < _pageSize;

                    if (isLastPage) {
                      _paginationController.appendLastPage(candidates);
                    } else {
                      final nextPageKey = state.pageKey + 1;
                      _paginationController.appendPage(candidates, nextPageKey);
                    }
                  } catch (error) {
                    _paginationController.error = error;
                  }
                }
              },
              builder: (context, state) {
                return RefreshIndicator(
                  onRefresh: () async {
                    _paginationController.refresh();
                  },
                  child: PagedListView<int, CandidateData?>(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    shrinkWrap: true,
                    pagingController: _paginationController,
                    scrollController: _scrollController,
                    builderDelegate: PagedChildBuilderDelegate<CandidateData?>(
                      noMoreItemsIndicatorBuilder: (_) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Center(child: SizedBox(height: 21)),
                      ),
                      newPageProgressIndicatorBuilder: (_) =>
                          const Center(child: BookMaidShimmer()),
                      firstPageProgressIndicatorBuilder: (_) =>
                          const Center(child: BookMaidShimmer()),
                      itemBuilder: (context, model, index) {
                        return BookMaidCard(model: model!);
                      },
                      noItemsFoundIndicatorBuilder: (_) =>
                          const SizedBox.shrink(),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class BookMaidCard extends StatefulWidget {
  const BookMaidCard({
    super.key,
    required this.model,
  });
  final CandidateData model;

  @override
  State<BookMaidCard> createState() => _BookMaidCardState();
}

class _BookMaidCardState extends State<BookMaidCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.only(bottom: 15),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 20,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF0CA930),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Center(
                            child: Text(
                              widget.model.rating ?? '',
                              style: const TextStyle(
                                color: whiteColor,
                                fontSize: 13,
                                fontFamily: 'Arial',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        RatingBarIndicator(
                          rating: double.parse(widget.model.rating!),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 15.0,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          '${widget.model.ratingCount!} Ratings',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: textGreyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: const ShapeDecoration(
                            color: blueColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              widget.model.jobType!,
                              style: GoogleFonts.poppins(
                                color: whiteColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            ListTile(
              leading: Image.network(widget.model.image!, height: 45),
              title: Text(
                widget.model.categoryName!,
                style: GoogleFonts.quicksand(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                widget.model.serviceLocation == null
                    ? ""
                    : widget.model.serviceLocation!,
                maxLines: 1,
                style: GoogleFonts.quicksand(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing:
                  Image.asset('lib/assets/images/verified_2x.gif', height: 28),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Age: ",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: textBlackColor2,
                              ),
                            ),
                            TextSpan(
                              text: widget.model.age != null
                                  ? "${widget.model.age!} Yrs"
                                  : "",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: textBlackColor2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Gender: ",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: textBlackColor2,
                                ),
                              ),
                              TextSpan(
                                text: widget.model.gender != null
                                    ? widget.model.gender!
                                    : "",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: textBlackColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Marital Status: ",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: textBlackColor2,
                                ),
                              ),
                              TextSpan(
                                text: widget.model.maritalStatus != null
                                    ? widget.model.maritalStatus!
                                    : "",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: textBlackColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Education: ",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: textBlackColor2,
                                ),
                              ),
                              TextSpan(
                                text: widget.model.maximumEducation != null
                                    ? widget.model.maximumEducation!
                                    : "",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: textBlackColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Religion: ",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: textBlackColor2,
                                ),
                              ),
                              TextSpan(
                                text: widget.model.religion != null
                                    ? widget.model.religion!
                                    : "",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: textBlackColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Working Hours: ",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: textBlackColor2,
                                ),
                              ),
                              TextSpan(
                                text: widget.model.workingHours != null
                                    ? "${widget.model.workingHours} Hours"
                                    : "",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: textBlackColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Total Experience: ",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: textBlackColor2,
                                ),
                              ),
                              TextSpan(
                                text: widget.model.totalExp != null
                                    ? "${widget.model.totalExp!} Years"
                                    : "",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: textBlackColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Language: ",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: textBlackColor2,
                                ),
                              ),
                              TextSpan(
                                text: widget.model.language != null
                                    ? widget.model.language!.join(",")
                                    : "",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: textBlackColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Expected Salary: ",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: textBlackColor2,
                                ),
                              ),
                              TextSpan(
                                text: widget.model.expectedSalary != null
                                    ? "Rs. ${widget.model.expectedSalary!}"
                                    : "",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: textBlackColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<PurchasedPackageDataBloc, PackageState>(
                buildWhen: (PackageState previous, PackageState current) =>
                    current is PackageLoadedStates ||
                    current is PackageLoadingState ||
                    current is PackageFailedState,
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0DA931),
                          minimumSize: const Size(0, 35),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: () async {
                        EasyLoading.show();

                        if (state is PackageLoadedStates) {
                          if (state.currentPackagePlan.package?.isNotEmpty ??
                              false) {
                            String packageType = state
                                .currentPackagePlan.package!.first.packageType
                                .toString();
                            if (packageType == "V") {
                              LocalStoragePref localStoragePref =
                                  LocalStoragePref();
                              String userId =
                                  localStoragePref.getUserProfile()?.userId ??
                                      "";
                              // if (userId.isEmpty) {
                              //   Fluttertoast.showToast(msg: "Please Login!");
                              // } else {
                              final sortType = "";

                              if (widget.model.isVisible == false) {
                                try {
                                  await MenuPageRepository()
                                      .getSortListedCandidate(
                                          sortType,
                                          widget.model.candidateId,
                                          localStoragePref
                                              .getUserProfile()!
                                              .flag,
                                          userId);

                                  BlocProvider.of<PurchasedPackageDataBloc>(
                                          context)
                                      .add(PurchasedPackageEvent());

                                  setState(() {
                                    widget.model.isVisible = true;
                                    EasyLoading.dismiss();
                                  });
                                } catch (e) {
                                  EasyLoading.dismiss();
                                  Fluttertoast.showToast(
                                      msg: "You have exceeded the counts!");
                                }
                              } else {
                                EasyLoading.dismiss();
                                final phoneUri = Uri(
                                    scheme: 'tel',
                                    path:
                                        "+91 ${widget.model.mobileNo.toString()}");
                                launchUrl(phoneUri);
                              }
                            } else {
                              EasyLoading.dismiss();
                              return showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('No Candidate View Plan'),
                                  content: Text(
                                      "You don't have a Candidate View Plan. Please purchase one to continue."),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Future.delayed(
                                            Duration(milliseconds: 1), () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Packages()),
                                          );
                                        });
                                      },
                                      child: Text('Purchase'),
                                    ),
                                  ],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              );
                            }
                          } else {
                            EasyLoading.dismiss();
                            checkPackagesPopup();
                          }
                        } else {
                          EasyLoading.dismiss();
                          checkPackagesPopup();
                        }
                      },
                      child: Row(
                        children: [
                          const SizedBox(width: 30),
                          Image.asset("lib/assets/images/call.png", height: 17),
                          const SizedBox(width: 20),
                          SizedBox(
                            child: widget.model.isVisible ?? false
                                ? Text(
                                    widget.model.mobileNo.toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: whiteColor),
                                  )
                                : Text(
                                    widget.model.mobileNo!
                                        .replaceRange(3, 7, "****"),
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: whiteColor),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  checkPackagesPopup() async {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
            scrollable: true, content: PackagesPurchasePopup()));
  }
}
