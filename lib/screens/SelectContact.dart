import'package:flutter/material.dart';
import 'package:whatsapp_clone/Model/ChatModel.dart';
import 'package:whatsapp_clone/customui/ButtonCard.dart';
import 'package:whatsapp_clone/customui/ContactCard.dart';
import 'package:whatsapp_clone/screens/CreateGroup.dart';

class SelectContact extends StatefulWidget {
  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  @override
  Widget build(BuildContext context) {
    List<ChatModel> contacts=[
      ChatModel(
        name: "Prajapati",
        status: "A full stack developer",
        select: false
      ),
      ChatModel(
        name: "Chanda",
        status: "A full stack developer"
        ,
        select: false
      ),
      ChatModel(
        name: "Rani",
        status: "A full stack developer",
        select: false
      ),
      ChatModel(
        name: "Lucifer",
        status: "A full stack developer",
        select: false
      ),
      ChatModel(
        name: "Gourav",
        status: "A flutter developer",
        select: false
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Contact",style: 
            TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold
            ),),
            Text("256 Contacts",style: 
            TextStyle(
              fontSize: 13,
            ),),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.search,size: 26,), onPressed: () {}),
          PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context){
                return [
                  PopupMenuItem(
                    child:Text('Invite a friend'),
                    value:"Invite a friend"
                  ),
                  PopupMenuItem(
                    child:Text('Contacts'),
                    value:"Contacts"
                  ),
                  PopupMenuItem(
                    child:Text('Refresh'),
                    value:"Refresh"
                  ),
                  PopupMenuItem(
                    child:Text('Help'),
                    value:"Help"
                  ),
            ];
          }),
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length+2,
        itemBuilder: (context,index){
          if(index==0){
            return  InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>CreateGroup()));
              },
              child: Padding(padding:EdgeInsets.only(top: 5,bottom: 5) ,
                child:  ButtonCard(
                  icon:Icons.group,name:"New group"),
              ),
            );
          }else if(index==1){
            return InkWell(
              onTap: () {},
              child:Padding(padding: EdgeInsets.only(bottom:5,top:5),
              child:ButtonCard(icon:Icons.person_add,name:"New contact"),)
            );
          }
          return ContactCard(contact: contacts[index-2]);
        }
      ),
    );
  }
}