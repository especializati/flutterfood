import 'package:dio/dio.dart';

import '../../../helpers/toast_helpers.dart';

class ApiException {
  Response<dynamic> response;

  ApiException(errorsResponse) {
    response = errorsResponse;

    showErrors();
  }

  showErrors() {
    print(response);
    print(response.statusCode);
    print(response.data);

    if (response.statusCode == 422) {
      Map errors = response.data['errors'];

      if (errors != null) {
        String allErrors = "";

        errors.forEach((key, value) => allErrors = allErrors + value[0] + "\n");

        FlutterFoodToast.error(allErrors);

        return;
      }

      FlutterFoodToast.error('Dados inválidos');

      return;
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      FlutterFoodToast.error('Requisição inválida');

      return;
    }

    FlutterFoodToast.error(
        'Falha ao fazer a requisição (tente novamente mais tarde)');

    return;
  }
}
