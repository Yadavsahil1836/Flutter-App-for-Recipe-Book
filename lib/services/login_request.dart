import 'package:dio/dio.dart';
import 'package:firebase/consts.dart';

class Httpservice {
  static final Httpservice _singleton = Httpservice.initialValue();

  final Dio _dio = Dio();

  factory Httpservice() {
    return _singleton;
  }

  Httpservice.initialValue() {
    setup();
  }

  Future<void> setup({String? bearerToken}) async {
    final headers = {
      "Content-Type": "application/json",  // Fixed header value
    };

    if(bearerToken != null){
      headers["Authorization"] = "Bearer $bearerToken";
    }

    final BaseOptions options = BaseOptions(
      headers: headers,
      baseUrl: API_BASE_URL,
      validateStatus: (status) {
        if (status == null) return false;
        return status < 500;  // Only consider < 500 as valid responses
      },
    );
    _dio.options = options;
  }

  Future<Response?> post(String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        path,
        data: FormData.fromMap(data),  // Ensure data is of type Map<String, dynamic>
      );
      return response;
    } catch (e) {
      print(e);
      return null;  // Return null in case of exception
    }
  }

  Future<Response?> get(String path) async{
    try{
      final Response = await _dio.get(
        path
      );
      return Response;
    }
    catch(e){
      print(e);
    }
  }
}
