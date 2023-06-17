import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripePayment extends StatefulWidget {
  const StripePayment({super.key});

  @override
  State<StripePayment> createState() => _StripePaymentState();
}

class _StripePaymentState extends State<StripePayment> {
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Tutorial'),
      ),
      body: Center(
        child: CupertinoButton(
          onPressed: () async {
            await makePayment();
            // final paymentMethod = await Stripe.instance.createPaymentMethod(
            //     params: const PaymentMethodParams.card(
            //         paymentMethodData: PaymentMethodData()));
          },
          child: Container(
            height: 50,
            width: 200,
            color: Colors.green,
            child: const Center(
              child: Text(
                'Pay',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent('20', 'USD');
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US'),
          style: ThemeMode.dark,
          merchantDisplayName: 'Ruchir',
        ),
      );

      displayPaymentSheet();
    } catch (e) {
      print('Exception' + e.toString());
    }
  }

  displayPaymentSheet()async {
    try {
      await Stripe.instance.presentPaymentSheet(
          // ignore: deprecated_member_use
          // paymentSheetParameters: PresentPaymentSheetParameters(
          //   clientSecret: paymentIntentData!['client_secret'],
          //   confirmPayment: true,
          // ),
          );
      setState(() {
        paymentIntentData = null;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Paid Successfully")));
    } on StripeException catch (e) {
      print(e.toString());
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51NJA72SHNZYtBUp132Mp4jYQ3xQPkHQ7spQBsIn80KfmzvoLXrOarZ8tiOXgVMY1nLFmmvNn6xpx928213C9QPb900iBwAbfKm',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body.toString());
    } catch (e) {
      print('Exception ' + e.toString());
    }
  }

  calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }
}



// class MainActivity: FlutterActivity() {
// }