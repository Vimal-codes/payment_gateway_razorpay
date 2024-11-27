import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay; // Razorpay instance for handling payments

  // Callback to handle payment failure
  _handlePaymentErrorResponse(PaymentFailureResponse? response) {
    print(response.toString());
  }

  // Callback to handle payment success
  _handlePaymentSuccessResponse(PaymentSuccessResponse? response) {
    print(response.toString());
  }

  // Callback to handle wallet payments
  _handlePaymentWalletResponse(ExternalWalletResponse? response) {
    print(response.toString());
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay(); // Initializing Razorpay instance
    // Registering event listeners for payment callbacks
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentWalletResponse);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear(); // Clearing all event listeners when widget is disposed
  }

  // Method to configure and open the Razorpay checkout
  void openCheckOut(double amt, String shopname, String description, String contact, String email) {
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb', // Razorpay API key
      'amount': amt * 100, // Amount in paise (1 INR = 100 paise)
      'name': shopname, // Merchant/shop name
      'description': description, // Payment purpose
      'retry': {'enabled': true, 'max_count': 1}, // Retry configuration
      'send_sms_hash': true, // Sending SMS hash for verification
      'prefill': {'contact': contact, 'email': email}, // Pre-filled contact details
      'external': {
        'wallets': ['paytm'] // Supported external wallets
      }
    };
    _razorpay.open(options); // Opening Razorpay checkout with the specified options
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // App bar for the page
      body: ElevatedButton(
        onPressed: () {
          // Trigger payment checkout on button press
          openCheckOut(1000, "lulu", "payment for food", "77369937683", "vr323837@gmail.com");
        },
        child: const Text("Pay"), // Button label
      ),
    );
  }
}
