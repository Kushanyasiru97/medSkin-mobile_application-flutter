import 'dart:convert';
import 'package:http/http.dart' as http;


class RequestAssistant{
  static Future<dynamic> getRequest(String url) async{

    Uri myUrl = Uri.parse(url);

    http.Response response = await http.get(myUrl);
    try{
      if(response.statusCode == 200){
        String jSondata =  response.body;
        var decodeData = jsonDecode(jSondata);
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