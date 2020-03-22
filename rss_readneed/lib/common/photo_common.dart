import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:image_picker/image_picker.dart';
//import 'package:video_player/video_player.dart';

enum PhotoSource {
  camera,
  gallery,
}

class Photo {

  static void choose(PhotoSource source,String identity) async {

    ImageSource sourceC;
    if (source == PhotoSource.camera) {
      sourceC = ImageSource.camera;
    } else if (source == PhotoSource.gallery){

      sourceC = ImageSource.gallery;
    } else {
      Photo.noti.sink.add({identity:null});
      return ;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(prefs.get('last_indentity'));

    prefs.setString("last_indentity",identity);

    String _pickImageError;
    try {

      File _imageFile = await ImagePicker.pickImage(
          source: sourceC
      );
      Photo.noti.sink.add({identity:_imageFile});
      prefs.remove("last_indentity");
    } catch (e) {
      _pickImageError = e.toString();
      Photo.noti.sink.add({identity:_pickImageError});
      prefs.remove("last_indentity");
    }
  }

  static Photo _instance;
  static Photo get instance {

    if (_instance == null) {

      _instance = Photo();

      ImagePicker.retrieveLostData().then((LostDataResponse response){
        if (response.isEmpty == false && response.file != null) {
          SharedPreferences.getInstance().then(
              (SharedPreferences prefs) {
                   File _imageFile = response.file;
                   String identity = prefs.get('last_indentity');
                   Photo.noti.sink.add({identity:_imageFile});
                   prefs.remove("last_indentity");
              }
          );
        }
      });
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
