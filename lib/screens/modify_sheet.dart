import 'package:flutter/material.dart';
import 'package:googlesheets/api-sheets/user_sheets_api.dart';
import 'package:googlesheets/main.dart';
import 'package:googlesheets/models/user.dart';
import 'package:googlesheets/widgets/button_widget.dart';
import 'package:googlesheets/widgets/navigate_users_widget.dart';
import 'package:googlesheets/widgets/user_form_widget.dart';
class ModifySheetPage extends StatefulWidget {
  const ModifySheetPage({Key? key}) : super(key: key);

  @override
  _ModifySheetPageState createState() => _ModifySheetPageState();
}

class _ModifySheetPageState extends State<ModifySheetPage> {
  List<User> users = [];
  int index = 0;
  
  @override
  void initState() {
    super.initState();

    getUsers();
  }
  Future getUsers({int index = 0}) async{
    final users = await UserSheetsApi.getAll();
    setState(() {
      this.users = users;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp.title),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(15),
          children: [
            UserFormWidget(
              user: users.isEmpty ? null : users[index],
                onSavedUser: (user)async{
                await UserSheetsApi.update(user.id!, user.toJson());
                //   UserSheetsApi.updateCell(id: 4, key: 'name', value: 'adadadad');
                }
                ),
            const SizedBox(height: 15,),
            if(users.isNotEmpty) buildUserControls(),
          ],
        ),
      ),
    );
  }
  Widget buildUserControls()=> Column(
    children: [
      ButtonWidget(text: 'Delete', onClicked: deleteUser),
      const SizedBox(),
      NavigateUsersWidget(
        text: '${index + 1}/${users.length} Users',
        onClickedNext: (){
          final nextIndex = index >= users.length - 1 ? 0 : index + 1;
          setState(() {
            index = nextIndex;
          });
        },
        onClickedPrevious: (){
          final previousIndex = index <=0 ? users.length -1 : index -1;
          setState(() {
            index = previousIndex;
          });
        }
      ),
    ],
  );
  Future deleteUser() async{
    final user = users[index];
    await UserSheetsApi.deleteById(user.id!);

    //Just for updating UI
    final newIndex = index> 0 ? index - 1 : 0;
    await getUsers(index: newIndex);
  }
}
