import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/Loginscreen.dart';
import 'package:whatsapp_clone/screens/Number.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
          children:[
            SizedBox(height:80),
            Text(
              "Welcome to WhatsApp",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/8,
              ),
              Image.asset(
                "assets/bg.png",
                color: Colors.greenAccent[700],
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width/2,
                ),
                SizedBox(
                height: MediaQuery.of(context).size.height/9,
              ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal:20 ),
                child: RichText(
                  textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14
                  ),
                  children: [
                    TextSpan(
                      text: "Read our Privacy Policy. Tap 'Agree and continue' to accept the ",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    TextSpan(
                      text: " Terms of Services ",
                      style: TextStyle(
                        color: Colors.cyan
                      ),
                    ),
                  ]
                ),), 
              ),
              SizedBox(height:20),
              InkWell(
                onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (builder)=>LoginScreen()));
                },
                child: Container(
                width: MediaQuery.of(context).size.width-160,
                height:40,
                child: Card(
                  margin: EdgeInsets.all(0),
                  elevation: 8,
                  color: Colors.greenAccent[700],
                  child: Center(
                  child:
                    Text("AGREE AND CONTINUE",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12
                      ),
                    ),
                ),
                ),
              ),
              ),
              SizedBox(height:MediaQuery.of(context).size.height/12),
              Text("from"),
              Text("GOURAV",style: TextStyle(
                fontSize: 16
              ),),
          ],
        ),
        ),
      ),
      
    );
  }
}