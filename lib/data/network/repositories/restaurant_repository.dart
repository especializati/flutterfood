import '../../../contants/api.dart';
import '../../../models/Restaurant.dart';
import '../dio_client.dart';

class ResturantRepository {
  var _httpClient;

  ResturantRepository() {
    _httpClient = new DioClient();
  }

  Future<List<Restaurant>> getRestaurants() async {
    final response = await _httpClient.get('$API_VERSION/tenants');
    //print(response);

    final List _restaurants = (response.data['data'] as List).map((restaurant) {
      //_restaurants.add(Restaurant.fromJson(restaurant));
      //print('------------------------');
      return Restaurant.fromJson(restaurant);
    }).toList();
    //print(_restaurants);

    return _restaurants;
  }
}
