import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:whatsapp_clone/pages/LoginScreen.dart';
import 'package:whatsapp_clone/pages/profile.dart';
import 'package:whatsapp_clone/screens/otp.dart';
//import 'package:whatsapp_clone/screens/Loginscreen.dart';
class Number extends StatefulWidget {
  @override
  _NumberState createState() => _NumberState();
}

class _NumberState extends State<Number> {
  final GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey();
  final _Controller = TextEditingController();
  String verificationId;
  bool showloading=false;
  FirebaseAuth _auth=FirebaseAuth.instance;
  // void otp(){

  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: showloading?Center(child: CircularProgressIndicator(),):SafeArea(
        child: Center(
          child:Column(
            children: [
              TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _Controller,
                    decoration: InputDecoration(
                      hintText: "Number"
                    ),
                  ),
                  FlatButton(onPressed: ()async{
                setState(() {
              showloading=true;
            });
        await _auth.verifyPhoneNumber(
          phoneNumber: _Controller.text,
          verificationCompleted: (PhoneAuthCredential)async{
            setState(() {
              showloading=false;
            });
          },
          verificationFailed: (verificationFailed)async{
            setState(() {
              showloading=false;
            });
            _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text(verificationFailed.message)));
          },
          codeSent: (verificationId,resendingToken)async{
            setState(() {
              showloading=false;
              this.verificationId=verificationId;
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>otp(verificationId: verificationId)));
            });
          },
          codeAutoRetrievalTimeout: (verificatonId)async{

          }
          );
              }, child:Text("Next"))
            ],
          ),),
      )
    );
  }
}
// class Initializer extends StatefulWidget {
  
//   @override
//   _InitializerState createState() => _InitializerState();
// }

// class _InitializerState extends State<Initializer> {
//   FirebaseAuth _auth;
//   User user;

//   bool isloading=true;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _auth=FirebaseAuth.instance;
//     user=_auth.currentUser;
//     isloading=false;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: CircularProgressIndicator(),),

//     ):user==null??LoginScreen():Profile();
//   }
// }
