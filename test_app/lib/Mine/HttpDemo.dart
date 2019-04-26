import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HttpDemoState();
  }
}

class HttpDemoState extends State<HttpDemo> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("HttpDemo"),
      ),
      body: HttpDemoExample(),
    );
  }
}

class HttpDemoExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HttpDemoExampleState();
  }
}

//https://resources.ninghao.net/demo/posts.json
class HttpDemoExampleState extends State<HttpDemoExample> {


  @override
  void initState() {
    super.initState();

//    loadDatas();
  }

  Future<List<Post>> loadDatas() async {
    final response =
        await http.get("https://resources.ninghao.net/demo/posts.json");
    //response.statusCode //接口状态码

    final posts = json.decode(response.body);

//    print(posts is Map);

    final List postsBody = posts["posts"];

    final List<Post> postInfos = postsBody.map((item) => Post.fromJson(item)).toList();
    
//    Post first = postInfos[0];
//    print(json.encode(first));//encode会自动执行Post 里面的toJson

    return postInfos;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: loadDatas(),
        builder: (BuildContext context,snapshot){
//          snapshot.connectionState
//          enum ConnectionState {
//          /// Not currently connected to any asynchronous computation.
//          ///
//          /// For example, a [FutureBuilder] whose [FutureBuilder.future] is null.
//          none,
//
//          /// Connected to an asynchronous computation and awaiting interaction.
//          waiting,
//
//          /// Connected to an active asynchronous computation.
//          ///
//          /// For example, a [Stream] that has returned at least one value, but is not
//          /// yet done.
//          active,
//
//          /// Connected to a terminated asynchronous computation.
//          done,
//          }
          if (snapshot.connectionState == ConnectionState.waiting) return Container(child: Text("Loading..."),);

          List<Post> postInfos = snapshot.data;

          return ListView(children: postInfos.map(
                  (post) => Container(
                    padding: EdgeInsets.all(8),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          AspectRatio(aspectRatio: 16/9,child: ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(4),topRight: Radius.circular(4)),
                            child: Image.network(post.imageUrl,fit: BoxFit.cover,),
                          ),),
                          ListTile(
                            leading: CircleAvatar(backgroundImage: NetworkImage(post.imageUrl),),
                            title: Text(post.title),
                            subtitle: Text(post.author),

                          ),
                        ],
                      ),
                    )
                  )
          ).toList(),);
        }
       );
  }
}

class Post {
  final int id;
  final String title;
  final String author;
  final String description;
  final String imageUrl;

  Post({
    this.id,
    this.title,
    this.author,
    this.description,
    this.imageUrl,
  });

  //实例对象属性赋值
  Post.fromJson(Map json)
      : id = json["id"],
        title = json["title"],
        author = json["author"],
        description = json["description"],
        imageUrl = json["imageUrl"];


  Map toJson() => {
    "id":id,
    "title":title,
    "author":author,
    "description":description,
    "imageUrl":imageUrl,
  };
}
