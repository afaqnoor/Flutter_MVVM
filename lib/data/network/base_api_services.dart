abstract class BaseApiServices {
  Future<dynamic> getApis(String url);
  Future<dynamic> postApi(String url, dynamic data);
}
