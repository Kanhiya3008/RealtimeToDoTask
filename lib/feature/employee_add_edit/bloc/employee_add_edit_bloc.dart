import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todoassignment/feature/employee_add_edit/bloc/employee_add_edit_event.dart';
import 'package:todoassignment/feature/employee_add_edit/bloc/employee_add_edit_state.dart';
import 'package:todoassignment/models/employee_model.dart';

class EmployeeAddEditBloc
    extends Bloc<EmployeeAddEditEvent, EmployeeAddEditState> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController roleCont = TextEditingController();
  TextEditingController dateFromCont = TextEditingController();
  TextEditingController dateToCont = TextEditingController();
  bool isEditView = false;
  EmployeeModel? editEmployeeModel;
  EmployeeAddEditBloc() : super(EmployeeAddEditLoadingState()) {
    on<EmployeeAddEditInitEvent>(_onInitEvent);
    on<EmployeeAddEvent>(_onAddEvent);
    on<EmployeeEditEvent>(_onEditEvent);
    on<EmployeeSelectDateEvent>(_onDateSelect);
  }

  void _onDateSelect(
    EmployeeSelectDateEvent event,
    Emitter<EmployeeAddEditState> emit,
  ) {
    // Handle the date selection event
    if (event.selectedDate != null) {
      dateToCont.text = event.selectedDate!;
    }
  }

  void _onInitEvent(
    EmployeeAddEditInitEvent event,
    Emitter<EmployeeAddEditState> emit,
  ) {
    nameCont.text = event.argsModel?.employeeModel?.name ?? "";
    roleCont.text = event.argsModel?.employeeModel?.role ?? "";
    dateFromCont.text = event.argsModel?.employeeModel?.from ?? "";
    dateToCont.text = event.argsModel?.employeeModel?.to ?? "";
    isEditView = event.argsModel?.isEdit ?? false;
    editEmployeeModel = event.argsModel?.employeeModel;
  }

  // void _onDeleteEvent(
  //   EmployeeDeleteEvent event,
  //   Emitter<EmployeeAddEditState> emit,
  // ) async {
  //   var box = await Hive.openBox('myBox');

  //   if (event.index >= 0 && event.index < box.length) {
  //     await box.deleteAt(event.index);
  //   }

  // }

  Future<void> _onAddEvent(
    EmployeeAddEvent event,
    Emitter<EmployeeAddEditState> emit,
  ) async {
    // Handle the add event
    if (nameCont.text.isEmpty) {
      print('not empty');
      // emit(EmployeeAddEditErrorState(error: "Name cannot be empty"));
      return;
    }
    var box = await Hive.openBox('myBox');
    final random = Random();
    int randomId = 100000 + random.nextInt(900000);
    EmployeeModel employeeModel = EmployeeModel(
      name: nameCont.text,
      id: randomId.toString(),
      role: roleCont.text,
      from: dateFromCont.text,
      to: dateToCont.text,
    );
    box.put(randomId.toString(), employeeModel.toJson());
  }

  Future<void> _onEditEvent(
    EmployeeEditEvent event,
    Emitter<EmployeeAddEditState> emit,
  ) async {
    if (nameCont.text.isEmpty) {
      print('not empty');
      // emit(EmployeeAddEditErrorState(error: "Name cannot be empty"));
      return;
    }
    var box = await Hive.openBox('myBox');
    EmployeeModel employeeModel = EmployeeModel(
      name: nameCont.text,
      role: roleCont.text,
      from: dateFromCont.text,
      to: dateToCont.text,
      id: editEmployeeModel?.id,
    );

    print("EDIT EMPLOYEE: ${employeeModel.toJson()}");
    box.put(editEmployeeModel?.id, employeeModel.toJson());
    // Handle the edit event
  }

  @override
  Future<void> close() {
    nameCont.dispose();
    return super.close();
  }
}
