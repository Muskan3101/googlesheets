import 'package:flutter/material.dart';
import 'package:googlesheets/models/user.dart';
import 'package:googlesheets/widgets/button_widget.dart';
class UserFormWidget extends StatefulWidget {
  const UserFormWidget({Key? key, required this.onSavedUser, this.user}) : super(key: key);
  final ValueChanged<User> onSavedUser;
  final User? user;

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {

  //to access the data of test field we use the controllers
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    initUser();
  }
  @override
  void didUpdateWidget(covariant UserFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    initUser();
  }
  void initUser(){
    final name = widget.user == null ? '' : widget.user!.name;
    final email = widget.user == null ? '' : widget.user!.email;
    setState(() {
      nameController = TextEditingController(text: name);
      emailController = TextEditingController(text: email);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildName(),
          const SizedBox(height: 15,),
          buildEmail(),
          const SizedBox(height: 15,),
          buildSubmit(),
        ],
      ),
    );
  }
  Widget buildName(){
    return TextFormField(
      controller: nameController,
      validator: (value){
        value !=null && value.isEmpty ? 'Enter Name' : null;
      },
      decoration: const InputDecoration(
        labelText: 'Name',
            border: OutlineInputBorder()
      ),
    );
  }
  Widget buildEmail(){
    return TextFormField(
      controller: emailController,
      validator: (value){
        value != null && !value.contains('@') ? 'Enter Email' : null;
      },
      decoration: const InputDecoration(
        labelText: 'Email',
            border: OutlineInputBorder()
      ),
    );
  }
  Widget buildSubmit(){
    return ButtonWidget(text: 'Save', onClicked: (){
      final form = formKey.currentState!;
      final isValid = form.validate();

      if(isValid){
        final id = widget.user == null ? null : widget.user!.id;
        final user = User(
          id: id,
          name: nameController.text,
          email: emailController.text
        );
        widget.onSavedUser(user);
      }
    });
  }
}
