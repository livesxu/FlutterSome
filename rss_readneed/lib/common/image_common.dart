import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import './error_handle.dart';

import 'dart:io' show File;

class ImageCommon {

  static Widget withUrl (String url,String placeholder,VoidCallback touchCall) {

    return InkWell(
      onTap: touchCall,
      child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: url ?? "",
          placeholder: (context, url) => (placeholder != null && placeholder.length > 0) ? Image.asset(placeholder,fit: BoxFit.fill,) : Container(),
          errorWidget: (context, url, error){

            if (url != null && url != '') {

              ReportHandle.handle('url_image_error', 1, error.toString());
            }

            if (placeholder != null && placeholder.length > 0) {

              return Image.asset(placeholder,fit: BoxFit.fill,);
            } else {
              return Container();
            }
          },
      ),
    );

  }

  static Widget withFile(File file,String placeholder,VoidCallback touchCall) {

    if (file == null) {

      return InkWell(
        onTap: touchCall,
        child: Image.asset(placeholder,fit: BoxFit.fill,)
      );
    }

    return InkWell(
      onTap: touchCall,
      child: Image.file(file,fit: BoxFit.fill,),
    );
  }
}