import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../../stores/auth.store.dart';

class SpeechScreen extends StatefulWidget {
  SpeechScreen({Key key}) : super(key: key);

  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  AuthStore _authStore;
  FlutterSecureStorage storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIOverlays([]);

    _checkAuth().then((bool isAuthenticated) {
      if (isAuthenticated) {
        Navigator.pushReplacementNamed(context, '/restaurants');
        return;
      }

      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    _authStore = Provider.of<AuthStore>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150,
              child: Image.asset('assets/images/IconeFlutterFood.png'),
            ),
            Container(height: 30),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
            Container(height: 10),
            Text(
              'Carregando...',
              style: TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _checkAuth() async {
    final String token = await storage.read(key: 'token_sanctum');

    if (token != null) {
      final bool isAuthenticated = await _authStore.getMe();

      return isAuthenticated;
    }

    return false;
  }
}
