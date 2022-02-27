import 'package:flutter/material.dart';
class NavigateUsersWidget extends StatelessWidget {
  const NavigateUsersWidget({Key? key, required this.text, required this.onClickedPrevious, required this.onClickedNext}) : super(key: key);
  final String text;
  final VoidCallback onClickedPrevious;
  final VoidCallback onClickedNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 48,
          icon: const Icon(Icons.navigate_before),
          onPressed: onClickedPrevious,
        ),
        Text(text,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        IconButton(
          iconSize: 48,
          icon: const Icon(Icons.navigate_next),
          onPressed: onClickedNext,
        )
      ],
    );
  }
}
