import 'package:flutter/material.dart';
import '../../widgets/auth_widgets/text_field.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter both email and password"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Mock Backend Call
    print("--------------------------------------------------");
    print("Mock Backend Call Initiated");
    print("Sending Data to Backend:");
    print("Email: $email");
    print("Password: $password"); // In real app, never print passwords!
    print("--------------------------------------------------");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Login Request Sent for $email"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Container 1: Background + Logo
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(208, 237, 255, 1),
                  Color.fromRGBO(140, 207, 248, 1),
                ],
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: height * 0.02),

                /// Top Row - Back + Get Started
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Get Started",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Logo and Main Banner
                SizedBox(height: height * 0.01),
                Container(
                  width: 250,
                  height: 250,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/thristo logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),

          // Container 2: Form
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: width,
              height: height * 0.55,
              padding: const EdgeInsets.all(22),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "WELCOME TO THRISTO",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      height: 1.0,
                      letterSpacing: 0,
                      color: Color.fromRGBO(46, 46, 46, 1),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Enter Your Login Email Address Below",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.0,
                      letterSpacing: 0,
                      color: Color.fromRGBO(118, 118, 118, 1),
                    ),
                  ),
                  const SizedBox(height: 28),

                  CustomTextField(
                    hint: "Email Address",
                    controller: _emailController,
                  ),
                  const SizedBox(height: 18),
                  CustomTextField(
                    hint: "Password",
                    obscureText: !_isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    controller: _passwordController,
                  ),

                  SizedBox(height: height * 0.03),

                  /// Sign In Button
                  GestureDetector(
                    onTap: _handleLogin,
                    child: Container(
                      width: double.infinity,
                      height: 58,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [Color(0xFF36B1FF), Color(0xFF9ED9FF)],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 15.9,
                            spreadRadius: 0,
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  const Text(
                    "Forgot Your Password?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.0,
                      letterSpacing: 0,
                      color: Color.fromRGBO(134, 134, 134, 1),
                    ),
                  ),
                  const SizedBox(height: 22),

                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 19.8,
                            spreadRadius: 0,
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                          ),
                        ],
                      ),
                      child: const Text.rich(
                        TextSpan(
                          text: "Don't Have An Account? ",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            height: 1.0,
                            letterSpacing: 0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up Here",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                height: 1.0,
                                letterSpacing: 0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget socialIcon(String asset) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Image.asset(asset, height: 28),
    );
  }
}
