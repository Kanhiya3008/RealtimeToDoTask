import 'package:equatable/equatable.dart';
import 'package:todoassignment/models/employee_model.dart';

abstract class EmployeeListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmployeeLoadingState extends EmployeeListState {
  final bool isLoading;

  EmployeeLoadingState({this.isLoading = false});

  @override
  List<Object?> get props => [isLoading];
}

class EmployeeLoadedState extends EmployeeListState {
  final List<EmployeeModel> currentEmployees;
  final List<EmployeeModel> previousEmployees;

  EmployeeLoadedState({
    required this.currentEmployees,
    required this.previousEmployees,
  });

  @override
  List<Object?> get props => [currentEmployees, previousEmployees];
}
