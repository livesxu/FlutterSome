import 'dart:io';

import 'package:http_server/http_server.dart';

import 'package:path/path.dart';

//https://www.jianshu.com/p/b7cdf11f32f6
import 'package:logging/logging.dart';

import 'dart:mirrors';

void main() async {

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec){

    print('${rec.level}::${rec.time}::${rec.message}');
  });

  VirtualDirectory staticFiles=new VirtualDirectory('.');

  String mainPath = Platform.script.toFilePath();

  print(mainPath);

  //index.html的路径
  //dirname 取上一层路径
  String indexPath = dirname(dirname(mainPath)) + "/webApp/index.html";

  Logger.root.info(indexPath);

  var requestServer = await HttpServer.bind(InternetAddress.loopbackIPv6, 8080);

  print('监听 localhost地址，端口号为${requestServer.port}');

  //添加控制器
  ControllerManager.manager.addController(new UserController());

  //监听请求
  await for (HttpRequest request in requestServer) {

//这个可以先不添加，下面介绍到
    writeHeaders(request);

    if(request.uri.toString()=='/'||request.uri.toString()=='/index.html'){
//当我们收到请求根目录或者请求/index.html页面时，返回我们的刚刚写好的html页面
//因为http_server这个包已经为我们处理好了，所以如果html不存在，也不会让服务器奔溃掉，而是返回未找到页面
      Logger.root.info("html处理");

      staticFiles.serveFile(new File(indexPath), request);//这里是mac系统下的代码
//    staticFiles.serveFile(new File('webApp/index.html'), request);//win系统使用该代码
    }else if(request.uri.path=="/mini"){
      //当请求路径为/mini,判断为进行webScoket连接
//      WebSocket

    }else{
//如果不是请求该页面，交回给get，post去处理
//      handleMessage(request);
      ControllerManager.manager.requestServer(request);
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

class Controller {

  final String path;

  const Controller({this.path});

  @override
  String toString() =>'Controller';//这里是区别其它注解
}

//抽象类
abstract class BaseController{

}

@Controller(path: '/user')
class UserController extends BaseController{
  @Get(path: '/login')
  void login(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.ok
      ..writeln('LoginSuccess')
      ..close();
  }

  @Post(path: '/logout')
  void logout(HttpRequest request){
    request.response
      ..statusCode = HttpStatus.ok
      ..writeln('logoutSuccess')
      ..close();
  }

  @Request(path: '/delete', method: 'DELETE')
  void editUser(HttpRequest request){
    request.response
      ..statusCode = HttpStatus.ok
      ..writeln('DeleteSuccess')
      ..close();
  }
}



class Request{
  final String path;
  final String method;

  const Request({this.path,this.method});

  @override
  String toString() =>'Request';
}
class Get extends Request{
  final String path;

  const Get({this.path}) : super(path : path,method: 'GET');

  @override
  String toString() =>'Get';
}

class Post extends Request{
  final String path;

  const Post({this.path}) : super(path : path, method: 'POST');

  @override
  String toString() =>'Get';

}

class ControllerManager{
  static ControllerManager manager=new ControllerManager();

//该list用于判断Controller是否已经被添加
  List<BaseController> controllers=[];
//这是一个map，对应的是请求链接，跟对应的controller信息
  Map<String,ControllerInfo> urlToMirror=new Map();

  //添加控制器
  void addController(BaseController controller){
//判断当前是否已经添加过控制器
    if(!controllers.contains(controller)){
      controllers.add(controller);
//添加map
      urlToMirror.addAll(getRequestInfo(controller));
    }
  }

//该controllerManager处理请求的方法
  void requestServer(HttpRequest request){
    //当前请求的路径
    String path=request.uri.toString();
    //当前请求的方法
    String method=request.method;

    //判断map中是否包含该请求地址
    if(urlToMirror.containsKey(path)){
      ControllerInfo info=urlToMirror[path];
//获取到该请求，传递路径、请求方法跟请求
      info.invoke(path, method, request);
    }else{
//没有该地址返回一个404
      request.response
        ..statusCode=HttpStatus.notFound
        ..write('''{
    "code": 404,
    "msg": "链接不存在！"
}''')
        ..close();
    }
  }

  //传递一个Controller进去
  Map<String,ControllerInfo> getRequestInfo(BaseController controller) {
// 实际返回的Map
    Map<String,ControllerInfo> info=new Map();
//请求地址对应的方法
    Map<String,Symbol> urlToMethod=new Map();
// 获取Controller实例的镜子
    InstanceMirror im = reflect(controller);
//获取Controller运行时类型的镜子
    ClassMirror classMirror = im.type;
//请求的根路径
    List<String> path = [];
//该Controller的所有接收的请求地址
    List<String> urlList=[];

//获取元数据,就是获取@Controller(path: xxx)中的xxx
    classMirror.metadata.forEach((medate) {
      path.add(medate.reflectee.path);
    });

    //获取该类的所有方法
    classMirror.declarations.forEach((symbol, declarationMirror) {
      //将自身的构造方法剔除
      if (symbol.toString() != classMirror.simpleName.toString()) {
        //获取方法的元数据，就是@Get(path： path)
        declarationMirror.metadata.forEach((medate) {
          //请求的地址
          String requestPath = path.join() + medate.reflectee.path;
          //请求的类型
          String method = medate.reflectee.method;

//        print('请求地址为：$requestPath,请求方法为：$method');
          //添加到请求地址集合
          urlList.add(requestPath);
//添加到请求地址对应方法的集合
          urlToMethod.putIfAbsent('$requestPath#$method', ()=>symbol);
        }
        );
      }
    });

//实例化一个Controller信息
    ControllerInfo controllerInfo=new ControllerInfo(im, urlToMethod);

//循环添加到实际需要的Map，对应请求地址根ControllerInfo信息
    urlList.forEach((url){
      info.putIfAbsent(url, ()=>controllerInfo);
    });
//返回需要的map
    return info;
  }
}

class ControllerInfo{
//请求地址对应Controller中的方法，Symbol包含方法标识
  final Map<String,Symbol> urlToMethod;
//该参数包含通过类初始化得到的实例镜子，可以通过该参数调用方法
  final InstanceMirror instanceMirror;

//构造方法
  ControllerInfo(this.instanceMirror,this.urlToMethod);

  //调用请求方法
  void invoke(String url,String method,HttpRequest request){
    //判断是否该请求地址是对应的请求方法
    if(urlToMethod.containsKey('$url#$method')){
//调用方法
      instanceMirror.invoke(urlToMethod['$url#$method'], [request]);
    }else {
//请求方法不对，返回一个错误
      request.response
        ..statusCode=HttpStatus.methodNotAllowed
        ..write('''{
    "code": 405,
    "msg": "请求出错！"
}''')
        ..close();
    }
  }
}