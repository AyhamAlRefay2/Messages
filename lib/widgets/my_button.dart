import 'package:flutter/material.dart';

import '../screens/login.dart';
class MyButton extends StatelessWidget {
  final title;
  final Function function;
  MyButton({Key? key,required  this.title,required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(left: 20,right: 20,bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Colors.black,
            Colors.grey.shade700,
          ],
          tileMode: TileMode.clamp,
        ),
      ),
      child: MaterialButton(
        onPressed:()=>function(),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(250, 185, 3, 0.9),
          ),
        ),
      ),
    );
  }
}

