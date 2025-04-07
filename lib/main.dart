import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoassignment/feature/employee_add_edit/bloc/employee_add_edit_bloc.dart';
import 'package:todoassignment/feature/employee_list/bloc/employee_list_bloc.dart';
import 'package:todoassignment/feature/employee_list/bloc/employee_list_event.dart';

import 'package:todoassignment/route/app_pages.dart';
import 'package:todoassignment/route/app_routes.dart';
import 'package:todoassignment/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Hive.initFlutter();
  } else {
    final Directory tempDir = await getTemporaryDirectory();
    Hive.init(tempDir.path);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EmployeeListBloc()..add(EmployeeFetchEvent()),
        ),
        BlocProvider<EmployeeAddEditBloc>(
          create: (context) => EmployeeAddEditBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        onGenerateRoute: AppPages.onGenerateRoute,
        initialRoute: AppRoutes.home,
      ),
    );
  }
}
