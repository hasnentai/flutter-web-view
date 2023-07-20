import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, this.message});
  final String? message;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(widget.message!),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, "This is the result from Flutter  Widget");
            },
            child: const Text("Go Back"),
          )
        ],
      ),
    );
  }
}
