import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kaamwalijobs_new/assets/colors.dart';
import 'package:kaamwalijobs_new/constant/sizebox.dart';
import 'package:kaamwalijobs_new/features/jobs/bloc/job_bloc.dart';
import 'package:kaamwalijobs_new/features/jobs/bloc/job_event.dart';
import 'package:kaamwalijobs_new/features/jobs/bloc/job_state.dart';
import 'package:kaamwalijobs_new/models/job_listing.dart';

import '../../../assets/shimmer_effect/book_maid_shimmer.dart';
import 'jobs_apply.dart';

class Alljobsopenings extends StatefulWidget {
  const Alljobsopenings({super.key});

  @override
  State<Alljobsopenings> createState() => _AlljobsopeningsState();
}

class _AlljobsopeningsState extends State<Alljobsopenings> {
  late JobBloc _jobBloc;
  final int _pageSize = 10;
  @override
  void initState() {
    super.initState();
    _jobBloc = BlocProvider.of<JobBloc>(context);
    _paginationController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  final PagingController<int, JobData?> _paginationController =
      PagingController(firstPageKey: 1);

  final ScrollController _scrollController = ScrollController();

  Future<void> _fetchPage(int pageKey) async {
    _jobBloc.add(GetJobs(pageNo: pageKey));
  }

  @override
  void dispose() {
    _paginationController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        backgroundColor: scaffoldColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      body: BlocListener<JobBloc, JobState>(
        listener: (context, state) {
          if (state is JobListLoadedState) {
            try {
              final jobs = state.job;
              final isLastPage = jobs.length < _pageSize;
              if (isLastPage) {
                _paginationController.appendLastPage(jobs);
              } else {
                _paginationController.appendPage(
                    jobs, _paginationController.nextPageKey! + 1);
              }
            } catch (error) {
              _paginationController.error = error;
            }
          }
        },
        child: PagedListView<int, JobData?>(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          shrinkWrap: true,
          pagingController: _paginationController,
          scrollController: _scrollController,
          builderDelegate: PagedChildBuilderDelegate<JobData?>(
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
              itemBuilder: (context, job, index) {
                return JobCard(
                  job: job,
                );
              },
              noItemsFoundIndicatorBuilder: (
                _,
              ) =>
                  const SizedBox.shrink()),
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  const JobCard({super.key, required this.job});
  final JobData? job;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.36,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    job!.postedBy!,
                    style: TextStyle(color: textGreyColor),
                  ),
                ],
              ),
              Text(job!.jobType!),
              Text(
                job!.jobLocation!,
                style: TextStyle(color: textGreyColor),
              ),
              sizedBoxH10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Center(
                      child: RichText(
                          text: TextSpan(
                              style: TextStyle(color: blackColor),
                              children: [
                            TextSpan(text: "Age "),
                            TextSpan(text: job!.age),
                            TextSpan(text: " Yrs"),
                          ])),
                    ),
                    height: 32,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 230, 234, 245)),
                  ),
                  Container(
                    child: Center(child: Text(job!.gender!)),
                    height: 32,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 230, 234, 245)),
                  ),
                  Container(
                    child: Center(child: Text(job!.religion!)),
                    height: 32,
                    width: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 230, 234, 245)),
                  )
                ],
              ),
              sizedBoxH15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Center(
                      child: RichText(
                          text: TextSpan(
                              style: TextStyle(color: blackColor),
                              children: [
                            TextSpan(text: "Experience - "),
                            TextSpan(text: job!.experience),
                            TextSpan(text: " Years"),
                          ])),
                    ),
                    height: 32,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 230, 234, 245)),
                  ),
                  Container(
                    child: Center(
                      child: RichText(
                          text: TextSpan(
                              style: TextStyle(color: blackColor),
                              children: [
                            TextSpan(text: "Working - "),
                            TextSpan(text: job!.workingHours ?? ''),
                          ])),
                    ),
                    height: 32,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 230, 234, 245)),
                  ),
                ],
              ),
              sizedBoxH15,
              Container(
                child: Center(
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: blackColor),
                          children: [
                        TextSpan(text: "Maritial status - "),
                        TextSpan(text: job!.maritalStatus!),
                      ])),
                ),
                height: 32,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 230, 234, 245)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new JobsApply(
                                    jobsLocation: job!.jobLocation.toString(),
                                    jobsType: job!.jobType.toString(),
                                    jobsId: job!.jobpostId.toString())));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(5)),
                        height: 32,
                        width: 100,
                        child: Center(
                          child: Text(
                            "Apply",
                            style: TextStyle(color: whiteColor),
                          ),
                        ),
                      ),
                    ),
                    Text("Rs. ${job!.monthPrice} / month")
                  ],
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 200, 197, 197),
                // spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(5, 5), // changes position of shadow
              ),
            ],
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: const Color.fromARGB(255, 243, 243, 245))),
      ),
    );
  }
}
