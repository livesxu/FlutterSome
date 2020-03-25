import 'dart:convert';
import 'package:http/http.dart' as http;
const String Url_Host = 'http://localhost:8888';
//const String Url_Host = 'http://localhost:8080';//测试host

class ResuestResult {

  final bool success;
  final String msg;
  final dynamic body;

  ResuestResult({
    this.success,
    this.msg,
    this.body
  });
}

class RequestCommon {

  static Future<ResuestResult> Get(String url) async {

    http.Response response = await http.get(Url_Host + url);

    if (response.statusCode == 200) {

      return ResuestResult(success: true,msg: '',body: jsonDecode(response.body));
    } else {

      return ResuestResult(success: false,msg: response.body.toString(),body: {});
    }
  }

  static Future<ResuestResult> Post(String url,dynamic body) async {

    http.Response response = await http.post(Url_Host + url,
                                            headers:{"content-type":"application/json"},
                                            body:jsonEncode(body));

    if (response.statusCode == 200) {

      return ResuestResult(success: true,msg: '',body: jsonDecode(response.body));
    } else {

      return ResuestResult(success: false,msg: response.body.toString(),body: {});
    }
  }

}