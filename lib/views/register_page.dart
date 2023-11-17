import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              style: TextStyle(color: Colors.white), // Set text color to white
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle:
                    TextStyle(color: Colors.white), // Set label text color
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _emailBorderColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.purple), // Set focused underline color
                ),
              ),
              onTap: () {
                setState(() {
                  _emailBorderColor = Colors.purple;
                  _passwordBorderColor =
                      Colors.white; // Reset the other border color
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
              style: TextStyle(color: Colors.white), // Set text color to white
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle:
                    TextStyle(color: Colors.white), // Set label text color
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _passwordBorderColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.purple), // Set focused underline color
                ),
              ),
              onTap: () {
                setState(() {
                  _passwordBorderColor = Colors.purple;
                  _emailBorderColor =
                      Colors.white; // Reset the other border color
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
                        _authController.registerUser(
                          _emailController.text,
                          _passwordController.text,
                        );
                      },
                child: _authController.isLoading.value
                    ? CircularProgressIndicator()
                    : Text('Register'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
