import 'package:flutter/material.dart';
class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, required this.text, required this.onClicked}) : super(key: key);
  final String text;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50),
      shape: const StadiumBorder()
    ),
      child: FittedBox(
        child: Text(text,style: const TextStyle(fontSize: 20,color: Colors.white),),
      ),
      onPressed: onClicked,
    );
  }
}
