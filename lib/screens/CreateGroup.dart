import'package:flutter/material.dart';
import 'package:whatsapp_clone/Model/ChatModel.dart';
import 'package:whatsapp_clone/customui/AvatarCard.dart';
import 'package:whatsapp_clone/customui/ButtonCard.dart';
import 'package:whatsapp_clone/customui/ContactCard.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
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

    List<ChatModel> groups=[];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("New Group",style: 
            TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold
            ),),
            Text("Add participants",style: 
            TextStyle(
              fontSize: 13,
            ),),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.search,size: 26,), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height:100,
            color: Colors.white,
          ),
          ListView.builder(
            itemCount: contacts.length+1,
            itemBuilder: (context,index){
              if(index==0){
                return Container(
                  height: groups.length>0?90:10,
                );
              }
              return InkWell(
                onTap: () {
                  if(contacts[index-1].select==false){
                    setState(() {
                      contacts[index-1].select=true;
                      groups.add(contacts[index-1]);
                    });
                  }
                  else{
                    setState(() {
                      contacts[index-1].select=false;
                      groups.remove(contacts[index-1]);
                    });
                  }
                },
                child: ContactCard(contact: contacts[index-1],),
              );
            }
          ),
          groups.length>0
          ? Column(
            children: [
              Container(
                height: 75,
                color: Colors.white,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: contacts.length,
                    itemBuilder: (context,index){
                      if(contacts[index].select==true){
                        return InkWell(
                          onTap: () {
                            setState(() {
                              groups.remove(contacts[index]);
                              contacts[index].select=false;
                            });
                          },
                          child: AvatarCard(
                          contact: contacts[index],                          
                        ),
                        );
                      }else{
                        return Container();
                      }
                    },
                  ),
              ),
              Divider(
                thickness: 1,
              ),
            ],
          ): Container(),
        ],
      ),
    );
  }
}