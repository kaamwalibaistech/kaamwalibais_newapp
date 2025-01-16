import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/features/navigation/bloc/search_candidate_event.dart';
import 'package:kaamwalijobs_new/features/navigation/bloc/search_candidate_states.dart';
import 'package:kaamwalijobs_new/models/candidate_model.dart';
import 'package:kaamwalijobs_new/models/candidate_request.dart';

import '../../../assets/shimmer_effect/book_maid_shimmer.dart';
import '../../../models/search_candidate_model.dart';
import '../../dashboard/presentation/location/location_select.dart';
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

  final PagingController<int, SearchcandidateData?> _paginationController =
      PagingController(firstPageKey: 1);

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    searchLocation = widget.cityName.toString();
    _searchCandidateBloc = BlocProvider.of<SearchCandidateBloc>(context);
    _paginationController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    candidateRequest.categoryId = widget.categoryId.toString();
    candidateRequest.userId = "5";
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

  @override
  void dispose() {
    _paginationController.dispose();
    super.dispose();
  }

  Future<void> getCoordinatesFromAddress(String address, int pageKey) async {
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
                                  getCoordinatesFromAddress(searchLocation, 1);
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
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.sort,
                                    size: 20,
                                  ),
                                  Text(
                                    'Sort',
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ]),
                      BlocBuilder<SearchCandidateBloc, SearchCandidateStates>(
                          builder: (context, state) {
                        if (state is SearchCandidateCountLoaded)
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Text(
                              "${widget.categoryName} - Showing ${state.candidatecount} results",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900),
                            ),
                          );
                        else {
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
                  builderDelegate: PagedChildBuilderDelegate<
                          SearchcandidateData?>(
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
                                                        BorderRadius.circular(
                                                            5)),
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
                                              rating:
                                                  double.parse(model!.rating),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              decoration: const ShapeDecoration(
                                                color: blueColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                  ),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  model.jobType,
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
                                  leading:
                                      Image.network(model.image, height: 45),
                                  title: Text(
                                    model.categoryName,
                                    style: GoogleFonts.quicksand(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    model.serviceLocation == null
                                        ? ""
                                        : model.serviceLocation,
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
                                                      ? "${model.age} Yrs"
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color: textBlackColor2,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: model.gender != null
                                                        ? model.gender
                                                        : "",
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color: textBlackColor2,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: model.maritalStatus !=
                                                            null
                                                        ? model.maritalStatus
                                                        : "",
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
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "Education: ",
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color: textBlackColor2,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        model.maximumEducation !=
                                                                null
                                                            ? model
                                                                .maximumEducation
                                                            : "",
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color: textBlackColor2,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: model.religion != null
                                                        ? model.religion
                                                        : "",
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
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            child: Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "Working Hours: ",
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color: textBlackColor2,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: model.workingHours !=
                                                            null
                                                        ? "${model.workingHours} Hours"
                                                        : "",
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color: textBlackColor2,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: model.totalExp != null
                                                        ? "${model.totalExp} Years"
                                                        : "",
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
                                          const SizedBox(height: 10),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Language: ",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12,
                                                        color: textBlackColor2,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          model.language != null
                                                              ? model.language
                                                                  .join(",")
                                                              : "",
                                                      style:
                                                          GoogleFonts.poppins(
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12,
                                                      color: textBlackColor2,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: model.expectedSalary !=
                                                            null
                                                        ? "Rs. ${model.expectedSalary}"
                                                        : "",
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
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  child: Stack(
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF0DA931),
                                            minimumSize: const Size(0, 35),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () {
                                          //checkPackagesPopup();
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
                                            SizedBox(
                                              child: Text(
                                                model.mobileNo
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
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      noItemsFoundIndicatorBuilder: (
                        _,
                      ) =>
                          const SizedBox.shrink()),
                ),

                // builder: (context, state) {
                //   if (state is SearchCandidateLoadingState) {
                //     return Expanded(child: BookMaidShimmer());
                //   } else if (state is SearchCandidateSuccessState) {
                //     return state.searchCandidateModel.status == 'error'
                //         ? Container(
                //             child: Text(
                //               'No candidate available',
                //               style: TextStyle(color: Colors.black),
                //             ),
                //           )
                //         : Text(state.searchCandidateModel.status);
                //   } else if (state is SearchCandidateErrorState) {
                //     return Text(state.errorMsg);
                //   }
                //   return Text("No state is visiting!");
                // },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*loadData() {
    PagedListView<int, CandidateData?>(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      shrinkWrap: true,
      pagingController: _paginationController,
      scrollController: _scrollController,
      builderDelegate: PagedChildBuilderDelegate<CandidateData?>(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                      trailing: Image.asset('lib/assets/images/verified_2x.gif',
                          height: 28),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
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
                                        text: model.maritalStatus != null
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
                                        text: model.maximumEducation != null
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
                                        text: "Language: ",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: textBlackColor2,
                                        ),
                                      ),
                                      TextSpan(
                                        text: model.language != null
                                            ? model.language!.join(",")
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
                                        text: model.expectedSalary != null
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Stack(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0DA931),
                                minimumSize: const Size(0, 35),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {
                              checkPackagesPopup();
                            },
                            child: Row(
                              // mainAxisAlignment:
                              //     MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(width: 30),
                                Image.asset("lib/assets/images/call.png",
                                    height: 17),
                                const SizedBox(width: 20),
                                SizedBox(
                                  child: Text(
                                    model.mobileNo!.replaceRange(3, 7, "****"),
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: whiteColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          },
          noItemsFoundIndicatorBuilder: (
            _,
          ) =>
              const SizedBox.shrink()),
    );
  }*/
}
