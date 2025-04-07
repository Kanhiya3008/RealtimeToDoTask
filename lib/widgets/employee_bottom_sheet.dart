import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoassignment/feature/employee_add_edit/bloc/employee_add_edit_bloc.dart';
import 'package:todoassignment/widgets/employee_role_item.dart';

ontap(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (bottomSheetContext) {
      return BlocProvider.value(
        value: context.read<EmployeeAddEditBloc>(), // Ensure access to the Bloc
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                menuItems
                    .asMap()
                    .entries
                    .map(
                      (entry) => buildMenuItem(
                        bottomSheetContext, // Use the bottomSheetContext
                        entry.value,
                        entry.key == menuItems.length - 1,
                        // () {
                        //   bottomSheetContext
                        //       .read<EmployeeAddEditBloc>()
                        //       .roleCont
                        //       .text = entry.value;
                        //   bottomSheetContext
                        //       .read<EmployeeAddEditBloc>()
                        //       .roleCont
                        //       .selection = TextSelection.fromPosition(
                        //     TextPosition(offset: entry.value.length),
                        //   );
                        //   Navigator.pop(bottomSheetContext);
                        // },
                      ),
                    )
                    .toList(),
          ),
        ),
      );
    },
  );
}
