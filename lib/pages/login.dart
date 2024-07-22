import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_new_app/const.dart';
import 'package:coffee_new_app/pages/home_page.dart';
import 'package:coffee_new_app/services/email_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  bool isEmailSignIn = true;
  bool showCodeInput = false;
  bool isCodeSent = false;
  String message = '';

  final EmailService emailService = EmailService();

  void sendCode(String email) async {
    try {
      await emailService.sendVerificationEmail(email);
      setState(() {
        showCodeInput = true;
        isCodeSent = true;
        message = 'A verification code has been sent to your email.';
      });
    } catch (e) {
      print('Failed to send verification code: $e');
      setState(() {
        message = 'Failed to send verification code. Please try again.';
      });
    }
  }

  void verifyCode(String email, String code) async {
    final doc = await FirebaseFirestore.instance
        .collection('verifications')
        .doc(email)
        .get();
    if (doc.exists && doc['code'] == code) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Verification code is incorrect'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void login() async {
    if (isEmailSignIn) {
      String email = emailController.text;
      sendCode(email);
    } else {
      String phone = phoneController.text;
      print('phone: ' + phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: Image.asset("lib/images/ice_splash.png", height: 200),
              ),
              const SizedBox(height: 24),
              Text(
                "Welcome!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 70, 52, 48),
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Please choose email or phone number to continue",
                style: TextStyle(color: Colors.grey[800], fontSize: 16),
              ),
              const SizedBox(height: 16),
              ToggleButtons(
                fillColor: Color.fromARGB(255, 253, 241, 203),
                selectedColor: Color.fromARGB(255, 151, 89, 38),
                borderRadius: BorderRadius.circular(12),
                isSelected: [isEmailSignIn, !isEmailSignIn],
                onPressed: (index) {
                  setState(() {
                    isEmailSignIn = index == 0;
                    showCodeInput = false;
                    isCodeSent = false;
                    message = '';
                  });
                },
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Email'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Phone'),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              if (isEmailSignIn)
                Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    if (showCodeInput)
                      Column(
                        children: [
                          const SizedBox(height: 25),
                          TextField(
                            controller: codeController,
                            decoration: InputDecoration(
                              labelText: 'Verification Code',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 25),
                          GestureDetector(
                            onTap: () {
                              verifyCode(
                                  emailController.text, codeController.text);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(25),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 151, 89, 38),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                "Verify Code",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                )
              else
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
              const SizedBox(height: 25),
              if (!isCodeSent)
                GestureDetector(
                  onTap: () {
                    login();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 151, 89, 38),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "Send me verification code",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              if (message.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.green, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../services/email_service.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool isPhoneSelected = true;
//   final TextEditingController _phoneEmailController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final EmailService emailService = EmailService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.asset(
//                 'lib/images/iced_coffee.png', // Make sure to add your image asset here
//                 height: 100,
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'היי, ברוכים הבאים',
//                 style: TextStyle(fontSize: 24),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 'הזינו את מספר הטלפון או המייל על מנת להיכנס',
//                 style: TextStyle(fontSize: 16),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 20),
//               ToggleButtons(
//                 borderColor: Colors.grey,
//                 fillColor: Colors.brown[100],
//                 borderWidth: 2,
//                 selectedBorderColor: Colors.brown,
//                 selectedColor: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Text('טלפון'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Text('מייל'),
//                   ),
//                 ],
//                 onPressed: (int index) {
//                   setState(() {
//                     isPhoneSelected = index == 0;
//                   });
//                 },
//                 isSelected: [isPhoneSelected, !isPhoneSelected],
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: _phoneEmailController,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: isPhoneSelected ? 'מספר טלפון' : 'כתובת מייל',
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _sendVerificationCode,
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   textStyle: TextStyle(fontSize: 16),
//                 ),
//                 child: Text('שלחו לי קוד אימות'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _sendVerificationCode() async {
//     String input = _phoneEmailController.text.trim();

//     if (isPhoneSelected) {
//       // Phone authentication
//       await _auth.verifyPhoneNumber(
//         phoneNumber: input,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await _auth.signInWithCredential(credential);
//           // Handle user signed in
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           // Handle error
//           print('Verification failed: ${e.message}');
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           // Navigate to OTP input screen
//           // You might want to save the verificationId for later use
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       );
//     } else {
//       // Email authentication
//       await emailService.sendVerificationEmail(input);
//       // Save the code locally or use another method to verify it later
//     }
//   }
// }
