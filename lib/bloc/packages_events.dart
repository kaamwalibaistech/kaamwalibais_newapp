import 'package:equatable/equatable.dart';

abstract class PackagesEvent extends Equatable {}

class GetPackagesEvent extends PackagesEvent {
  @override
  List<Object?> get props => [];
}
