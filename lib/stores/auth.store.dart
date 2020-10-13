import 'package:mobx/mobx.dart';

import '../data/network/repositories/auth_repository.dart';

part 'auth.store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  AuthRepository _authRepository = AuthRepository();

  @observable
  bool isAuthenticated = false;

  @observable
  bool isLoading = false;

  @action
  void setAuthenticated(bool value) => isAuthenticated = value;

  @action
  void setLoading(bool value) => isLoading = value;

  @action
  Future<bool> auth(String email, String password) async {
    setLoading(true);

    await _authRepository.auth(email, password);

    setLoading(false);

    return true;
  }

  @action
  Future<bool> register(String name, String email, String password) async {
    setLoading(true);

    await _authRepository.register(name, email, password);

    await auth(email, password);

    setLoading(false);

    return true;
  }
}
