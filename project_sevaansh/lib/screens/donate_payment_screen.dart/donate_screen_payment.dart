import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_sevaansh/constants/routes.dart';
import 'package:project_sevaansh/provider/app_provider.dart';
import 'package:project_sevaansh/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class DonatePayment extends StatefulWidget {
  const DonatePayment({
    Key? key,
  }) : super(key: key);

  @override
  State<DonatePayment> createState() => _DonatePaymentState();
}

class _DonatePaymentState extends State<DonatePayment> {
  int groupValue = 1;
  bool showPayButton = false;
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Donation Payment",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // const SizedBox(
            //   height: 30.0,
            // ),
            // Container(
            //   height: 80,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(12.0),
            //     border: Border.all(
            //       color: Theme.of(context).primaryColor,
            //       width: 3.0,
            //     ),
            //   ),
            //   width: double.infinity,
            //   child: Row(
            //     children: [
            //       const SizedBox(width: 20,),
            //       Radio(
            //         value: 1,
            //         groupValue: groupValue,
            //         onChanged: (value) {
            //           setState(() {
            //             groupValue = value!;
            //           });
            //         },
            //       ),
            //       const Icon(Icons.qr_code),
            //       const SizedBox(
            //         width: 12.0,
            //       ),
            //       const Text(
            //         "QR Code Payment",
            //         style: TextStyle(
            //           fontSize: 18.0,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 24.0,
            // ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: GestureDetector(
                onTap: () {
                  if (groupValue == 2) {
                    setState(() {
                      showPayButton = !showPayButton;
                    });
                  }
                },
                child: Container(
                  height: showPayButton ? 150.0 : 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 3.0,
                    ),
                  ),
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 16.0, 16.0, 16.0),
                        child: Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: groupValue,
                              onChanged: (value) {
                                setState(() {
                                  groupValue = value!;
                                });
                              },
                            ),
                            const Icon(Icons.payment),
                            const SizedBox(
                              width: 12.0,
                            ),
                            const Text(
                              "Card Payment",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Visibility(
                          visible: showPayButton,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: PrimaryButton(
                              title: "Pay",
                              onPressed: () async {
                                await makePayment();

                                // Handle the pay button action here
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            PrimaryButton(
              title: "Continue",
              onPressed: () async {
                if (groupValue == 1) {
                  print("group1");
                } else {
                  setState(() {
                    showPayButton = !showPayButton;
                  });
                  // Routes.instance.push(
                  //   widget: const StripePayment(),
                  //   context: context,
                  // );
                }
              },
            ),
          ],
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

  displayPaymentSheet() async {
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
