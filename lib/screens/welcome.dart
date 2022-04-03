import 'package:flutter/material.dart';
import 'package:messages/screens/login.dart';
import 'package:messages/widgets/my_button.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2.2,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 6,
              child: Image.asset(
                "images/me.jpg",
              ),
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Mess',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  /*defining default style is optional */
                  children: <TextSpan>[
                    TextSpan(
                        text: 'a',
                        style: TextStyle(
                          color: Color.fromRGBO(252, 165, 3, 0.8),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        )),
                    TextSpan(
                        text: 'geMe',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            MyButton(title: "Login", function:(){
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
              Navigator.pushReplacementNamed(context, '/login');
            }),

            MyButton(title: "Register", function: (){
              Navigator.pushReplacementNamed(context, '/register');
            }),

          ],
        ),
      ),
    );
  }

}
