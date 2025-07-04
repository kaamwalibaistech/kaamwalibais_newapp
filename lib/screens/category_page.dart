import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kaamwalijobs_new/assets/shimmer_effect/book_maid_shimmer.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:kaamwalijobs_new/features/dashboard/bloc/dashboard_event.dart';
import 'package:kaamwalijobs_new/features/dashboard/bloc/dashboard_state.dart';
import 'package:kaamwalijobs_new/models/candidate_model.dart';
import 'package:kaamwalijobs_new/models/candidate_request.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Client/menupage_api.dart';
import '../core/local_storage.dart';
import '../features/auth/presentation/purchase_package_popup.dart';
import '../features/navigation/bloc/packages.state.dart';
import '../features/navigation/bloc/packages_bloc.dart';
import '../features/navigation/bloc/packages_event.dart';
import '../models/sortlisted_candidate_model.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    super.key,
    required this.categoryId,
  });
  final String categoryId;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  CandidateRequest candidateRequest = CandidateRequest();
  late PurchasedPackageDataBloc _packageBloc;
  late DashboardBloc dashboardBloc;
  final int _pageSize = 10;

  String Variable = "V";
  @override
  void initState() {
    super.initState();
    dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    _paginationController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _packageBloc = BlocProvider.of<PurchasedPackageDataBloc>(context);

    _packageBloc.add(PurchasedPackageEvent());
  }

  checkPackagesPopup() async {
    showDialog(
        context: context,
        builder: (context) =>
            const AlertDialog(content: PackagesPurchasePopup()));
  }

  final PagingController<int, CandidateData?> _paginationController =
      PagingController(firstPageKey: 1);

  final ScrollController _scrollController = ScrollController();

  Future<void> _fetchPage(int pageKey) async {
    candidateRequest.page = pageKey.toString();
    candidateRequest.categoryId = widget.categoryId;
    dashboardBloc.add(GetDatabyCategory(candidateRequest: candidateRequest));
  }

  @override
  void dispose() {
    _paginationController.dispose();
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
          if (state.currentPackagePlan.package.isEmpty) {
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
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPackageInfoCards(PackageLoadedStates state) {
    final package = state.currentPackagePlan.package.first;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildInfoCard(
            "lib/assets/images/icons-package.png",
            "Current Package",
            package.packageName,
          ),
          _buildInfoCard(
            "lib/assets/images/icons-resume.png",
            "Available Count",
            package.avilableCount.toString(),
          ),
          _buildInfoCard(
            "lib/assets/images/icons-calendar.png",
            "Expire Date",
            package.expDate.toString(),
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

  @override
  Widget build(BuildContext context) {
    // EmployerRegisterModel? employerRegisterModel =
    //     LocalStoragePref.instance?.getUserProfile();
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: PreferredSize(
          preferredSize: Size(20, MediaQuery.of(context).size.height * 0.13),
          child: _buildPackageInfoSection()),
      body: BlocListener<DashboardBloc, DashboardState>(
        bloc: dashboardBloc,
        listener: (context, state) {
          if (state is CategoryListLoadedState) {
            try {
              final candidates = state.candidates;
              final isLastPage = candidates.length < _pageSize;
              if (isLastPage) {
                _paginationController.appendLastPage(candidates);
              } else {
                _paginationController.appendPage(
                    candidates, _paginationController.nextPageKey! + 1);
              }
            } catch (error) {
              _paginationController.error = error;
            }
          }
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
            bloc: dashboardBloc,
            builder: (context, state) {
              return PagedListView<int, CandidateData?>(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                shrinkWrap: true,
                pagingController: _paginationController,
                scrollController: _scrollController,
                builderDelegate: PagedChildBuilderDelegate<CandidateData?>(
                  noItemsFoundIndicatorBuilder: (context) {
                    return Center(child: Text("No data"));
                  },
                  noMoreItemsIndicatorBuilder: (_) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: SizedBox(
                        height: 21,
                      ),
                    ),
                  ),
                  newPageProgressIndicatorBuilder: (_) => const Center(
                    child: BookMaidShimmer(),
                  ),
                  firstPageProgressIndicatorBuilder: (_) =>
                      const Center(child: BookMaidShimmer()),
                  itemBuilder: (context, model, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 15),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8.0),
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
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              model?.rating ?? '',
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
                                          rating: double.parse(model!.rating!),
                                          itemBuilder: (context, index) =>
                                              const Icon(
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
                                          '${model.ratingCount!} Ratings',
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
                                              model.jobType!,
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
                              leading: Image.network(model.image!, height: 45),
                              title: Text(
                                model.categoryName!,
                                style: GoogleFonts.quicksand(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                model.serviceLocation == null
                                    ? ""
                                    : model.serviceLocation!,
                                maxLines: 1,
                                style: GoogleFonts.quicksand(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              trailing: Image.asset(
                                  'lib/assets/images/verified_2x.gif',
                                  height: 28),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 15.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                              text: model.age != null
                                                  ? "${model.age!} Yrs"
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
                                                text: model.gender != null
                                                    ? model.gender!
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                text:
                                                    model.maritalStatus != null
                                                        ? model.maritalStatus!
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
                                                text: model.maximumEducation !=
                                                        null
                                                    ? model.maximumEducation!
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                text: model.religion != null
                                                    ? model.religion!
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
                                                spellOut: true,
                                                text: model.language != null
                                                    ? model.language!.join(",")
                                                    // .join(",")
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                text: model.totalExp != null
                                                    ? "${model.totalExp!} Years"
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
                                                text: model.workingHours != null
                                                    ? "${model.workingHours} Hours"
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                text: model.expectedSalary !=
                                                        null
                                                    ? "Rs. ${model.expectedSalary!}"
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
                            BlocBuilder<PurchasedPackageDataBloc, PackageState>(
                                buildWhen: (PackageState previous,
                                        PackageState current) =>
                                    current is PackageLoadedStates ||
                                    current is PackageLoadingState ||
                                    current is PackageFailedState,
                                builder: (context, state) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 70.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF0DA931),
                                          minimumSize: const Size(0, 35),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                      onPressed: () async {
                                        if (state is PackageLoadedStates) {
                                          if (state.currentPackagePlan.package
                                              .isNotEmpty) {
                                            if (state.currentPackagePlan
                                                    .package[0].packageType ==
                                                Variable) {
                                              LocalStoragePref
                                                  localStoragePref =
                                                  LocalStoragePref();
                                              String userId = localStoragePref
                                                      .getUserProfile()
                                                      ?.userId ??
                                                  "";
                                              if (userId.isEmpty) {
                                                checkPackagesPopup();
                                              } else {
                                                final sortType = "";

                                                try {
                                                  Shortlistedcandidatemodel
                                                      sortListedCandidate =
                                                      await MenuPageRepository()
                                                          .getSortListedCandidate(
                                                              sortType,
                                                              model.candidateId,
                                                              localStoragePref
                                                                  .getUserProfile()!
                                                                  .flag,
                                                              userId);

                                                  BlocProvider.of<
                                                              PurchasedPackageDataBloc>(
                                                          context)
                                                      .add(
                                                          PurchasedPackageEvent());

                                                  setState(() {
                                                    model.isVisible = true;
                                                  });
                                                } catch (e) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Purchase candidate view Package Plan");
                                                }
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Purchase candidate view Package Plan");
                                            }
                                          } else {
                                            checkPackagesPopup();
                                          }
                                        }

                                        // checkPackagesPopup();
                                      },
                                      child: Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const SizedBox(width: 30),
                                          Image.asset(
                                              "lib/assets/images/call.png",
                                              height: 17),
                                          const SizedBox(width: 20),
                                          GestureDetector(
                                            child: SizedBox(
                                                child: model.isVisible ?? false
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          final phoneUri = Uri(
                                                              scheme: 'tel',
                                                              path:
                                                                  "+91 ${model.mobileNo.toString()}");
                                                          launchUrl(phoneUri);
                                                        },
                                                        child: Text(
                                                          // isPurchased
                                                          //     ? model.mobileNo!
                                                          //     :

                                                          model.mobileNo
                                                              .toString(),

                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      whiteColor),
                                                        ),
                                                      )
                                                    : Text(
                                                        // isPurchased
                                                        //     ? model.mobileNo!
                                                        //     :

                                                        model.mobileNo!
                                                            .replaceRange(
                                                                3, 7, "****"),
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    whiteColor),
                                                      )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                            const SizedBox(width: 5),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
      ),
    );
  }
}
