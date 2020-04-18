import 'dart:convert';
import 'package:http/http.dart' as http;
import './consts.dart';

import 'dart:math';

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

  static Future<ResuestResult> Put(String url,dynamic body) async {

    http.Response response = await http.put(Url_Host + url,
                                            headers:{"content-type":"application/json"},
                                            body:jsonEncode(body));

    if (response.statusCode == 200) {

      return ResuestResult(success: true,msg: '',body: jsonDecode(response.body));
    } else {

      return ResuestResult(success: false,msg: response.body.toString(),body: {});
    }
  }

  static String randomUserAgent (){

    int index =  Random().nextInt(userAgents.length);

    return userAgents[index];
  }

}

const userAgents = [
  'Mozilla/5.0 (Windows NT 6.1; WOW64)AppleWebKit/535.1 (KHTML, like Gecko) Chrome/14.0.835.163 Safari/535.1',
  'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.56 Safari/535.11',
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Safari/537.36',
  'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0.1) Gecko/20100101 Firefox/4.0.1',
  'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-us) AppleWebKit/534.50 (KHTML, like Gecko) Version/5.1 Safari/534.50',
];