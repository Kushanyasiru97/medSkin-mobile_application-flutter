import 'dart:convert';

import 'package:http/http.dart' as http;


class requestAssistant{
  static Future<dynamic> getRequest(String url) async{
    Uri myUri = Uri.parse(url);

    http.Response response = await http.get(myUri);
    try{
      if(response.statusCode == 200){
        String jdata =  response.body;
        var decodeData = jsonDecode(jdata);
        return decodeData;
      }
      else{
        return "failed";
      }
    }
    catch(exp){
      return "failed";
    }


  }
}