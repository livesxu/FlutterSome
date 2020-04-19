import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import '../../../public.dart';

Widget buildView(ArticleModel model, Dispatch dispatch, ViewService viewService) {

  return InkWell(
    child: Card(
        child:Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(4),topRight: Radius.circular(4)),
              child: (model.articleImage != null) ? ImageCommon.withUrl(model.articleImage, null, null) : Container(),
            ),
            Container(
              padding: EdgeInsets.all(4),
              width: double.infinity,
              child: Text(
                model.articleTitle,
                softWrap: false,//是否自动换行 false文字不考虑容器大小  单行显示   超出；屏幕部分将默认截断处理
                overflow: TextOverflow.ellipsis,//文字超出屏幕之后的处理方式  TextOverflow.clip剪裁   TextOverflow.fade 渐隐  TextOverflow.ellipsis省略号
                maxLines: 2, //最大行数
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              padding: EdgeInsets.all(2),
              width: double.infinity,
              child: Text(
                model.articleContent,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 10
                ),
              ),
            ),
          ],
        )
    ),
    onTap: (){

      if (model.articleUrl == null || model.articleUrl.length <= 0) {

        return ;
      }
      AppNavigator.push(viewService.context, CommonWebView(urlString: model.articleUrl,urlTitle: model.articleTitle,articleModel:model,));
    },
  );
}
