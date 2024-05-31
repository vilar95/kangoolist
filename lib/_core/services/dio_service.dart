import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_kangoolist/_core/data/local_data_handler.dart';
import 'package:flutter_kangoolist/kangoolists/data/database.dart';

class DioService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://kangoolist-default-rtdb.firebaseio.com/",
      contentType: "application/json; utf-8;",
      responseType: ResponseType.json,
      connectTimeout: Duration(seconds: 5),
      
    ),
  );

  Future<void> saveLocalToServer(AppDatabase appdatabase) async {
    Map<String, dynamic> localData =
        await LocalDataHandler().localDataToMap(appdatabase: appdatabase);

    await _dio.put(
      "kangooLists.json",
      data: json.encode(
        localData["kangooLists"],
      ),
    );
  }

  getDataFromServer(AppDatabase appDatabase) async {
    Response response = await _dio.get(
      "kangooLists.json",
    );
    // print(response.statusCode);
    // print(response.headers.toString());
    // print(response.data);
    // print(response.data.runtimeType);

    if (response.data != null) {
      if ((response.data as List<dynamic>).isNotEmpty) {
        Map<String, dynamic> map = {};

        map["kangooLists"] = response.data;

        await LocalDataHandler()
            .mapToLocalData(map: map, appdatabase: appDatabase);
      }
    }
  }

  Future<void> clearServerData() async {
    await _dio.delete(
      "kangooLists.json",
    );
  }
}
