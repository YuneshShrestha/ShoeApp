import 'package:dio/dio.dart';

class API {
  static final dio = Dio(
    BaseOptions(
      baseUrl: "https://shoesapp-10ac9-default-rtdb.firebaseio.com/",
    ),
  );
}
