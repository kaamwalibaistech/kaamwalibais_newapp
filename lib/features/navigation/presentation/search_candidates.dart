import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kaamwalijobs_new/constant/colors.dart';
import 'package:kaamwalijobs_new/features/dashboard/presentation/Filter_Sort/search_candidates_filter.dart';
import 'package:kaamwalijobs_new/features/navigation/bloc/search_candidate_event.dart';
import 'package:kaamwalijobs_new/features/navigation/bloc/search_candidate_states.dart';
import 'package:kaamwalijobs_new/models/candidate_request.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Client/menupage_api.dart';
import '../../../assets/shimmer_effect/book_maid_shimmer.dart';
import '../../../core/local_storage.dart';
import '../../../models/search_candidate_model.dart';
import '../../../models/sortlisted_candidate_model.dart';
import '../../auth/presentation/purchase_package_popup.dart';
import '../../dashboard/presentation/Filter_Sort/sort_control_model.dart';
import '../../dashboard/presentation/location/location_select.dart';
import '../bloc/packages.state.dart';
import '../bloc/packages_bloc.dart';
import '../bloc/packages_event.dart';
import '../bloc/search_candidate_bloc.dart';

class SearchCandidates extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String categoryId;
  final String categoryName;
  final String cityName;

  SearchCandidates(this.latitude, this.longitude, this.categoryId,
      this.categoryName, this.cityName);

  @override
  State<SearchCandidates> createState() => _SearchCandidatesState();
}

class _SearchCandidatesState extends State<SearchCandidates> {
  // SearchCandidateModel? searchCandidateModel;
  CandidateRequest candidateRequest = CandidateRequest();
  late SearchCandidateBloc _searchCandidateBloc;
  final int _pageSize = 10;
  String searchLocation = "";
  String categoryName = "";

  final PagingController<int, SearchcandidateData?> _paginationController =
      PagingController(firstPageKey: 1);

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    categoryName = widget.categoryName.toString();
    searchLocation = widget.cityName.toString();
    _searchCandidateBloc = BlocProvider.of<SearchCandidateBloc>(context);
    _paginationController.addPageRequestListener((pagekey) {
      _fetchPage(pagekey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    candidateRequest.categoryId = widget.categoryId.toString();
    candidateRequest.userId = "";
    candidateRequest.page = pageKey.toString();
    candidateRequest.latitude = widget.latitude.toString();
    candidateRequest.longitude = widget.longitude.toString();
    candidateRequest.km = "3";
    candidateRequest.minSalry = "";
    candidateRequest.maxSalary = "";
    candidateRequest.passport = "";
    candidateRequest.minAge = "";
    candidateRequest.maxAge = "";
    candidateRequest.minExp = "";
    candidateRequest.maxExp = "";
    candidateRequest.gender = "";
    candidateRequest.workingHours = "";
    candidateRequest.religon = "";
    candidateRequest.language = "";
    candidateRequest.sortBy = "";
    _searchCandidateBloc
        .add(SearchCandidateLoadDataEvent(candidateRequest: candidateRequest));
  }

  sortcandidate(String sortvalueM) {
    _paginationController.refresh();
    candidateRequest.sortBy = sortvalueM;
    _searchCandidateBloc
        .add(SearchCandidateLoadDataEvent(candidateRequest: candidateRequest));
  }

  @override
  void dispose() {
    _paginationController.dispose();
    super.dispose();
  }

  checkPackagesPopup() async {
    showDialog(
        context: context,
        builder: (context) =>
            const AlertDialog(content: PackagesPurchasePopup()));
  }

  Future<void> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      double latitude = locations.first.latitude;
      double longitude = locations.first.longitude;

      candidateRequest.latitude = latitude.toString();
      candidateRequest.longitude = longitude.toString();

      _searchCandidateBloc.add(
          SearchCandidateLoadDataEvent(candidateRequest: candidateRequest));
    } catch (e) {
      print("Error: $e");
    }
  }

  /* .................. Sort .......................... */

  String sortByValue = "";

