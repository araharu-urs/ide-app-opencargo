
import 'package:get_storage/get_storage.dart';

class HttpHeadersService {
  static Map<String, String> getHeaders() {
    final token = GetStorage().read('token');
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }
}