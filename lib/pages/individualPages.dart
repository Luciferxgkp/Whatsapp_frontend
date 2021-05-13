import 'dart:core';
//import 'dart:html';
import 'package:emoji_picker/emoji_picker.dart';
import'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_clone/Model/ChatModel.dart';
import 'package:whatsapp_clone/Model/MessageModel.dart';
import 'package:whatsapp_clone/customui/OwnMessage.dart';
import 'package:whatsapp_clone/customui/ReplyCard.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:whatsapp_clone/pages/CameraPage.dart';
import 'package:whatsapp_clone/screens/CameraScreen.dart';

class IndividualPage extends StatefulWidget {
  IndividualPage({Key key,this.chatModel,this.sourcechat}):super(key: key);
  final ChatModel chatModel;
  final ChatModel sourcechat;
  
  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool show=false;
  FocusNode focusNode=FocusNode();
  io.Socket socket;
  bool sendButton=false;
  List<MessageModel> messages=[];
  ScrollController _scrollController=ScrollController();

  TextEditingController _controller=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        setState(() {
          show=false;
        });
      }
    });
  }

  void connect(){
    socket=io.io("https://peaceful-spire-50008.herokuapp.com/",<String,dynamic>{
      "transports":["websocket"],
      "autoConnect":false,
    });
    socket.connect();
    socket.onConnect((data) {
      print("connected");
      socket.on("message", (msg){
        print(msg);
        setMessage(msg["message"],"destination");
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration:Duration(milliseconds: 100), curve: Curves.easeOut);
      });
    });
    print(socket.connected);
    socket.emit("signin",widget.sourcechat.id);
  }

  void sendMessage(String message,int sourceId,int targetId){
    setMessage(message,"source");
    socket.emit("message",{
      "message": message,
      "sourceId":sourceId,
      "targetId":targetId,
    });
  }
  void setMessage(String message,String type){
    MessageModel messageModel=MessageModel(type: type,message: message,time: DateTime.now().toString().substring(10,16));
    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/chatBackground.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
        ),
        Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        titleSpacing: 0,
          leadingWidth: 70,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back),
              CircleAvatar(
                child: SvgPicture.asset(
                  widget.chatModel.isGroup ? "assets/groups.svg" : "assets/person.svg",
                  color:Colors.white,
                  height: 37,
                  width: 37,
                ), 
                radius: 20,
                backgroundColor: Colors.blueGrey,
              ),
            ],
          ),
          ),
          title: InkWell(
            onTap: () {},
            child:Container(
            margin: EdgeInsets.all(6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.chatModel.name,style: TextStyle(
                  fontSize:18,
                  fontWeight: FontWeight.bold,
                ),),
                Text("last seen at 12:05",style: TextStyle(
                  fontSize: 13
                ),)
              ],
            ),
          ),
          ),
          actions: [
            IconButton(icon: Icon(Icons.videocam), onPressed:() {} ),
            IconButton(icon: Icon(Icons.call), onPressed:() {} ),
            PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext contesxt){
                return [
                  PopupMenuItem(
                    child:Text('View contact'),
                    value:"View Contacts"
                  ),
                  PopupMenuItem(
                    child:Text('Media,links, and docs'),
                    value:"Media,links,and docs"
                  ),
                  PopupMenuItem(
                    child:Text('Search'),
                    value:"Search"
                  ),
                  PopupMenuItem(
                    child:Text('Mute notifications'),
                    value:"Mute notifications"
                  ),
                  PopupMenuItem(
                    child:Text('Wallpaper'),
                    value:"Wallpaper"
                  ),
                  PopupMenuItem(
                    child:Text('More'),
                    value:"More"
                  ),
            ];
          })
          ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        child: WillPopScope(
          child:Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length+1,
                itemBuilder: (context,index){
                  if(index==messages.length){
                    return Container(
                      height: 70,
                    );
                  }
                  if(messages[index].type=="source"){
                    return OwnMessage(message: messages[index].message,time:messages[index].time);
                  }
                  else{
                    return ReplyCard(message: messages[index].message,time:messages[index].time);
                  }
                },
            ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                
                child: Column(
                
                mainAxisAlignment:MainAxisAlignment.end ,
                children: [
                  Row(
              children: [
                Container(
                  width:MediaQuery.of(context).size.width-60,
                  child:Card(
                    margin: EdgeInsets.only(left:2,right: 2,bottom: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    child:TextFormField(
                      controller:_controller,
                      focusNode: focusNode,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.multiline,
                      maxLines: 6,
                      minLines: 1,
                      onChanged: (value){
                        if(value.length>0){
                          setState(() {
                            sendButton=true;
                          });
                        }
                        else{
                          setState(() {
                            sendButton=false;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type a message",
                        prefixIcon: IconButton(
                          icon:Icon( Icons.emoji_emotions),
                          onPressed: () {
                            focusNode.unfocus();
                            focusNode.canRequestFocus=false;
                            setState(() {
                              show=!show;
                            });
                          },
                          ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(icon: Icon(Icons.attach_file),
                             onPressed: () {
                               showModalBottomSheet(
                               backgroundColor: Colors.transparent,
                               context: context,
                               builder: (builder)=>
                               bottomsheet()
                               );
                             },
                             ),
                            IconButton(icon: Icon(Icons.camera_alt), onPressed: (){
                               Navigator.push(context, MaterialPageRoute(builder: (builder)=>CameraScreen()));
                              },
                              ),
                          ], 
                        ),
                        contentPadding:EdgeInsets.all(5),
                      ),
                    )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom:8,
                    right: 5,
                    left: 2,
                    ),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xFF128C7E),
                    child: IconButton(
                      icon: Icon(
                        sendButton ?Icons.send : Icons.mic,
                      color: Colors.white,),
                      onPressed: () {
                        if(sendButton){
                          _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration:Duration(milliseconds: 100), curve: Curves.easeOut);
                          sendMessage(_controller.text, widget.sourcechat.id, widget.chatModel.id);
                          _controller.clear();
                          setState(() {
                            sendButton=false;
                          });
                        }
                      }
                    ),
                  ),
                ),
              ],
            ),
            show?emojiSelect():Container(),
                ],
              ),
              ),
            ),
          ],
        ),
         onWillPop: (){
           if(show){
             setState(() {
               show=false;

             });
           }
           else{
             Navigator.pop(context);
           }
           return Future.value(false);
         },
          )
      ),
    ),
      ],
    ); 
  }
  Widget bottomsheet(){
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding:EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconcreation(Icons.insert_drive_file,Colors.indigo,"Document"),
                SizedBox(width: 40,),
                InkWell(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (builder)=>CameraScreen()));
                },child: iconcreation(Icons.camera_alt,Colors.pink,"Camera",)),
                SizedBox(width: 40,),
                iconcreation(Icons.insert_photo,Colors.purple,"Gallery"),
                SizedBox(width: 40,),
              ],
            ),
            SizedBox(
              height:30
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconcreation(Icons.headset,Colors.orange,"Audio"),
                SizedBox(width: 40,),
                iconcreation(Icons.location_pin,Colors.teal,"Location"),
                SizedBox(width: 40,),
                iconcreation(Icons.person,Colors.blue,"Contact"),
                SizedBox(width: 40,),
              ],
            ),
          ],
        ),)
      ),
    );
  }
  Widget iconcreation(IconData icon,Color color,String text){
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color,
          child: Icon(
            icon,
            color:Colors.white,
            size: 29,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(text,style: TextStyle(
          fontSize: 12,
        ),),
      ],
    );
  }

  Widget emojiSelect(){
    return SingleChildScrollView(
      child: EmojiPicker(
      rows: 4,
      columns:7,
      onEmojiSelected: (emoji,category) {
        setState(() {
          _controller.text=_controller.text+emoji.emoji;
          sendButton=true;
        });
    }),
    );
  }
}