import 'package:equatable/equatable.dart';

import '../../../models/job_listing.dart';

abstract class JobState extends Equatable {
  @override
  List<Object> get props => [];
}

class JobInitial extends JobState {
  @override
  List<Object> get props => [];
}

class JobListLoadedState extends JobState {
  JobListLoadedState({required this.job});
  final List<JobData> job;
  @override
  List<Object> get props => [job];
}

class JobFailedState extends JobState {
  @override
  List<Object> get props => [];
}
