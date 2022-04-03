
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/my_button.dart';
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey <FormState>formState=GlobalKey();
final _auth=FirebaseAuth.instance;
 late String userName;
  late String email;
  late String password;
  bool showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 3.5,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 7,
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
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'a',
                            style: TextStyle(
                              color: Color.fromRGBO(252, 165, 3, 0.8),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                            text: 'geMe',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
            Form(
              key: formState,

                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType:TextInputType.name ,
                        onChanged: (value){
                          userName=value;
                        },

                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.edit),
                          labelText: "UserName",
                          hintText: "Enter your name",
                          fillColor: Colors.green,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0),
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0),
                              borderSide: BorderSide(color: Colors.grey.shade400)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0),
                              borderSide: BorderSide(color: Colors.red, width: 2.0)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              borderSide: BorderSide(color: Colors.red, width: 2.0)),

                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType:TextInputType.emailAddress ,
                        onChanged: (value){email=value;},

                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: "Email",
                          hintText: "Enter your email",
                          fillColor: Colors.white,
                          filled: true,//for appear color grey when mouse refer to it
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0),
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0),
                              borderSide: BorderSide(color: Colors.grey.shade400)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0),
                              borderSide: BorderSide(color: Colors.red, width: 2.0)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              borderSide: BorderSide(color: Colors.red, width: 2.0)),

                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        keyboardType:TextInputType.visiblePassword,
                        obscureText: true,
                        onChanged: (value){
                          password=value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(icon:Icon(Icons.visibility),onPressed: (){},),
                          labelText: "Password",
                          hintText: "Enter your Password",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0),
                              borderSide: BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0),
                              borderSide: BorderSide(color: Colors.grey.shade400)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80.0),
                              borderSide: BorderSide(color: Colors.red, width: 2.0)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100.0),
                              borderSide: BorderSide(color: Colors.red, width: 2.0)),

                        ),
                      ),
                    ],
                  ),
                ))  ,
SizedBox(height: 40,),
                MyButton(title: "Register", function: ()async {
                  setState(() {
                    showSpinner=true;
                  });
                  try {
                    final response = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    Navigator.pushReplacementNamed(context, "/home");
                    setState(() {
                      showSpinner=false;
                    });
                  } catch (e) {print(e.toString());}
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
