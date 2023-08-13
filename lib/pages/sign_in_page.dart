
import 'package:flutter/material.dart';
import 'package:safeguardclient/pages/home_page.dart';
import 'package:safeguardclient/shared/theme.dart';
import 'package:safeguardclient/widgets/buttons.dart';
import 'package:safeguardclient/widgets/forms.dart';
import 'package:safeguardclient/services/message_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  void _showLoginFailedSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login failed. Please check your email and password.',
        style: whiteTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semiBold,
            ),
        ),
        duration: Duration(seconds: 3),
        backgroundColor: redColor,
            behavior: SnackBarBehavior.floating,
      ),
    );
  }
    void _handleSignIn() {
    // Simulate login logic
    // String email = emailController.text;
    // String password = passwordController.text;

    // Replace this with your actual login logic
    // if (email == 'admin@gmail.com' && password == 'admin123') {
    //   Navigator.push(
    //         context, MaterialPageRoute(builder: (context) => const HomePage()));
    // } else {
    //   _showLoginFailedSnackbar();
    // }
      NotificationService()
              .showNotification(title: 'Sample title', body: 'It works!');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 100,
              bottom: 50,
            ),
            width: 155,
            height: 50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img-logo.png'),
              ),
            ),
          ),
          Text(
            "Sign In &\nEmergency our health",
            style: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 CustomTextFormField(
                  label: "Email Address",
                  keyboardType: TextInputType.emailAddress,
                   controller: emailController,
                ),
                const SizedBox(
                  height: 16,
                ),
                 CustomTextFormField(
                  label: "Password",
                  isObscure: true,
                  controller: passwordController,
                ),

                const SizedBox(
                  height: 30,
                ),
                CustomFilledButton(
                  title: "Sign In",
                  onPressed: _handleSignIn,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),

        ],
      ),
    );
  }
}
