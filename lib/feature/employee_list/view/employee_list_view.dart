import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoassignment/feature/employee_add_edit/bloc/employee_add_edit_bloc.dart';
import 'package:todoassignment/feature/employee_add_edit/bloc/employee_add_edit_event.dart';
import 'package:todoassignment/feature/employee_list/bloc/employee_list_bloc.dart';
import 'package:todoassignment/feature/employee_list/bloc/employee_list_event.dart';
import 'package:todoassignment/feature/employee_list/bloc/employee_list_state.dart';
import 'package:todoassignment/models/employee_add_edit_args_model.dart';
import 'package:todoassignment/route/app_routes.dart';
import 'package:todoassignment/theme/app_text_style.dart';
import 'package:todoassignment/widgets/my_scaffold.dart';

class EmployeeListView extends StatelessWidget {
  const EmployeeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffoldWidget(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text("Employee List", style: AppTextStyles.appBarTitle),
      ),
      body: BlocBuilder<EmployeeListBloc, EmployeeListState>(
        builder: (context, state) {
          if (state is EmployeeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EmployeeLoadedState) {
            final currentEmployees = state.currentEmployees;
            final previousEmployees = state.previousEmployees;

            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  currentEmployees.isEmpty && previousEmployees.isEmpty
                      ? Center(
                        child: Image.asset(
                          "assets/Group 5367.png",
                          width: MediaQuery.of(context).size.width / 1.5,
                        ),
                      )
                      : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (currentEmployees.isNotEmpty) ...[
                              sectionHeader("Current Employees"),
                              employeeListBuilder(context, currentEmployees),
                            ],
                            if (previousEmployees.isNotEmpty) ...[
                              sectionHeader("Previous Employees"),
                              employeeListBuilder(
                                context,
                                previousEmployees,
                                isPrevious: true,
                              ),
                            ],
                          ],
                        ),
                      ),

                  if (currentEmployees.isNotEmpty ||
                      previousEmployees.isNotEmpty)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: MediaQuery.sizeOf(context).height / 10,
                        width: MediaQuery.sizeOf(context).width,
                        color: Color(0xfff2f2f2),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "Swipe left to delete",
                            style: AppTextStyles.employeeRole,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
        buildWhen:
            (previous, current) =>
                previous != current &&
                (current is EmployeeLoadedState ||
                    current is EmployeeLoadingState),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addEditEmployee);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget sectionHeader(String title) {
    return Container(
      width: double.infinity,
      color: Color(0xfff2f2f2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Text(title),
    );
  }

  Widget employeeListBuilder(
    BuildContext context,
    List employeeList, {
    bool isPrevious = false,
  }) {
    final bloc = context.read<EmployeeListBloc>(); // Capture bloc once
    final messenger = ScaffoldMessenger.of(
      context,
    ); // Capture scaffold messenger once

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: employeeList.length,
      itemBuilder: (context, index) {
        final employee = employeeList[index];

        return Dismissible(
          key: Key(employee.id ?? employee.role ?? index.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Icon(Icons.delete, color: Colors.white),
          ),

          onDismissed: (_) {
            final deletedEmployee = employee;
            bloc.add(EmployeeDeleteEvent(employeeModel: deletedEmployee));

            // Use post-frame callback to delay the snackbar after build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final stableContext = context; // still safe here
              ScaffoldMessenger.of(stableContext).showSnackBar(
                SnackBar(
                  content: Text("Employee data has been deleted"),
                  action: SnackBarAction(
                    label: "Undo",
                    onPressed: () {
                      bloc.add(
                        EmployeeUndoEvent(employeeModel: deletedEmployee),
                      );
                    },
                  ),
                ),
              );
            });
          },
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.addEditEmployee,
                arguments: EmployeeAddEditArgsModel(
                  isEdit: true,
                  employeeModel: employee,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(employee.name ?? "", style: AppTextStyles.employeeName),
                  Text(employee.role ?? "", style: AppTextStyles.employeeRole),
                  Row(
                    children: [
                      if (employee.from != null)
                        Text("From ", style: AppTextStyles.employeeDate),
                      if (employee.from != null)
                        Text(
                          DateFormat(
                            "dd MMM, yyyy",
                          ).format(DateTime.parse(employee.from)),
                          style: AppTextStyles.employeeDate,
                        ),
                      if (isPrevious) ...[
                        const SizedBox(width: 5),
                        Text("-"),
                        const SizedBox(width: 5),
                        if (employee.to != null)
                          Text(
                            DateFormat(
                              "dd MMM, yyyy",
                            ).format(DateTime.parse(employee.to)),
                            style: AppTextStyles.employeeDate,
                          ),
                      ],
                    ],
                  ),
                  if (employeeList.length > 1 &&
                      index != employeeList.length - 1) ...[
                    SizedBox(height: 12),
                    Divider(color: Colors.grey[300], height: 1),
                  ],

                  if (index == employeeList.length - 1) SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
