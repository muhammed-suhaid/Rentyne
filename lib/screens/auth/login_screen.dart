import 'package:flutter/material.dart';
import 'package:rentyne/components/my_button.dart';
import 'package:rentyne/components/tabs.dart';
import 'package:rentyne/model/login_model.dart';
import 'package:rentyne/resources/color_manager.dart';
import 'package:rentyne/screens/auth/register_screen.dart';
import 'package:rentyne/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //************************* Image *************************//
            const SizedBox(
              height: 300,
              // child: Image.asset(
              //   'assets/images/plant1.png',
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
                  hintText: 'Username',
                  hintStyle: TextStyle(color: ColorManager.primary),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            //************************* Password textfield *************************//
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
            //************************* Login Now button *************************//
            MyButton(
              text: 'Login Now',
              onTap: () {
                onButtonPressed(
                  context,
                  userNameController.text,
                  passwordController.text,
                );
              },
            ),
            //************************* Dont have account register *************************//
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

//************************* Shared preference ********************//
Future<void> storeUserId(int id) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('userId', id);
}


//************************* onButtonPressed function ********************//
  Future<void> onButtonPressed(
      BuildContext context, String userName, String password) async {
    try {
      debugPrint("Button pressed. Attempting to login...");
      await loginUser(userName, password).then((response) {
        // Check if the response is of type LoginModel
        if (response is LoginModel && response.success == 'User Found') {
          debugPrint("function called inside onButtonPressed (if)");
          debugPrint('ID: ${response.id}');
          debugPrint('Success: ${response.success}');
            
          storeUserId(response.id);
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TabsScreen()),
              );
            }
          });
        } else if (response is LoginErrorModel) {
          debugPrint("function called inside onButtonPressed (else)");
          debugPrint('Error: ${response.error}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(response.error ?? 'Login failed. Please try again.'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
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
