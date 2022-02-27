import 'package:flutter/material.dart';
import 'package:googlesheets/api-sheets/user_sheets_api.dart';
import 'package:googlesheets/widgets/user_form_widget.dart';

import '../main.dart';
class CreateSheetPage extends StatelessWidget {
  const CreateSheetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp.title),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        child: UserFormWidget(
          onSavedUser: (user)async{
            final id = await UserSheetsApi.getRowCount() + 1 ;
            final newUser = user.copy(id: id);
            // insertUsers();
            await UserSheetsApi.insert([newUser.toJson()]);
          },
        ),
      ),
    );
  }
  // Future insertUsers()async{
  //   final users=[
  //     const User(id: 1, name: 'Muskan Gupta', email: 'muskangupta@gmail.com'),
  //     const User(id: 2, name: 'Khushi Gupta', email: 'khushigupta@gmail.com'),
  //     const User(id: 3, name: 'Umang Gupta', email: 'umanggupta@gmail.com'),
  //     const User(id: 4, name: 'Radha Gupta', email: 'radhagupta@gmail.com'),
  //     const User(id: 5, name: 'Rajeev Gupta', email: 'rajeevgupta@gmail.com'),
  //   ];
  //   final jsonUsers = users.map((user)=>user.toJson()).toList();
  //   await UserSheetsApi.insert(jsonUsers);
  // }
}
