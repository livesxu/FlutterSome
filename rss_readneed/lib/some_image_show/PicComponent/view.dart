import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import '../image_list/page.dart' as image_list;

Widget buildView(Map<String,dynamic> state, Dispatch dispatch, ViewService viewService) {

  return Container(
      padding: EdgeInsets.only(left: 8,top: 8,right: 8),
      child: InkWell(
        child: Card(
          child: Stack(
            children: <Widget>[
              ClipRRect(borderRadius: BorderRadius.all(Radius.circular(4)),child: Image.network(state["url"]),),
              Positioned(
                  left: 4,
                  top: 4,
                  child: Row(
                    children: <Widget>[
                      Text(state["addtime"] ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Icon(Icons.arrow_forward,color:Colors.white,)
                    ],
                  )
              ),

            ],
          ),
          elevation: 4,
        ),
        onTap: (){
//          dispatch(some_image_showActionCreator.jumpListAction(info["id"]));
          Navigator.push(viewService.context, MaterialPageRoute(builder: (_) => image_list.image_listPage().buildPage({"id":state["id"]})));
        },
      )
  );
}
