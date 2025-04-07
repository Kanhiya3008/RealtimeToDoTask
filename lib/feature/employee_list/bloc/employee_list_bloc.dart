import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:todoassignment/feature/employee_list/bloc/employee_list_event.dart';
import 'package:todoassignment/feature/employee_list/bloc/employee_list_state.dart';
import 'package:todoassignment/models/employee_model.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  EmployeeModel? _lastDeletedEmployee;

  EmployeeListBloc() : super(EmployeeLoadingState()) {
    on<EmployeeInitEvent>(_onInitEvent);
    on<EmployeeFetchEvent>(_onFetchEvent);
    on<EmployeeDeleteEvent>(_onDeleteEvent);
    on<EmployeeUndoEvent>(_onUndoEvent);
  }

  void _onInitEvent(EmployeeInitEvent event, Emitter<EmployeeListState> emit) {}

  Future<void> _onFetchEvent(
    EmployeeFetchEvent event,
    Emitter<EmployeeListState> emit,
  ) async {
    emit(EmployeeLoadingState(isLoading: true));

    var box = await Hive.openBox('myBox');
    List<EmployeeModel> allEmployees = [];

    for (var item in box.values) {
      allEmployees.add(EmployeeModel.fromJson(item));
    }

    final currentEmployees =
        allEmployees.where((e) => e.to == "No Date").toList();
    final previousEmployees =
        allEmployees.where((e) => e.to != "No Date").toList();

    emit(
      EmployeeLoadedState(
        currentEmployees: currentEmployees,
        previousEmployees: previousEmployees,
      ),
    );
  }

  Future<void> _onDeleteEvent(
    EmployeeDeleteEvent event,
    Emitter<EmployeeListState> emit,
  ) async {
    var box = await Hive.openBox('myBox');

    _lastDeletedEmployee = event.employeeModel;

    print("DELETE EMPLOYEE: ${event.employeeModel.toJson()}");

    await box.delete(event.employeeModel.id);

    add(EmployeeFetchEvent());
  }

  Future<void> _onUndoEvent(
    EmployeeUndoEvent event,
    Emitter<EmployeeListState> emit,
  ) async {
    if (_lastDeletedEmployee != null) {
      var box = await Hive.openBox('myBox');

      box.put(_lastDeletedEmployee!.id, _lastDeletedEmployee!.toJson());

      _lastDeletedEmployee = null;

      add(EmployeeFetchEvent());
    }
  }
}
