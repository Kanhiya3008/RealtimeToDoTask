import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoassignment/feature/employee_add_edit/bloc/employee_add_edit_bloc.dart';
import 'package:todoassignment/feature/employee_add_edit/bloc/employee_add_edit_event.dart';
import 'package:todoassignment/feature/employee_add_edit/view/employee_add_edit_view.dart';
import 'package:todoassignment/feature/employee_list/view/employee_list_view.dart';
import 'package:todoassignment/models/employee_add_edit_args_model.dart';
import 'package:todoassignment/route/app_routes.dart';

class AppPages {
  static Route<dynamic>? onGenerateRoute(RouteSettings setttings) {
    switch (setttings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => const EmployeeListView(),
        );
      case AppRoutes.addEditEmployee:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider.value(
                value: BlocProvider.of<EmployeeAddEditBloc>(context)..add(
                  EmployeeAddEditInitEvent(
                    argsModel: setttings.arguments as EmployeeAddEditArgsModel?,
                  ),
                ),
                // create:
                //     (context) =>
                //         EmployeeAddEditBloc()..add(
                //           EmployeeAddEditInitEvent(
                //             argsModel:
                //                 setttings.arguments
                //                     as EmployeeAddEditArgsModel?,
                //           ),
                //         ),
                child: const EmployeeAddEditView(),
              ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const EmployeeListView(),
        );
    }
  }
}
