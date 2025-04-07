import 'package:equatable/equatable.dart';
import 'package:todoassignment/models/employee_model.dart';

abstract class EmployeeListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmployeeInitEvent extends EmployeeListEvent {}

class EmployeeFetchEvent extends EmployeeListEvent {}

class EmployeeDeleteEvent extends EmployeeListEvent {
  final EmployeeModel employeeModel;

  EmployeeDeleteEvent({required this.employeeModel});

  @override
  List<Object?> get props => [employeeModel];
}

class EmployeeUndoEvent extends EmployeeListEvent {
  final EmployeeModel employeeModel;

  EmployeeUndoEvent({required this.employeeModel});

  @override
  List<Object?> get props => [employeeModel];
}
