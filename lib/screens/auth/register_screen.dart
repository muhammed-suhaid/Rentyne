import 'package:flutter/material.dart';
import 'package:rentyne/components/my_button.dart';
import 'package:rentyne/resources/color_manager.dart';
import 'package:rentyne/screens/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  //Register method
  void register() async {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              SizedBox(
                height: 300,
                child: Image.asset(
                  'assets/images/plant4.png',
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorManager.tertiary,
                ),
                child: TextField(
                  obscureText: true,
                  controller: confirmPassController,
                  cursorColor: ColorManager.secondary,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(color: ColorManager.primary),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MyButton(
                text: 'Register Now',
                onTap: register,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: ColorManager.tertiary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Login Now',
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
      ),
    );
  }
}
