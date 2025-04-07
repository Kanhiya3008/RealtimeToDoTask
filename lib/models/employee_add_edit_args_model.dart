import 'package:todoassignment/models/employee_model.dart';

class EmployeeAddEditArgsModel {
  final EmployeeModel? employeeModel;
  final bool isEdit;
  EmployeeAddEditArgsModel({this.employeeModel, this.isEdit = false});
}
