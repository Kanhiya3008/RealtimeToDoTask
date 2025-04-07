// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

// Future<void> _deleteItem(int index, BuildContext context) async {
//   var box = await Hive.openBox('myBox');
//   String deletedItem = box.getAt(index)!;
//   box.deleteAt(index);

//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text("Deleted $deletedItem"),
//       action: SnackBarAction(
//         label: "Undo",
//         onPressed: () {
//           box.putAt(index, deletedItem);
//           ; // Refresh UI
//         },
//       ),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoassignment/feature/employee_list/bloc/employee_list_bloc.dart';
import 'package:todoassignment/feature/employee_list/bloc/employee_list_event.dart';
import 'package:todoassignment/models/employee_model.dart';

SnackBar buildUndoSnackbar(BuildContext context, EmployeeModel employee) {
  return SnackBar(
    content: Text('${employee.name} deleted'),
    action: SnackBarAction(
      label: 'UNDO',
      onPressed: () {
        context.read<EmployeeListBloc>().add(
          EmployeeUndoEvent(employeeModel: employee),
        );
      },
    ),
  );
}
