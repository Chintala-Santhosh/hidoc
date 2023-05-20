import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/app_log.dart';
import '../models/home_page_response.dart';

class HomeRepository {
  const HomeRepository();

  Future<HomePageResponse> getHomePageDetails(String sId, String uuId, String userId) async {
    http.Response response = await http.post(Uri.parse("http://devapi.hidoc.co:8080/HidocWebApp/api/getArticlesByUid?"));
    print("statusCode::${response.statusCode}");
    if (response.statusCode == 200){
      AppLog.d("Response::${response.body.toString()}");
      var result = jsonDecode(response.body);
      // return result;
      return HomePageResponse.fromJson(result);
    }else{
      throw Exception(response.reasonPhrase);
    }
  }

}