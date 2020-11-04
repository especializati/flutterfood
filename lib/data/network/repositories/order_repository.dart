import '../../../contants/api.dart';
import '../dio_client.dart';

class OrderRepository {
  var _httpClient;

  OrderRepository() {
    _httpClient = new DioClient();
  }

  Future makeOrder(String tokenCompany, List<Map<String, dynamic>> foods,
      {String comment}) async {
    final response = await _httpClient.post("/auth/$API_VERSION/orders",
        formData: {
          'token_company': tokenCompany,
          'products': foods,
          'comment': comment
        });

    return response;
  }

  Future<List<dynamic>> getMyOrders() async {
    final response = await _httpClient.get("/auth/$API_VERSION/my-orders");

    return (response.data['data'] as List).toList();
  }
}
