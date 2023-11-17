import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/views/register_page.dart';
import '../controller/auth_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Color _emailBorderColor = Colors.white;
  Color _passwordBorderColor = Colors.white;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(String labelText, Color borderColor) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.white),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.purple),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              style: TextStyle(color: Colors.white),
              decoration: _buildInputDecoration('Email', _emailBorderColor),
              onTap: () {
                setState(() {
                  _emailBorderColor = Colors.purple;
                  _passwordBorderColor = Colors.white;
                });
              },
              onEditingComplete: () {
                setState(() {
                  _emailBorderColor = Colors.white;
                });
              },
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration:
                  _buildInputDecoration('Password', _passwordBorderColor),
              onTap: () {
                setState(() {
                  _passwordBorderColor = Colors.purple;
                  _emailBorderColor = Colors.white;
                });
              },
              onEditingComplete: () {
                setState(() {
                  _passwordBorderColor = Colors.white;
                });
              },
            ),
            SizedBox(height: 16),
            Obx(() {
              return ElevatedButton(
                onPressed: _authController.isLoading.value
                    ? null
                    : () {
                        _authController.loginUser(
                          _emailController.text,
                          _passwordController.text,
                        );
                      },
                child: _authController.isLoading.value
                    ? CircularProgressIndicator()
                    : Text('Login'),
              );
            }),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to RegisterPage
                Get.to(RegisterPage());
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
