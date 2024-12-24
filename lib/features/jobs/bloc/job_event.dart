import 'package:equatable/equatable.dart';

abstract class JobEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetJobs extends JobEvent {
  final int pageNo;
  GetJobs({required this.pageNo});
  @override
  List<Object?> get props => [];
}
