// import 'package:flutter/material.dart';
// import 'package:todoassignment/models/employee_add_edit_args_model.dart';
// import 'package:todoassignment/route/app_routes.dart';

// class Employeelist extends StatelessWidget {
//   const Employeelist({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return   Container(
//                                                 child: ListView.builder(
//                                                   padding: EdgeInsets.all(0),
//                                                   shrinkWrap: true,
//                                                   physics:
//                                                       const NeverScrollableScrollPhysics(),
//                                                   itemCount:
//                                                       state.employeeList.length,
//                                                   itemBuilder: (
//                                                     context,
//                                                     index,
//                                                   ) {
//                                                     return state
//                                                                 .employeeList[index]
//                                                                 .to !=
//                                                             "No Date"
//                                                         ? SizedBox()
//                                                         : Container(
//                                                           // color: Colors.red,
//                                                           child: Dismissible(
//                                                             key: Key(
//                                                               state
//                                                                       .employeeList[index]
//                                                                       .role ??
//                                                                   "",
//                                                             ), // Unique key for each item
//                                                             direction:
//                                                                 DismissDirection
//                                                                     .endToStart, // Swipe from right to left
//                                                             background: Container(
//                                                               color: Colors.red,
//                                                               alignment:
//                                                                   Alignment
//                                                                       .centerRight,
//                                                               padding:
//                                                                   EdgeInsets.symmetric(
//                                                                     horizontal:
//                                                                         20,
//                                                                   ),
//                                                               child: Icon(
//                                                                 Icons.delete,
//                                                                 color:
//                                                                     Colors
//                                                                         .white,
//                                                               ),
//                                                             ),
//                                                             onDismissed: (
//                                                               direction,
//                                                             ) {
//                                                               context
//                                                                   .read<
//                                                                     EmployeeListBloc
//                                                                   >()
//                                                                   .add(
//                                                                     EmployeeDeleteEvent(
//                                                                       state
//                                                                           .employeeList[index],
//                                                                     ),
//                                                                   );

//                                                               if (context
//                                                                   .mounted) {
//                                                                 ScaffoldMessenger.of(
//                                                                   context,
//                                                                 ).showSnackBar(
//                                                                   SnackBar(
//                                                                     content: Text(
//                                                                       "Employee data has been deleted",
//                                                                     ),
//                                                                     action: SnackBarAction(
//                                                                       label:
//                                                                           "Undo",
//                                                                       onPressed: () {
//                                                                         if (context
//                                                                             .mounted) {
//                                                                           context
//                                                                               .read<
//                                                                                 EmployeeListBloc
//                                                                               >()
//                                                                               .add(
//                                                                                 EmployeeUndoEvent(
//                                                                                   state.employeeList[index],
//                                                                                 ),
//                                                                               );
//                                                                         }
//                                                                       },
//                                                                     ),
//                                                                   ),
//                                                                 );
//                                                               }
//                                                             },
//                                                             child: Container(
//                                                               // color: Colors.green,
//                                                               child: InkWell(
//                                                                 onTap: () {
//                                                                   Navigator.pushNamed(
//                                                                     context,
//                                                                     AppRoutes
//                                                                         .addEditEmployee,
//                                                                     arguments: EmployeeAddEditArgsModel(
//                                                                       isEdit:
//                                                                           true,
//                                                                       employeeModel:
//                                                                           state
//                                                                               .employeeList[index],
//                                                                     ),
//                                                                   );
//                                                                 },
//                                                                 child: Container(
//                                                                   // color: Colors.red,
//                                                                   child: Column(
//                                                                     crossAxisAlignment:
//                                                                         CrossAxisAlignment
//                                                                             .start,
//                                                                     children: [
//                                                                       Padding(
//                                                                         padding:
//                                                                             const EdgeInsets.all(
//                                                                               12.0,
//                                                                             ),
//                                                                         child: Column(
//                                                                           crossAxisAlignment:
//                                                                               CrossAxisAlignment.start,
//                                                                           children: [
//                                                                             Text(
//                                                                               state.employeeList[index].name ??
//                                                                                   "",
//                                                                               style:
//                                                                                   AppTextStyles.employeeName,
//                                                                             ),
//                                                                             Text(
//                                                                               state.employeeList[index].role ??
//                                                                                   "",
//                                                                               style:
//                                                                                   AppTextStyles.employeeRole,
//                                                                             ),
//                                                                             Row(
//                                                                               //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                                               children: [
//                                                                                 Text(
//                                                                                   "From",
//                                                                                   style:
//                                                                                       AppTextStyles.employeeDate,
//                                                                                 ),
//                                                                                 const SizedBox(
//                                                                                   width:
//                                                                                       5,
//                                                                                 ),

//                                                                                 Text(
//                                                                                   DateFormat(
//                                                                                     "dd MMM, yyyy",
//                                                                                   ).format(
//                                                                                     DateTime.parse(
//                                                                                       state.employeeList[index].from ??
//                                                                                           "",
//                                                                                     ),
//                                                                                   ),
//                                                                                   style:
//                                                                                       AppTextStyles.employeeDate,
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                           ],
//                                                                         ),
//                                                                       ),
//                                                                       Divider(
//                                                                         color:
//                                                                             Colors.grey[300],
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         );
//                                                   },
//                                                 ),
//                                               ),
                                           
//   }
// }