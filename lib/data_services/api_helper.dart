import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mvvmbasic/data_services/response_handler.dart';
import 'api_type_enum.dart';

class ApiHelper {
  downloadFile(String baseUrl, String path, Map<String, dynamic> params) async {
    final uri = Uri.https(baseUrl, path, params);
    var header = {
      "Authorization": "Bearer {loginData?.token}",
    };
    print(uri);
    final response = await http.get(uri, headers: header);
    if (response.statusCode == 200) {

      return {"data":response.bodyBytes,"status":true};
    } else {
      return response.body;
    }
  }

  Future<dynamic> multiMethod(String baseurl, String path,
      {Map<String, dynamic>? body,
        Map<String, String>? params,
        Map<String, String>? headers,
        int type = 1,
        ApiTypeEnum methodType = ApiTypeEnum.post,
        bool isRefresh = false}) async {
    dynamic responseJson;
    Map<String, String> baseheader = {};
    Map<String, String> finalparams = {};
    if (params != null) {
      finalparams.addAll(params);
    }
    final uri = Uri.https(baseurl, path, finalparams);
    if (headers != null) {
      baseheader.addAll(headers);
    }
    if (type == 2) {
      baseheader.addAll({
        "Authorization": "Bearer {loginData?.token}",
      });
    }
    baseheader.addAll({'content-type': 'application/json'});

    try {
      final response = await buildBase(
        uri,
        body: jsonEncode(body),
        headers: baseheader,
        type: methodType,
      );
      responseJson = responseHandler(response);
    } on SocketException {
      throw const SocketException('No Internet connection');
    } catch (e) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> multiPart(
      String baseurl,
      String path, {
        Map<String, dynamic>? body,
        Map<String, String>? params,
        Map<String, String>? headers,
        List<Map<String, dynamic>>? files,
        List<dynamic>? fileLists,
        String? key,
        int type = 2,
        ApiTypeEnum methodType = ApiTypeEnum.post,
      }) async {
    dynamic responseJson;
    Map<String, String> baseHeader = {};
    final uri = Uri.https(baseurl, path);
    var request = http.MultipartRequest(methodType.name, uri);
    print(uri);
    if (type == 2) {
      baseHeader.addAll({
        "Authorization": "Bearer {loginData?.token}",
      });
    }

    if (headers != null) {
      baseHeader.addAll(headers);
    }
    if (body != null) {
      loadFromMap(
        body,
        request,
      );
      print("meeee1: \n $body");
      print("meeee: \n ${request.fields}");

      // return;
      // body.forEach((key, value) {
      //   print(body[key].runtimeType);
      //   if (body[key].runtimeType == List<Map<String, dynamic>>) {
      //     var list = body[key] as List<dynamic>;
      //     var i = 0;
      //     for (var e in list) {
      //       var filedName = "$key[$i]";
      //       print(filedName);
      //       request.fields[filedName] = jsonEncode(e);
      //       i++;
      //     }
      //   } else if (body[key].runtimeType == List<dynamic>) {
      //     var list = body[key] as List<dynamic>;
      //     var i = 0;
      //     for (var e in list) {
      //       var filedName = "$key[$i]";
      //       print(filedName);
      //       request.fields[filedName] = jsonEncode(e);
      //       i++;
      //     }
      //   } else {
      //     request.fields[key] = value.toString();
      //   }
      // });
    }

    /// list or single by use multiple keyword
    if (files != null) {
      files.forEach(
            (singleFile) async {
          singleFile.forEach(
                (key, value) async {
              List mapNew = singleFile[key];
              mapNew.forEach(
                    (element) async {
                  try {
                    request.files
                        .add(await http.MultipartFile.fromPath(key, element));
                  } catch (e) {
                    if (kDebugMode) {
                      print(e);
                    }
                  }
                },
              );
            },
          );
        },
      );
    }

    ///List of files with same key word
    if (fileLists != null && key != null) {
      print("file[path]");
      for (int i = 0; i < fileLists.length; i++) {
        print("file[paths]");
        try {
          request.files
              .add(await http.MultipartFile.fromPath(key, fileLists[i]));
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
    }

    request.headers.addAll(baseHeader);

    try {
      http.StreamedResponse response = await request.send();

      http.Response res = http.Response(
          await response.stream.bytesToString(), response.statusCode);
      responseJson = responseHandler(res);
    } on SocketException {
      throw const SocketException('No Internet connection');
    } catch (e) {
      print('error from multi  part>>>>>>$e');
      // rethrow;
    }

    return responseJson;
  }

  buildBase(Uri uri,
      {required String body,
        required Map<String, String> headers,
        ApiTypeEnum type = ApiTypeEnum.post}) {
    print(uri);
    switch (type) {
      case ApiTypeEnum.get:
        return http.get(uri, headers: headers);
      case ApiTypeEnum.post:
        return http.post(uri, body: body, headers: headers);
      case ApiTypeEnum.put:
        return http.put(uri, body: body, headers: headers);
      case ApiTypeEnum.patch:
        return http.patch(uri, body: body, headers: headers);
      case ApiTypeEnum.delete:
        return http.delete(uri, body: body, headers: headers);
      default:
        return http.post(uri, body: body, headers: headers);
    }
  }
}

loadFromMap(Map<String, dynamic> mapData, http.MultipartRequest request,
    {String? index, String? key}) {
  mapData.forEach(
        (key, value) {
      getAndLoad(
        "${index ?? ""}${index != null && index.isNotEmpty ? "[$key]" : key}",
        value,
        request,
      );
    },
  );
}

loadFromList(String key, List<dynamic> listData, http.MultipartRequest request,
    {String? index}) {
  var i = 0;

  for (var value in listData) {
    getAndLoad(
      "",
      value,
      request,
      index: "$key[$i]",
    );
    i++;
  }
}

loadFromString(String key, String? data, http.MultipartRequest request,
    {String? index}) {
  if (data == null || data.isEmpty) return;
  var finalKey = key;
  if (index != null) {
    finalKey = index;
  }
  request.fields[finalKey] = data.toString();
}

getAndLoad(String key, dynamic value, http.MultipartRequest request,
    {String? index}) {
  var runTimeType = value.runtimeType;

  if (runTimeType.toString() == "String") {
    loadFromString(
      key,
      value,
      request,
      index: index,
    );
  } else if (value is List) {
    loadFromList(
      key,
      value,
      request,
      index: index,
    );
  } else if (value is Map) {
    loadFromMap(
      value as Map<String, dynamic>,
      request,
      index: index,
      key: key,
    );
  }
}
