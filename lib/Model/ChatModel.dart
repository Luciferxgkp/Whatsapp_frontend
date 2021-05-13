class ChatModel {
  String name;
  String icon;
  bool isGroup;
  String time;
  String status;
  bool select=false;
  String currentMessage;
  int id;
  ChatModel({
    this.name,this.id,this.select,this.icon,this.status,this.isGroup,this.time,this.currentMessage
  });
}