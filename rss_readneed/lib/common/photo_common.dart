import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:image_picker/image_picker.dart';
//import 'package:video_player/video_player.dart';

import './consts.dart';
import '../Login/Account.dart';
import 'package:dio/dio.dart';

import 'package:crypto/crypto.dart';
import 'dart:convert';

//相机相册
class Photo {

  //选择图片
  static Future<File> chooseForPhoto (BuildContext context,String identity) async {

    //展示选择器
    Widget _bottomPhotoChoose(){
      return Container(
        height: 200,
        child: Column(children: <Widget>[
          InkWell(
            child: Container(
              height: 50,
              child: Text('相册',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
            ),
            onTap: (){Navigator.of(context).pop("gallery");},
          ),
          InkWell(
            child: Container(
              height: 50,
              child: Text('相机',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
            ),
            onTap: (){Navigator.of(context).pop("camera");},
          ),
          InkWell(
            child: Text('取消',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.black38),),
            onTap: (){Navigator.of(context).pop("cancel");},
          )],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );
    }

    final option = await showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) => _bottomPhotoChoose(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20))
        )
    );

    ImageSource sourceC;
    if (option == 'camera') {
      sourceC = ImageSource.camera;
    } else if (option == 'gallery'){

      sourceC = ImageSource.gallery;
    } else {

      return null;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("last_indentity",identity);

    File file = await ImagePicker.pickImage(
        source: sourceC,
        imageQuality: 20 //降低图片质量
    );

    prefs.remove("last_indentity");

    return file;
  }

  //选择图片并上传
  static Future<String> chooseAndUploadImage(BuildContext context,String identity) async {

     File file = await chooseForPhoto(context, identity);

     if (file == null) {

       return null;
     }

     //保证唯一性 -
     FormData formData = FormData.fromMap({

       "file": await MultipartFile.fromFile(file.path,filename:Account.share.userId.toString() + md5.convert(utf8.encode(DateTime.now().toString())).toString())
     });
     var response = await Dio().post(Url_Host + "/uploadImg", data: formData);

     if (response.statusCode != 200) {

       return null;
     }

     return response.data;
  }

  static Photo _instance;
  static Photo get instance {

    if (_instance == null) {

      _instance = Photo();
      if (Platform.isAndroid) {//安卓平台可能涉及到的数据丢失

        ImagePicker.retrieveLostData().then((LostDataResponse response){
          if (response.isEmpty == false && response.file != null) {
            SharedPreferences.getInstance().then(
                    (SharedPreferences prefs) {
                  File _imageFile = response.file;
                  String identity = prefs.get('last_indentity');

                  // 上传图片 todo
                  prefs.remove("last_indentity");
                }
            );
          }
        });
      }
    }
    return _instance;
  }

  //通知
  static StreamController _noti;
  static StreamController get noti {

    if (_noti == null) {

      _noti = StreamController.broadcast();
    }

    return _noti;
  }

}