  List<SortModel> sortList = [
    SortModel("2", "Newest First"),
    SortModel("3", "Highest Paid"),
    SortModel("4", "Lowest Paid"),
    SortModel("5", "Experienced"),
    SortModel("6", "Freshers"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 160,
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.only(top: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () async {
                                final city = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LocationSelectScreen()));
                                if (city != null && city is String) {
                                  setState(() {
                                    searchLocation = city;
                                  });
                                  _paginationController.refresh();
                                  getCoordinatesFromAddress(searchLocation);
                                }
                              },
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 0.5),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Row(children: [
                                    const Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        searchLocation,
                                        maxLines: 1,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          searchLocation = "Location search";
                                        });
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ])),
                            )),
                            Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: GestureDetector(
                                onTap: () async {
                                  final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchCandidatesFilter()));
                                  if (result != null) {
                                    if (result['categoryName'] != '') {
                                      setState(() {
                                        categoryName = result['categoryName'];
                                      });
                                    }
                                    _paginationController.refresh();
                                    try {
                                      if (result['categoryId'] != '')
                                        candidateRequest.categoryId =
                                            result['categoryId'];

                                      if (result['minSalary'] != '')
                                        candidateRequest.minSalry =
                                            result['minSalary'];
                                      if (result['maxSalary'] != '')
                                        candidateRequest.maxSalary =
                                            result['maxSalary'];

                                      if (result['passportValue'] != '')
                                        candidateRequest.passport =
                                            result['passportValue'];

                                      if (result['minAge'] != '')
                                        candidateRequest.minAge =
                                            result['minAge'];
                                      if (result['maxAge'] != '')
                                        candidateRequest.maxAge =
                                            result['maxAge'];

                                      if (result['minExperience'] != '')
                                        candidateRequest.minExp =
                                            result['minExperience'];
                                      if (result['maxExperience'] != '')
                                        candidateRequest.maxExp =
                                            result['maxExperience'];

                                      if (result['genderValue'] != null &&
                                          result['genderValue'].isNotEmpty)
                                        candidateRequest.gender =
                                            result['genderValue'].join(',');

                                      if (result['workingHoursValue'] != null &&
                                          result['workingHoursValue']
                                              .isNotEmpty)
                                        candidateRequest.workingHours =
                                            result['workingHoursValue']
                                                .join(',');

                                      if (result['religionValue'] != null &&
                                          result['religionValue'].isNotEmpty)
                                        candidateRequest.religon =
                                            result['religionValue'].join(',');

                                      if (result['languageValue'] != null &&
                                          result['languageValue'].isNotEmpty)
                                        candidateRequest.language =
                                            result['languageValue'].join(',');

                                      if (result['km'] != '')
                                        candidateRequest.km = result['km'];

                                      // Reset pagination and fetch new results
                                      _paginationController.refresh();
                                      _searchCandidateBloc.add(
                                          SearchCandidateLoadDataEvent(
                                              candidateRequest:
                                                  candidateRequest));
                                    } catch (e) {
                                      print("Error applying filters: $e");
                                      Fluttertoast.showToast(
                                          msg:
                                              "Error applying filters. Please try again.");
                                    }
                                  }
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'lib/assets/images/advance_options.png',
                                      height: 16,
                                    ),
                                    Text(
                                      'Filter',
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 10),
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //           SnackBar(content: Text("Sort")));
                            //       showSortDialog(context);
                            //     },
                            //     child: Column(
                            //       children: [
                            //         const Icon(
                            //           Icons.sort,
                            //           size: 20,
                            //         ),
                            //         Text(
                            //           'Sort',
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                          ]),
                      BlocBuilder<SearchCandidateBloc, SearchCandidateStates>(
                          bloc: _searchCandidateBloc,
                          buildWhen: (previous, current) {
                            return current is SearchCandidateCountLoaded ||
                                current is SearchCandidateCountLoading ||
                                current is SearchCandidateCountError;
                          },
                          builder: (context, state) {
                            if (state is SearchCandidateCountLoaded) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: Text(
                                  "${categoryName} - Showing ${state.candidatecount} results",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: Text(
                                  "${widget.categoryName} - Showing results",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade900),
                                ),
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ),
              BlocListener<SearchCandidateBloc, SearchCandidateStates>(
                bloc: _searchCandidateBloc,
                listener: (context, state) {
                  if (state is SearchCandidateSuccessState) {
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
                child: PagedListView<int, SearchcandidateData?>(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  shrinkWrap: true,
                  pagingController: _paginationController,
                  scrollController: _scrollController,
                  builderDelegate:
                      PagedChildBuilderDelegate<SearchcandidateData?>(
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
                    newPageProgressIndicatorBuilder: (_) =>
                        const Center(child: BookMaidShimmer()),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8.0),
                                    child: GestureDetector(
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
                                                  color: Colors.white,
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
                                            rating: double.parse(
                                                model!.rating.toString()),
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
                                            '${model.ratingCount} Ratings',
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
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                ),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                model.jobType.toString(),
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
                                leading: Image.network(model.image.toString(),
                                    height: 45),
                                title: Text(
                                  model.categoryName.toString(),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  model.serviceLocation.toString(),
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
                                                text: "${model.age} Yrs",
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
                                                  text: model.gender,
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
                                                  text: model.maritalStatus,
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
                                                  text: model.maximumEducation,
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
                                                  text: model.religion,
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
                                                  text:
                                                      "${model.workingHours} Hours",
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
                                                  text:
                                                      "${model.totalExp} Years",
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
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "Language: ",
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color: textBlackColor2,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: model.language
                                                        .join(",")
                                                        .replaceAll(
                                                            "Language.", " "),
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color: textBlackColor2,
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                                                  text:
                                                      "Rs. ${model.expectedSalary}",
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
                              BlocBuilder<PurchasedPackageDataBloc,
                                      PackageState>(
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
                                                  "V") {
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
                                                                model
                                                                    .candidateId,
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
                                                    checkPackagesPopup();
                                                  }
                                                }
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Purchase candidate view Package Plan");
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Purchase candidate view Package Plan");
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Purchase candidate view Package Plan");
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
                                                  child: model.isVisible ??
                                                          false
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

                                                            style: GoogleFonts.poppins(
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

                                                          model.mobileNo
                                                              .replaceRange(
                                                                  3, 7, "****"),
                                                          style: GoogleFonts
                                                              .poppins(
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sort by'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: sortList.length,
                itemBuilder: (context, int index) {
                  return ListTile(
                    title: GestureDetector(
                        onTap: () {
                          setState(() {
                            sortByValue = sortList[index].id.toString();
                          });
                          sortcandidate(sortByValue);
                          Navigator.of(context).pop();
                        },
                        child: Text(sortList[index].title.toString())),
                  );
                }),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
