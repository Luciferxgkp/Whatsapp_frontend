import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/screens/Signin.dart';
import 'package:whatsapp_clone/screens/signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/cell-phone.svg',
            height: MediaQuery.of(context).size.height/5,
            width: MediaQuery.of(context).size.width/5,
            color: Colors.greenAccent[700],
          ),
          SizedBox(height: 30,),
          Text(
              "Welcome to WhatsApp",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
              ),
          SizedBox(height: 30,),
          Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                height: 50,
                width: MediaQuery.of(context).size.width-70,
                child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>Signin()));
                    },
                    child:Card(
                      color: Colors.greenAccent[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Center(child: Text(
                        "Log In",
                        style:TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ) ,
                        ),
                      ),
                  ),
                    ),
                ),
                SizedBox(height: 10,),
                Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                height: 50,
                width: MediaQuery.of(context).size.width-70,
                child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>Signup()));
                    },
                    child:Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Center(child: Text(
                        "Sign up",
                        style:TextStyle(
                          color: Colors.greenAccent[700],
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ) ,
                        ),
                      ),
                  ),
                    ),
                ),
        ],
      ),
    );
  }
}