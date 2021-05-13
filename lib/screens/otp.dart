import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/pages/Loginscreen.dart';
class otp extends StatefulWidget {
  const otp({Key key,this.verificationId}):super(key: key);
  final verificationId;
  @override
  _otpState createState() => _otpState();
}

class _otpState extends State<otp> {
  final _otpController = TextEditingController();
  bool showloading=false;
  FirebaseAuth _auth=FirebaseAuth.instance;

   void signInwithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async{
    setState(() {
      showloading=true;
    });
    
    try {
      final authCredential =await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        showloading=false;
      });
      if(authCredential?.user != null){
         Navigator.push(context, MaterialPageRoute(builder: (builder)=>LoginScreen()));
        print("Done");
      }
    } on FirebaseAuthException catch (e) {
          setState(() {
            showloading=false;
          });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
        Center(
          child: Column(children: [
            Text("Otp"),
            TextFormField(
              controller: _otpController,
              decoration: InputDecoration(
                hintText: "Otp",
              ),
            ),
            FlatButton(onPressed: ()async{
              PhoneAuthCredential phoneAuthCredential=PhoneAuthProvider.credential(verificationId: widget.verificationId,smsCode: _otpController.text);
              signInwithPhoneAuthCredential(phoneAuthCredential);}, child:Text("Submit"))
          ],),
        ),
      )
    );
  }
}
              
