import 'dart:convert';
import 'dart:async';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:whatsapp_clone/Model/user.dart';
import 'package:whatsapp_clone/pages/LoginScreen.dart';
import 'package:whatsapp_clone/screens/homescreen.dart';
import 'package:whatsapp_clone/screens/signup.dart';
import 'package:http/http.dart' as http;


class Signin extends StatefulWidget {
  const Signin({Key key}):super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool circular=false;
  User user=User();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var url = Uri.parse('http://192.168.43.210:3000/api/signin');

  void performlogin () async{
    String username = _usernameController.text;
    String password = _passwordController.text;
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: json.encode({'email': username,'password': password}));
    if(response.statusCode==200){
      Map value =jsonDecode(response.body);
      Map users = value['user'];
      user.token=value['token'];
      user.firstName=users['firstName'];
      user.lastName=users['lastName'];
      user.fullName=users['fullName'];
      user.email=users['email'];
      user.id=users['_id'];
      user.profilePicture=users['profilePicture'];
      setState(() {
        circular=false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>LoginScreen(user: user,)));
    }
    else if(response.statusCode==400){
      setState(() {
      _passwordController.text='';
    });
    }
    else{
      setState(() {
      _passwordController.text='';
      _usernameController.text='';
    });
    }
  }    
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
    icon: Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => Navigator.of(context).pop(),
  ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:10),
            Text('Sign In',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold
                ),
            ),
            SizedBox(height:30),
            Form(
                autovalidate: true,
                  child: Column(
                    children:[TextFormField(
                      controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: "E-mail Address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2
                        ),),
                    ),
                    style: TextStyle(
                      fontSize: 14
                    ),
                    validator: EmailValidator(errorText: "Enter a valid Email"),
                    
                ),
                SizedBox(height:20),
            TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2
                    ),
                    
                  ),
                ),
                style: TextStyle(
                  fontSize: 14
                ),
                validator:(value){
                  if(value==null || value.isEmpty){
                    return "Please Enter Some Text";
                  }else{
                    return null;
                  }
                },
            ),
                    ]
                  ),
            ),
            
            SizedBox(height:30),
            Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  height: 50,
                  width: MediaQuery.of(context).size.width-70,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          circular=true;
                        });
                        performlogin();
                      },
                      child:Card(
                        color: Colors.blue[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Center(child: circular?CircularProgressIndicator():Text(
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
            SizedBox(height: 30),
            Center(child: Text("OR")),
            SizedBox(height: 30),
            // Container(
            //     margin: EdgeInsets.symmetric(horizontal: 25),
            //     height: 50,
            //     width: MediaQuery.of(context).size.width-70,
            //     child: InkWell(
            //         onTap: () {

            //         },
            //         child:Card(
            //           color: Colors.purpleAccent,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(25)
            //           ),
            //           child: Container(
            //             margin: EdgeInsets.symmetric(horizontal: 175),
            //             child: Row(
            //                mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 Icon(Icons.mail,color: Colors.white,),
            //                 Text(
            //               "Gmail",
            //               style:TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 18,
            //                 fontWeight: FontWeight.w500
            //               ) ,
            //               ),
            //               ],
            //             ),
            //           ),
            //           ),
            //       ),
            //   ),
            //   SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  height: 50,
                  width: MediaQuery.of(context).size.width-70,
                  child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Signup()));
                      },
                      child:Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Center(child: Text(
                          "Sign Up",
                          style:TextStyle(
                            color: Colors.blue,
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
              ),
      ),
    );
}
}