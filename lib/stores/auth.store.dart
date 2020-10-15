import 'package:mobx/mobx.dart';

import '../data/network/repositories/auth_repository.dart';
import '../models/User.dart';

part 'auth.store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  AuthRepository _authRepository = AuthRepository();

  @observable
  User user;

  @observable
  bool isLoading = false;

  @action
  void setUser(User value) => user = value;

  @action
  void setLoading(bool value) => isLoading = value;

  @action
  Future<bool> auth(String email, String password) async {
    setLoading(true);

    await _authRepository.auth(email, password);

    await getMe();

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

  @action
  Future<bool> getMe() async {
    User user = await _authRepository.getMe();

    setUser(user);

    return true;
  }

  @action
  Future logout() async {
    setLoading(true);
    await _authRepository.logout().whenComplete(() => setLoading(false));
  }
}
