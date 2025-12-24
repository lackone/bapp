import '../common/toast.dart';
import '../core/navigator/hi_navigator.dart';
import '../dao/login_dao.dart';
import 'package:flutter/material.dart';

import 'widgets/appbar.dart';
import 'widgets/login_effect.dart';
import 'widgets/login_input.dart';

class Login extends StatefulWidget {
  VoidCallback? onJumpToRegister;
  VoidCallback? onSuccess;

  Login({Key? key, this.onJumpToRegister, this.onSuccess }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _protect = false;
  bool _loginEnable = false;
  String _userName = '';
  String _password = '';

  void _checkLoginEnable() {
    _loginEnable = _userName.isNotEmpty && _password.isNotEmpty;
  }

  void _login() async {
    if (!_loginEnable) {
      return;
    }

    try {
      var ret = await LoginDao.login(_userName, _password);
      print(ret);
    } catch (e) {
      print(e);
    }

    LoginDao.setToken('123456');

    showToast('登录成功');

    // widget.onSuccess?.call();
    HiNavigator.getInstance().onJumpTo(RouteStatus.HOME);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        "登录",
        rightTitle: "注册",
        rightButtonClick: () {
          HiNavigator.getInstance().onJumpTo(RouteStatus.REGISTER);
          // widget.onJumpToRegister?.call();
          //Navigator.pushNamed(context, "/register");
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoginEffect(protect: _protect),
            LoginInput(
              title: '用户名',
              hint: '请输入用户名',
              lineStretch: false,
              onChanged: (value) {
                setState(() {
                  _userName = value;
                  _checkLoginEnable();
                });
              },
              focusChange: (value) {
                if (value) {
                  setState(() {
                    _protect = false;
                  });
                }
              },
            ),
            LoginInput(
              title: '密码',
              hint: '请输入密码',
              obscureText: true,
              lineStretch: false,
              onChanged: (value) {
                setState(() {
                  _password = value;
                  _checkLoginEnable();
                });
              },
              focusChange: (value) {
                if (value) {
                  setState(() {
                    _protect = true;
                  });
                }
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Opacity(
                opacity: _loginEnable ? 1 : 0.5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    _login();
                  },
                  child: Text("登录", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
