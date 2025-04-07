import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todoassignment/feature/employee_add_edit/bloc/employee_add_edit_bloc.dart';
import 'package:todoassignment/feature/employee_add_edit/bloc/employee_add_edit_event.dart';
import 'package:todoassignment/feature/employee_add_edit/bloc/employee_add_edit_state.dart';
import 'package:todoassignment/feature/employee_list/bloc/employee_list_bloc.dart';
import 'package:todoassignment/feature/employee_list/bloc/employee_list_event.dart';
import 'package:todoassignment/feature/employee_list/bloc/employee_list_state.dart';
import 'package:todoassignment/models/employee_model.dart';
import 'package:todoassignment/theme/app_text_style.dart';
import 'package:todoassignment/widgets/employee_role_item.dart';
import 'package:todoassignment/widgets/my_custome_DatePicker.dart';
import 'package:todoassignment/widgets/my_custome_button.dart';
import 'package:todoassignment/widgets/my_scaffold.dart';
import 'package:todoassignment/widgets/my_textField.dart';

class EmployeeAddEditView extends StatefulWidget {
  const EmployeeAddEditView({super.key});

  @override
  State<EmployeeAddEditView> createState() => _EmployeeAddEditViewState();
}

class _EmployeeAddEditViewState extends State<EmployeeAddEditView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MyScaffoldWidget(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Text("Employee Add Details"),
      ),
      body: Center(
        child: Container(
          width:
              kIsWeb && MediaQuery.of(context).size.width > 600
                  ? MediaQuery.of(context).size.width / 2
                  : MediaQuery.of(context).size.width,
          child: BlocBuilder<EmployeeAddEditBloc, EmployeeAddEditState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          CustomTextField(
                            hintText: "Employee Name",
                            prefixImage: "assets/person.png",
                            controller:
                                context.read<EmployeeAddEditBloc>().nameCont,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Employee Name is required";
                              }
                              if (value.length < 3) {
                                return "Name must be at least 3 characters";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          CustomTextField(
                            hintText: "Select Role",
                            prefixImage:
                                "assets/work_FILL0_wght300_GRAD0_opsz24 1.png",
                            suffixImage:
                                "assets/arrow_drop_down_FILL1_wght400_GRAD0_opsz24 3.png",
                            controller:
                                context.read<EmployeeAddEditBloc>().roleCont,

                            isEditable: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Role is required";
                              }
                              return null;
                            },
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (bottomcontext) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children:
                                            menuItems
                                                .asMap()
                                                .entries
                                                .map(
                                                  (entry) => Column(
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                          entry.value,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              AppTextStyles
                                                                  .textFieldStyle,
                                                        ),
                                                        onTap: () {
                                                          context
                                                              .read<
                                                                EmployeeAddEditBloc
                                                              >()
                                                              .roleCont
                                                              .text = entry
                                                                  .value;

                                                          Navigator.pop(
                                                            context,
                                                          );
                                                        },
                                                      ),
                                                      if (entry.key !=
                                                          menuItems.length - 1)
                                                        Divider(
                                                          height: 1,
                                                          thickness: 1,
                                                          color:
                                                              Colors.grey[300],
                                                        ),
                                                    ],
                                                  ),
                                                )
                                                .toList(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  hintText: "Select Date",
                                  prefixImage: "assets/event.png",
                                  controller:
                                      context
                                          .read<EmployeeAddEditBloc>()
                                          .dateFromCont,
                                  isEditable: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Date is required";
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    DateTime? pickedDate =
                                        await showDialog<DateTime>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomDatePickerDialog(
                                              isDateFromPicker: true,
                                            );
                                          },
                                        );

                                    if (pickedDate != null) {
                                      context
                                          .read<EmployeeAddEditBloc>()
                                          .dateFromCont
                                          .text = "${pickedDate.toLocal()}"
                                              .split(' ')[0];
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 5),
                              Image.asset(
                                "assets/arrow_right_alt_FILL0_wght500_GRAD0_opsz24 14.png",
                                height: 30,
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: CustomTextField(
                                  hintText: "Select Date",
                                  prefixImage: "assets/event.png",
                                  controller:
                                      context
                                          .read<EmployeeAddEditBloc>()
                                          .dateToCont,
                                  isEditable: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Date is required";
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    String dateToText =
                                        context
                                            .read<EmployeeAddEditBloc>()
                                            .dateFromCont
                                            .text;

                                    if (dateToText.isNotEmpty) {
                                      try {
                                        DateTime? pickedDate =
                                            await showDialog<DateTime>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CustomDatePickerDialog(
                                                  isDateFromPicker: false,
                                                  minimumDate: DateTime.parse(
                                                    dateToText,
                                                  ), // Pass the parsed date
                                                );
                                              },
                                            );

                                        if (pickedDate != null) {
                                          context
                                              .read<EmployeeAddEditBloc>()
                                              .dateToCont
                                              .text = "${pickedDate.toLocal()}"
                                                  .split(' ')[0];
                                        }
                                      } catch (e) {
                                        print('Error parsing date: $e');
                                        // Consider showing an error message to the user (e.g., a SnackBar)
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Invalid date format. Please use dd-MM-yyyy.',
                                            ),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please select a start date first.',
                                          ),
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: SafeArea(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.grey.shade300, // Border color
                              width: 2.0, // Border width
                            ),
                          ),
                        ),
                        // color: Colors.grey,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomElevatedButton(
                                  text: 'Cancel',
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  backgroundColor: Color(0xffEDF8FF),

                                  borderRadius: 5.0,
                                ),
                                SizedBox(width: 10),

                                CustomElevatedButton(
                                  text: 'Save',
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (context
                                          .read<EmployeeAddEditBloc>()
                                          .isEditView) {
                                        context.read<EmployeeAddEditBloc>().add(
                                          EmployeeEditEvent(),
                                        );
                                      } else {
                                        context.read<EmployeeAddEditBloc>().add(
                                          EmployeeAddEvent(),
                                        );
                                      }
                                      Navigator.pop(context); // Save action
                                      BlocProvider.of<EmployeeListBloc>(
                                        context,
                                      ).add(EmployeeFetchEvent());
                                    }
                                  },

                                  backgroundColor: Color(0xff1DA1FA),
                                  textStyle: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffffffff),
                                  ),

                                  borderRadius: 5.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
