import '../../../contants/api.dart';
import '../dio_client.dart';

class FoodRepository {
  var _httpClient;

  FoodRepository() {
    _httpClient = new DioClient();
  }

  Future<List<dynamic>> getFoods(String tokenCompany) async {
    final response = await _httpClient.get("$API_VERSION/products",
        queryParameters: {'token_company': tokenCompany});

    return (response.data['data'] as List).toList();
  }
}
