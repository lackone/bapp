import 'package:bapp/core/navigator/hi_navigator.dart';
import 'package:flutter/material.dart';

import '../dao/login_dao.dart';
import 'widgets/appbar.dart';
import '../common/toast.dart';
import 'widgets/login_effect.dart';
import 'widgets/login_input.dart';

class Register extends StatefulWidget {
  VoidCallback? onJumpToLogin;
  VoidCallback? onSuccess;

  Register({Key? key, this.onJumpToLogin, this.onSuccess}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _protect = false;
  bool _registerEnable = false;
  String _userName = '';
  String _password = '';
  String _confirmPassword = '';
  String _imoocId = '';
  String _orderId = '';

  void _checkRegisterEnable() {
    _registerEnable =
        _userName.isNotEmpty &&
        _password.isNotEmpty &&
        _confirmPassword.isNotEmpty &&
        _password == _confirmPassword &&
        _imoocId.isNotEmpty &&
        _orderId.isNotEmpty;
  }

  void _register() async {
    if (!_registerEnable) {
      return;
    }

    try {
      var ret = await LoginDao.register(
        _userName,
        _password,
        _imoocId,
        _orderId,
        'FT',
      );
      print(ret);
    } catch (e) {
      print(e);
    }

    showToast('注册成功');

    // widget.onSuccess?.call();
    HiNavigator.getInstance().onJumpTo(RouteStatus.LOGIN);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        '注册',
        rightTitle: '登录',
        rightButtonClick: () {
          HiNavigator.getInstance().onJumpTo(RouteStatus.LOGIN);
          // widget.onJumpToLogin?.call();
          //Navigator.pushNamed(context, "/login");
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
                  _checkRegisterEnable();
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
              lineStretch: false,
              onChanged: (value) {
                setState(() {
                  _password = value;
                  _checkRegisterEnable();
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
            LoginInput(
              title: '确认密码',
              hint: '请再次输入密码',
              lineStretch: false,
              onChanged: (value) {
                setState(() {
                  _confirmPassword = value;
                  _checkRegisterEnable();
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
            LoginInput(
              title: '慕课网ID',
              hint: '请输入慕课网ID',
              lineStretch: false,
              onChanged: (value) {
                setState(() {
                  _imoocId = value;
                  _checkRegisterEnable();
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
              title: '课程订单号',
              hint: '请输入课程订单号',
              lineStretch: false,
              onChanged: (value) {
                setState(() {
                  _orderId = value;
                  _checkRegisterEnable();
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
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Opacity(
                opacity: _registerEnable ? 1 : 0.5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    _register();
                  },
                  child: Text("注册", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
