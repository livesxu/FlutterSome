import 'package:fish_redux/fish_redux.dart';

class imagesComState implements Cloneable<imagesComState> {

  List<String> imageUrls = [];

  imagesComState({List<String> imageUrls}) {

    this.imageUrls = imageUrls;
  }


  @override
  imagesComState clone() {
    return imagesComState()
      ..imageUrls = imageUrls;
  }
}

imagesComState initState(Map<String, dynamic> args) {
  return imagesComState();
}
