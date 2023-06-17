import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_sevaansh/constants/theme.dart';
import 'package:project_sevaansh/widgets/primary_button/primary_button.dart';
import 'package:http/http.dart' as http;

class MailScreen extends StatelessWidget {
  const MailScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mailing System",
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Email System'),
        ),
        body: MailPage(),
      ),
    );
  }
}

class MailPage extends StatefulWidget {
  @override
  _MailPageState createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  // sendEmail(String subject, String body, String recipientEmail) async {
  //   final Email email = Email(
  //     body: body,
  //     subject: subject,
  //     recipients: [recipientEmail],
  //     isHTML: false,
  //   );
  //   await FlutterEmailSender.send(email);
  // }

  Future sendEmail(
      {required String name,
      required String email,
      required String subject,
      required String message}) async {
    final serviceId = 'service_7k93g4a';
    final templateId = 'template_hc0f067';
    final userId = '6ydDqnfPjMH7SSOBy';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_subject': subject,
          'user_message': message,
        },
      }),
    );

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Important Notice:',
                      style: GoogleFonts.lora(
                        textStyle: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    BulletPoint(
                        text: 'Make sure to enter a valid email address.'),
                    SizedBox(height: 5),
                    BulletPoint(
                        text:
                            'Provide a concise and relevant subject for your email.'),
                    SizedBox(height: 5),
                    BulletPoint(
                        text:
                            'Clearly articulate your message in the email body.'),
                    SizedBox(height: 5),
                    BulletPoint(
                        text: 'Please provide the drive link of the banner.'),
                    SizedBox(height: 5),
                    BulletPoint(
                        text:
                            'It will take 3-4 business days to revert your query.'),
                    SizedBox(height: 5),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Recipient Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: subjectController,
                  decoration: const InputDecoration(
                    hintText: 'Subject',
                    prefixIcon: Icon(Icons.subject),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a subject';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: bodyController,
                  decoration: const InputDecoration(
                    hintText: 'Body',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a body';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                PrimaryButton(
                  title: 'Send Email',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendEmail(
                          name: nameController.text,
                          email: emailController.text,
                          subject: subjectController.text,
                          message: bodyController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 8,
          height: 8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }
}
