import 'package:flutter/material.dart';
import 'package:rentyne/components/my_button.dart';
import 'package:rentyne/components/tabs.dart';
import 'package:rentyne/model/register_model.dart';
import 'package:rentyne/resources/color_manager.dart';
import 'package:rentyne/screens/auth/login_screen.dart';
import 'package:rentyne/services/register_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              //************************* Image *************************//
              const SizedBox(height: 50),
              const SizedBox(
                height: 300,
                // child: Image.asset(
                //   'assets/images/plant4.png',
                //   fit: BoxFit.fitHeight,
                // ),
              ),
              const SizedBox(height: 20),
              //************************* UserName textfield *************************//
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorManager.tertiary,
                ),
                child: TextField(
                  controller: userNameController,
                  cursorColor: ColorManager.secondary,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'UserName',
                    hintStyle: TextStyle(color: ColorManager.primary),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //************************* Phone textfield *************************//
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorManager.tertiary,
                ),
                child: TextField(
                  controller: phoneController,
                  cursorColor: ColorManager.secondary,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(color: ColorManager.primary),
                    border: InputBorder.none,
                    counterText: '',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //************************* Email textfield *************************//
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
              //************************* password textfield *************************//
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
              //************************* Register Now Button *************************//
              MyButton(
                text: 'Register Now',
                onTap: () {
                  onButtonPressed(
                    context,
                    userNameController.text,
                    emailController.text,
                    phoneController.text,
                    passwordController.text,
                  );
                },
              ),
              //************************* Already have an account Login Now *************************//
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

  //************************* onButtonPressed function ********************//

  Future<void> onButtonPressed(
    BuildContext context,
    String username,
    String email,
    String phone,
    String password,
  ) async {
    try {
      debugPrint("Button pressed. Attempting to Register...");
      await registerUser(username, email, phone, password).then((response) {
        if (response is RegisterModel) {
          debugPrint("Register successful.");
          debugPrint('ID: ${response.id}');
          debugPrint('User: ${response.user}');
          debugPrint('Phone: ${response.phone}');
          debugPrint('Email: ${response.email}');

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Register successful!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );

          Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TabsScreen()),
              );
            }
          });
        } else if (response is RegisterErrorModel) {
          debugPrint("Register failed. Showing error messages...");

          String errorMessages = response.errors.entries
              .map((entry) => "${entry.key}: ${entry.value.join(', ')}")
              .join('\n');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessages),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 4),
            ),
          );
        }
      });
    } catch (error) {
      // Handle any exceptions here, e.g., show an error dialog
      debugPrint("Error: $error");
      // Show an error dialog or handle the error accordingly
    }
  }
}
