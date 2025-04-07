import 'package:equatable/equatable.dart';

class EmployeeAddEditState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmployeeAddEditLoadingState extends EmployeeAddEditState {
  final bool isLoading;
  EmployeeAddEditLoadingState({this.isLoading = false});

  @override
  List<Object?> get props => [isLoading];
}
