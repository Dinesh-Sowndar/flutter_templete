import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_templete/widgets/toast.dart';
import 'package:get_storage/get_storage.dart';

class ApiServices {
  Response? response;
  Dio dio = Dio();
  final url = "http://3.108.108.170/api/";
  final contentType = Headers.jsonContentType;

  Future<dynamic> get(String _endPoint) async {
    if (GetStorage().hasData("token")) {
      dio.options.headers["Authorization"] =
          "Token ${GetStorage().read("token")}";
    }

    try {
      response = await dio.get(url + _endPoint,
          options: Options(contentType: contentType));
      if (response!.data.runtimeType == String) {
        return jsonDecode(response!.data);
      } else {
        return response!.data;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          showErrorMessage(e.response!.extra.toString());
        }
      } else {
        return {"status": false, "message": "Server/URL error", "data": []};
      }
    }
  }

  Future<dynamic> post(
    String _endPoint,
    _data,
  ) async {
    if (GetStorage().hasData("token")) {
      dio.options.headers["Authorization"] =
          "Token ${GetStorage().read("token")}";
    }
    try {
      response = await dio.post(url + _endPoint,
          data: _data, options: Options(contentType: contentType));
      if (response!.data.runtimeType == String) {
        return jsonDecode(response!.data);
      } else {
        return response!.data;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          showErrorMessage("error");
        }
      } else {
        return {"status": false, "message": "Server/URL error", "data": []};
      }
    }
  }

  Future<dynamic> put(String _endPoint, _data) async {
    if (GetStorage().hasData("token")) {
      dio.options.headers["Authorization"] =
          "Token ${GetStorage().read("token")}";
    }
    try {
      response = await dio.put(url + _endPoint,
          data: _data, options: Options(contentType: contentType));
      if (response!.data.runtimeType == String) {
        return jsonDecode(response!.data);
      } else {
        return response!.data;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          showErrorMessage("Inalid Token. Login again...");
        }
      } else {
        return {"status": false, "message": "Server/URL error", "data": []};
      }
    }
  }

  Future<dynamic> delete(String _endPoint, Map _data) async {
    if (GetStorage().hasData("token")) {
      dio.options.headers["Authorization"] =
          "Token ${GetStorage().read("token")}";
    }
    try {
      response = await dio.delete(url + _endPoint,
          data: _data, options: Options(contentType: contentType));
      if (response!.data.runtimeType == String) {
        return jsonDecode(response!.data);
      } else {
        return response!.data;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          showErrorMessage("Inalid Token. Login again...");
        }
      } else {
        return {"status": false, "message": "Server/URL error", "data": []};
      }
    }
  }

  Future<dynamic> customGet(String _url) async {
    try {
      response =
          await dio.get(_url, options: Options(contentType: contentType));
      if (response!.data.runtimeType == String) {
        return jsonDecode(response!.data);
      } else {
        return response!.data;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          showErrorMessage(e.response!.extra.toString());
        }
      } else {
        return {"status": false, "message": "Server/URL error", "data": []};
      }
    }
  }

  Future<dynamic> customPost(String _url, _data) async {
    try {
      response = await dio.post(_url,
          data: _data, options: Options(contentType: contentType));
      if (response!.data.runtimeType == String) {
        return jsonDecode(response!.data);
      } else {
        return response!.data;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 401) {
          showErrorMessage("error");
        }
      } else {
        return {"status": false, "message": "Server/URL error", "data": []};
      }
    }
  }
}
