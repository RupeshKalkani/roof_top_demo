import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:roof_top_demo/common_file/helpers.dart';
import 'package:roof_top_demo/service/pref_service.dart';
import 'package:roof_top_demo/utils/pref_keys.dart';
import 'package:http/http.dart' as http;

String getRoomId(String? uid1, String? uid2) {
  if (uid1 == null || uid2 == null) {
    return "";
  }
  if (uid1.hashCode > uid2.hashCode) {
    return "${uid2}_$uid1";
  } else {
    return "${uid1}_$uid2";
  }
}


Future<Uint8List?> getByteFromNetworkImg(String url) async {
  try{
    http.Response response = await http.get(
      Uri.parse(url),
    );
    return response.bodyBytes;
  }catch(e){
    showErrorMsg(e.toString());
  }
  return null;
}

Future<File?> getFileFromUint8List(Uint8List data) async {
  try{
    final Directory tempDir = await getTemporaryDirectory();

    final file = await File('${tempDir.path}/${DateTime.now().microsecondsSinceEpoch}.jpg').create();
    file.writeAsBytesSync(data);

    return file;
  }catch(e){
    showErrorMsg(e.toString());
  }
  return null;
}