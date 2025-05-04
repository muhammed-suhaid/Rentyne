import 'package:flutter/material.dart';
import 'package:rentyne/components/my_button.dart';
import 'package:rentyne/resources/color_manager.dart';
import 'package:rentyne/screens/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //Login method
  void login() async {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: Image.asset(
                'assets/images/plant1.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorManager.tertiary,
              ),
              child: TextField(
                controller: emailController,
                cursorColor: ColorManager.secondary,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: ColorManager.primary),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorManager.tertiary,
              ),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                cursorColor: ColorManager.secondary,
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: ColorManager.primary),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MyButton(
              text: 'Login Now',
              onTap: login,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(
                    color: ColorManager.tertiary,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Register Now',
                    style: TextStyle(
                      color: ColorManager.secondary,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
