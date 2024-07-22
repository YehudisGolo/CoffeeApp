
// import 'package:flutter/material.dart';

// import '../services/auth/auth_service.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage();

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   void login() async {
//     final authService = AuthService();

//     try {
//       await authService.signInWithEmailPassword(
//         emailController.text,
//         passwordController.text,
//       );

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage()),
//       );
//     } catch (e) {
//       String errorMessage = authService.getErrorMessage(e.toString());
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           backgroundColor: Theme.of(context).colorScheme.background,
//           title: Text(errorMessage),
//         ),
//       );
//     }
//   }

//   void navigateToRegister() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => RegisterPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 50),
//                 Image.asset(
//                   'lib/images/message.png',
//                   height: 100,
//                   color: Theme.of(context).colorScheme.primary,
//                 ),
//                 const SizedBox(height: 50),
//                 Text(
//                   'Welcome back you\'ve been missed!',
//                   style: TextStyle(
//                     color: Theme.of(context).colorScheme.primary,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 25),
//                 MyTextField(
//                   controller: emailController,
//                   hintText: 'Email',
//                   obscureText: false,
//                 ),
//                 const SizedBox(height: 10),
//                 MyTextField(
//                   controller: passwordController,
//                   hintText: 'Password',
//                   // obscureText: true,
//                 ),
//                 const SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       GestureDetector(
//                         onTap: () {},
//                         child: Text(
//                           'Forgot Password?',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 25),
//                 MyButton(
//                   onTap: login,
//                   text: "Login",
//                 ),
//                 const SizedBox(height: 50),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Not a member?',
//                       style: TextStyle(
//                         color: Theme.of(context).colorScheme.primary,
//                       ),
//                     ),
//                     const SizedBox(width: 4),
//                     GestureDetector(
//                       onTap: navigateToRegister,
//                       child: Text(
//                         'Register now',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Theme.of(context).colorScheme.primary,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
