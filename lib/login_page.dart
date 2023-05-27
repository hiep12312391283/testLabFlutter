import 'package:btvn/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordInvisible = true;
  String? usernameErrorText;
  String? passwordErrorText;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Đăng nhập'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Image.asset('asset/images/techmaster_black.png')),
                buildUsernameForm(),
                const SizedBox(
                  height: 20,
                ),
                buildPasswordForm(),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    usernameController.text = usernameController.text.trim();
                    passwordController.text = passwordController.text.trim();

                    if (usernameController.text == "") {
                      setState(() {
                        usernameErrorText = "Username không được để rỗng";
                      });
                    } else if (usernameController.text.contains(' ')) {
                      setState(() {
                        usernameErrorText = "Username không được chứa dấu cách";
                      });
                    } else {
                      setState(() {
                        usernameErrorText = null;
                      });
                    }

                    if (passwordController.text == "") {
                      setState(() {
                        passwordErrorText = "Password không được để rỗng";
                      });
                    } else {
                      setState(() {
                        passwordErrorText = null;
                      });
                    }

                    if (usernameController.text == "hoangxuanhiep" &&
                        passwordController.text == "123456") {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (Route<dynamic> route) => false);
                    } else {
                      _showAlertDialog('Tài khoản hoặc mật khẩu không đúng');
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(String message) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }

  TextFormField buildUsernameForm() {
    return TextFormField(
      controller: usernameController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        errorText: usernameErrorText,
        labelText: "Username",
        hintText: "Enter your username",
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
      ),
    );
  }

  TextFormField buildPasswordForm() {
    return TextFormField(
      controller: passwordController,
      obscureText: _passwordInvisible,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          errorText: passwordErrorText,
          labelText: "Password",
          hintText: "Enter your password",
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordInvisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _passwordInvisible = !_passwordInvisible;
              });
            },
          )),
    );
  }
}
