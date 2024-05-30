import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isPaymentCompleted = false;

  // Function to simulate payment process
  void _processPayment() {
    // Assuming payment process is successful
    setState(() {
      _isPaymentCompleted = true;
    });
    // Send notification to user
    _sendNotification();
    // Send digital receipt
    _sendDigitalReceipt();
  }

  // Function to send notification
  void _sendNotification() {
    // Code to send notification to user
    print('Notification sent to user: Payment completed successfully');
  }

  // Function to send digital receipt
  void _sendDigitalReceipt() {
    // Code to send digital receipt to user
    print('Digital receipt sent to user');
  }


  @override
  void initState() {
    super.initState();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Payment Page"),
    ),
    body: Center(
      child: _isPaymentCompleted
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 100,
                ),
                Text(
                  'Payment Successful!',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            )
          : ElevatedButton(
              onPressed: _processPayment,
              child: const Text('Proceed to Payment'),
            ),
    ),
  );
}

}
