import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:roof_top_demo/common_file/helpers.dart';

class HttpService {
  static Future<http.Response?> getApi(
      {required String url, Map<String, String>? header}) async {
    try {
      debugPrint("Url = $url");
      debugPrint("Header = $header");
      return await http.get(Uri.parse(url), headers: header);
    } catch (e) {
      debugPrint(e.toString());
      showCatchMsg(e.toString());
      return null;
    }
  }

  static Future<http.Response?> postApi(
      {required String url,
      Map<String, String>? header,
      Map<String, dynamic>? body}) async {
    try {
      debugPrint("Url = $url");
      debugPrint("Header = $header");
      debugPrint("Body = $body");
      return await http.post(
        Uri.parse(url),
        headers: header,
        body: body,
      );
    } catch (e) {
      debugPrint(e.toString());
      toastMsg(e.toString());
      return null;
    }
  }
}
