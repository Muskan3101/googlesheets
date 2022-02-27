import 'package:flutter/material.dart';
import 'package:googlesheets/api-sheets/user_sheets_api.dart';
import 'package:googlesheets/screens/modify_sheet.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String title = 'Google Sheets API';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const ModifySheetPage(),
    );
  }
}
