import 'dart:async';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmailService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String username = dotenv.env['SMTP_USERNAME']!;
  final String password = dotenv.env['SMTP_PASSWORD']!;
  late final SmtpServer smtpServer;

  EmailService() {
    smtpServer = SmtpServer(
      'smtp.gmail.com',
      username: username,
      password: password,
      port: 587, // or 465 for SSL
      ssl: true, // use true for SSL
    );
  }

  final String email = 'yehudisgolo@gmail.com';

  Future<void> sendEmail(String email, String subject, String text) async {
     try {
    final smtpServer = SmtpServer('smtp.example.com',
        username: 'user@example.com', password: 'password', port: 587);

    final message = Message()
      ..from = Address('user@example.com', 'Your Name')
      ..recipients.add('recipient@example.com')
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.';

    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('SMTP Client Exception: $e');
  } on TimeoutException catch (e) {
    print('Timeout Exception: $e');
  } catch (e) {
    print('General Exception: $e');
  }
    // final message = Message()
    //   ..from = Address(username, 'Coffee App')
    //   ..recipients.add(email)
    //   ..subject = subject
    //   ..text = text;

    // int retryCount = 0;
    // const int maxRetries = 3;
    // while (retryCount < maxRetries) {
    //   try {
    //     final sendReport = await send(message, smtpServer);
    //     print('Message sent: ' + sendReport.toString());
    //     break;
    //   } on MailerException catch (e) {
    //     print('Message not sent: $e');
    //     for (var p in e.problems) {
    //       print('Problem: ${p.code}: ${p.msg}');
    //     }
    //     retryCount++;
    //     if (retryCount >= maxRetries) {
    //       print('Max retries reached. Failed to send email.');
    //     }
    //   } catch (e) {
    //     print('An unexpected error occurred: $e');
    //   }
    // }
  }

  Future<void> sendVerificationEmail(String email) async {
    String code = _generateVerificationCode();
    await sendEmail(
        email, 'Verification Code', 'Your verification code is: $code');
    saveVerificationCode(email, code);
  }

  Future<void> sendOrderDetails(
      String email, String orderDetails, String total) async {
    await sendEmail(email, 'Your Order Details',
        'Order Details:\n$orderDetails\n\nTotal: \$$total');
  }

  String _generateVerificationCode() {
    final random = Random();
    return List.generate(6, (index) => random.nextInt(10).toString()).join();
  }

  void saveVerificationCode(String email, String code) {
    FirebaseFirestore.instance.collection('verifications').doc(email).set({
      'email': email,
      'code': code,
    }).then((value) {
      print("Verification code saved successfully");
    }).catchError((error) {
      print("Failed to save verification code: $error");
    });
  }
}
