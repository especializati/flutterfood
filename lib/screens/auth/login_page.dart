import 'package:flutter/material.dart';

import './register_page.dart';
import './widgets/heading_auth.dart';

class LoginScreen extends StatelessWidget {
  double _deviceWidth;
  double _deviceHeight;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: _loginPageUI(context),
      ),
    );
  }

  Widget _loginPageUI(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.10),
      child: Column(
        children: <Widget>[
          Container(height: 50),
          HeadingAuth(),
          Container(height: 20),
          _formLogin(context),
          Container(height: 15),
          _loginButton(context),
          Container(height: 30),
          _textRegister(context),
        ],
      ),
    );
  }

  Widget _formLogin(context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(143, 148, 251, .6),
                blurRadius: 20.0,
                offset: Offset(0, 10))
          ]),
      child: Column(
        children: <Widget>[
          _emailTextField(context),
          _passwordTextField(context),
        ],
      ),
    );
  }

  Widget _emailTextField(context) {
    return TextFormField(
      autocorrect: false,
      autofocus: true,
      style: TextStyle(color: Theme.of(context).primaryColor),
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          contentPadding: EdgeInsets.all(10),
          hintText: 'E-mail',
          hintStyle: TextStyle(color: Theme.of(context).primaryColor)),
    );
  }

  Widget _passwordTextField(context) {
    return TextFormField(
      autocorrect: false,
      autofocus: true,
      obscureText: true,
      style: TextStyle(color: Theme.of(context).primaryColor),
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.all(10),
          hintText: 'Passowrd',
          hintStyle: TextStyle(color: Theme.of(context).primaryColor)),
    );
  }

  Widget _loginButton(context) {
    return Container(
      width: _deviceWidth,
      child: MaterialButton(
        onPressed: () {
          print('login...');
        },
        color: Theme.of(context).primaryColor,
        child: Text('LOGIN'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  Widget _textRegister(context) {
    return GestureDetector(
      onTap: () {
        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
        Navigator.pushNamed(context, '/register');
      },
      child: Text(
        'Cadastrar-se',
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18.2),
      ),
    );
  }
}
