import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/Model/user.dart';
import 'package:whatsapp_clone/customui/settingCard.dart';
import 'package:whatsapp_clone/pages/ProfilePhoto.dart';

class Profile extends StatefulWidget {
  const Profile({Key key,this.user}):super(key: key);
  final User user;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
    PickedFile _image;
  final picker=ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Profile"),
      ) 
      ,
      body: SingleChildScrollView(
              child: Column(
          children: [
            SizedBox(height:10),
            Center(
                child: Stack(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>ProfilePhoto(user: widget.user)));
                        },
                        child: CircleAvatar(
                        radius: 80,
                        backgroundImage:_image == null?NetworkImage('http://192.168.43.210:3000/public/${widget.user.profilePicture}'):FileImage(File(_image.path)),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 1,
                        child: InkWell(
                          onTap: (){showModalBottomSheet(context: context, builder: ((builder)=>bottomSheet()));},
                          child: CircleAvatar(
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
              SizedBox(height:5),
              settingCard(title: "Name",subtitle: widget.user.fullName,icon: Icons.person),
              //Text("This is not your username or pin. This name will be visible to your whatsapp contacts"),
              settingCard(title: "About",subtitle: "Sleeping",icon: Icons.info_outline_rounded),
              settingCard(title: "Phone",subtitle: widget.user.fullName,icon: Icons.phone,)
          ],
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
  final PickedFile=await picker.getImage(
    source: source
  );
  setState((){
    _image=PickedFile;
  });
}

}
