import '../../../contants/api.dart';
import '../dio_client.dart';

class CategoryRepository {
  var _httpClient;

  CategoryRepository() {
    _httpClient = new DioClient();
  }

  Future<List<dynamic>> getCategories(String tokenCompany) async {
    final response = await _httpClient.get("$API_VERSION/categories",
        queryParameters: {'token_company': tokenCompany});

    return (response.data['data'] as List).toList();
  }
}
