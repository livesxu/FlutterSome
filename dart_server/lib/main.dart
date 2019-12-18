import 'dart:io';

import 'package:http_server/http_server.dart';

void main() async {
  VirtualDirectory staticFiles=new VirtualDirectory('.');

  var requestServer = await HttpServer.bind(InternetAddress.loopbackIPv6, 8080);

  print('监听 localhost地址，端口号为${requestServer.port}');

  //监听请求
  await for (HttpRequest request in requestServer) {

//这个可以先不添加，下面介绍到
    writeHeaders(request);

    if(request.uri.toString()=='/'||request.uri.toString()=='/index.html'){
//当我们收到请求根目录或者请求/index.html页面时，返回我们的刚刚写好的html页面
//因为http_server这个包已经为我们处理好了，所以如果html不存在，也不会让服务器奔溃掉，而是返回未找到页面
      print("html处理");
      Directory directory=await new Directory("webApp/index.html");

      staticFiles.serveFile(new File('${directory.path}'), request);//这里是mac系统下的代码
//    staticFiles.serveFile(new File('webApp/index.html'), request);//win系统使用该代码
    }else{
//如果不是请求该页面，交回给get，post去处理
      handleMessage(request);
    }

  }
}

void handleMessage(HttpRequest request){
  try{
    if(request.method=='GET'){
      //获取到GET请求
      handleGET(request);
    }else if(request.method=='POST'){
      //获取到POST请求
      handlePOST(request);
    }else{
      //其它的请求方法暂时不支持，回复它一个状态
      request.response..statusCode=HttpStatus.methodNotAllowed
        ..write('对不起，不支持${request.method}方法的请求！')
        ..close();
    }
  }catch(e){
    print('出现了一个异常，异常为：$e');
  }
  print('请求被处理了');
}

void handleGET(HttpRequest request){
  //处理GET请求
  //获取一个参数
  var id=request.uri.queryParameters['id'];//查询id的值
  request.response
    ..statusCode=HttpStatus.ok//回复它一个ok状态，说明我收到请求啦
    ..write('当前查询的id为$id')//显示到浏览器的内容
    ..close();//我已经回复你了，所以关闭这个请求
}
void handlePOST(HttpRequest request){
  //处理POST请求
}

void writeHeaders(HttpRequest request){
  List<String> headers=[];
  request.headers.forEach((key, values) {
    String header='$key：';
    for (String value in values) {
      header +='$value , ';
    }
    headers.add(header.substring(0,header.length-2));
  });
  writeLog('${headers.join('\n')}');
  print("writeLog");
}

void writeLog(String log) async{
  var date=DateTime.now();
  var year=date.year;
  var month=date.month;
  var day=date.day;
  var hour=date.hour;
  var minute=date.minute;

  //如果recursive为true，会创建命名目录及父级目录
  Directory directory=await new Directory('log/$year-$month-$day').create(recursive: true);

  File file = new File('${directory.path}/$hour:$minute.log');
  file.exists().then((isExists){

    print("file exit");
    String logAddTime='time：${date.toIso8601String()}\n$log';
    file.writeAsString(isExists?'\n\n$logAddTime':logAddTime, mode: FileMode.append);
  });
}