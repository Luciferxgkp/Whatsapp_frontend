import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:math';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_clone/screens/CameraView.dart';
import 'package:whatsapp_clone/screens/VideoView.dart';

List <CameraDescription> camera;

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController  _CameraController;
  Future<void> cameraValue;
  bool isRecording=false;
  bool flash=false;
  bool isCameraFront=true;
  double transform=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _CameraController =CameraController(camera[0],ResolutionPreset.high);
    cameraValue=_CameraController.initialize();
    
  }
  void dispose(){
    super.dispose();
    _CameraController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: cameraValue,
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.done){
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                    child: CameraPreview(_CameraController),
                  );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          }),
          Positioned(
            bottom: 0.0,
            child: Container(
            padding: EdgeInsets.only(top:5,bottom: 5),
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(icon: Icon(flash ? Icons.flash_on:Icons.flash_off,color: Colors.white,size:28 ,),
                    onPressed: () {
                      setState(() {
                        flash=!flash;
                        flash ? _CameraController.setFlashMode(FlashMode.torch):_CameraController.setFlashMode(FlashMode.off);
                      });
                    }),
                    GestureDetector(
                      onLongPress: () async{
                        //final path=join((await getTemporaryDirectory()).path,"${DateTime.now()}.mp4");
                        await _CameraController.startVideoRecording();
                        setState(() {
                          isRecording=true;
                        });
                    },
                      onLongPressUp: () async{
                        XFile videopath= await _CameraController.stopVideoRecording();
                        setState(() {
                          isRecording=false;
                          
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>VideoView(path: videopath.path,)));
                      },
                      onTap: () {
                        if(!isRecording){
                          takePhoto(context);
                        }
                      },
                      child: isRecording ? 
                      Icon(Icons.radio_button_on,color: Colors.red,size: 80,)
                      :
                      Icon(
                        Icons.panorama_fish_eye,
                        color: Colors.white,
                        size:70 ,
                        ),
                    ),
                    IconButton(icon: Transform.rotate(angle: transform,
                      child: Icon(
                        Icons.flip_camera_ios,
                        color: Colors.white,
                        size:28 ,
                      ),
                    ),
                    onPressed: () async{
                      setState(() {
                        isCameraFront=!isCameraFront;
                        transform=transform + pi;
                      });

                      int CameraPause=isCameraFront ? 0:1;
                      _CameraController =CameraController(
                        camera[CameraPause],ResolutionPreset.high);
                      cameraValue=_CameraController.initialize();
                    }),
                  ],
                ),
                SizedBox(
                  height:4,
                ),
                Text("Hold for Video,Tap for photo",style: TextStyle(
                  color: Colors.white,

                ),
                textAlign: TextAlign.center,
                ),
              ],
            ),
          ),),
        ],
      ),
    );
  }
  void takePhoto(BuildContext context) async{
    //final path =join((await getTemporaryDirectory()).path,"${DateTime.now()}.png");
    XFile path= await _CameraController.takePicture();
    Navigator.push(context, MaterialPageRoute(builder: (builder)=>CameraView(path: path.path,)));
  }
}
