import 'package:todoassignment/models/NoDateModel.dart';
import 'package:todoassignment/models/employee_add_edit_args_model.dart';
import 'package:todoassignment/models/employee_model.dart';

class EmployeeAddEditEvent {}

class EmployeeAddEditInitEvent extends EmployeeAddEditEvent {
  EmployeeAddEditArgsModel? argsModel;

  EmployeeAddEditInitEvent({this.argsModel});
}

class EmployeeAddEvent extends EmployeeAddEditEvent {}

class EmployeeEditEvent extends EmployeeAddEditEvent {}

class EmployeeSelectDateEvent extends EmployeeAddEditEvent {
  final String? selectedDate;
  EmployeeSelectDateEvent(this.selectedDate);
  // @override
  // List<Object?> get props => [selectedDate];
}
