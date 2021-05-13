import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/screens/Loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/screens/Signin.dart';
import 'package:http/http.dart' as http;
class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  PickedFile _image;
  final picker=ImagePicker();
  bool status=false;

  final _firstNameController=TextEditingController();
  final _lastNameController=TextEditingController();
  final _contactNumberController=TextEditingController();
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();

  var url = Uri.parse('http://192.168.43.210:3000/api/signup');
  void performSignup() async{
    setState(() {
      status=true;
    });
    var response = await http.post(url, headers: {"Content-Type": "application/json"},body: json.encode({
      'firstName':_firstNameController.text,
      'lastName':_lastNameController.text,
      'contactNumber':_contactNumberController.text,
      'email':_emailController.text,
      'password':_passwordController.text,
      'username':_emailController.text
      }));
      if(response.statusCode==201){
          print("1st stage complete");
          var patched=await patchImage();
          if(patched==true){
            setState(() {
              status=false;
            });
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Signin()));
          }
          else{
            setState(() {
              status=false;
            });
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>LoginScreen()));
          }
      }
      else{
        print("something went wrong");
      }
  }
  Future <bool> patchImage()async{
    var request=http.MultipartRequest('PATCH',Uri.parse('http://192.168.43.210:3000/api/signup'));
    request.files.add(await http.MultipartFile.fromPath("profilePicture", _image.path));
    request.headers.addAll({
      "Content-Type": "multipart/form-data",
    });
    var response=await request.send();
    print(response);
    print("file uploaded succcessfully");
    return true;
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
        padding: EdgeInsets.fromLTRB(10,5,10,10),
          child: SingleChildScrollView(
                      child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Create new account',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height:5),
              Center(
                child: Stack(
                    children: [
                      CircleAvatar(
                      radius: 45,
                      backgroundImage: _image == null?AssetImage("assets/bg.png"):FileImage(File(_image.path)),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 0,
                        child: InkWell(
                          onTap:(){
                            showModalBottomSheet(context: context, builder: ((builder)=>bottomSheet()));
                          },
                          child:CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue[500],
                        child: Icon(Icons.camera_alt,color: Colors.white,
                        size: 16,),
                        ),
                        ),
                      ),
                    ],
                ),
              ),
              SizedBox(height:10),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: "First Name",
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
              ),
              SizedBox(height:10),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: "Last Name",
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
              ),
              SizedBox(height:10),
              TextFormField(
                controller: _contactNumberController,
                decoration: InputDecoration(
                  labelText: "Mobile Number",
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
              ),
              SizedBox(height:10),
              TextFormField(
                controller: _emailController,
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
              ),
              SizedBox(height:10),
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
                    ),),
                ),
                style: TextStyle(
                  fontSize: 14
                ),
              ),
              SizedBox(height:10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Confirm Password",
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
                validator: (value){
                  if(_passwordController.text==value){
                    return "Password doesn't match";
                  }
                  else{
                    null;
                  }
                },
              ),
              SizedBox(height:30),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  height: 50,
                  width: MediaQuery.of(context).size.width-70,
                  child: InkWell(
                      onTap: () {
                        performSignup();
                      },
                      child:Card(
                        color: Colors.pink[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Center(child: status?CircularProgressIndicator():Text(
                          "Sign Up",
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
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  height: 50,
                  width: MediaQuery.of(context).size.width-70,
                  child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Signin()));
                      },
                      child:Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Center(child: Text(
                          "Sign In",
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
Widget  bottomSheet(){
  return Container(
    height: 100,
    margin:EdgeInsets.symmetric(horizontal:20,vertical:20),
    child: Column(
      children:[
        Text("Choose Profile Photo",
        style:TextStyle(
          fontSize: 20
        ),
        ),
        SizedBox(height:20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(onPressed:(){
              takePhoto(ImageSource.camera);
            }, icon: Icon(Icons.camera), label: Text("Camera")),
            FlatButton.icon(onPressed: (){
              takePhoto(ImageSource.gallery);
            }, icon: Icon(Icons.image), label: Text("Gallery")),
          ],
        ),
      ],
    ),
  );
}
void takePhoto(ImageSource source)async{
  final pickedfile=await picker.getImage(
    source: source
  );
  setState((){
    _image=pickedfile;
  });
}
}
