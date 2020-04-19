import 'package:flutter/material.dart';

import '../public.dart';
import '../rss_channel/rss_web.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../rss_add/page.dart';

class Collect extends StatefulWidget {
  @override
  CollectState createState() => new CollectState();
}

class CollectState extends State<Collect> {

  //瀑布流展示 - 大小不一
  //不要设置图片比例!!!
  Widget _staggered () {

    return Container(
      padding: EdgeInsets.all(4),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemBuilder: ((_,int index){

          ArticleModel model = CollectCommon.articles[index];

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
              AppNavigator.push(context, CommonWebView(urlString: model.articleUrl,urlTitle: model.articleTitle,articleModel:model,));
            },
          );
        }),
        itemCount: CollectCommon.articles.length,
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppbarCommon(ctx: context,titleString: 'ReadNeed',actions: <Widget>[
        IconButton(icon: Icon(Icons.create), onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => rss_addPage().buildPage({})))
              .then((_){
          });
        })
      ],),
      body: _staggered(),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(Collect oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}