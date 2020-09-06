import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_hANyLdnvdWyoQy",
      "amount": num.parse(textEditingController.text) * 100,
      "name": "Divyansh",
      "description": "payment for some random product",
      "prefill": {
        "contact": "6264384853",
        "email": "tamrakardivyansh189@gmail.com",
      },
      "external": {
        "wallets": ["paytm"],
      },
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    Toast.show("Payment Success", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  void handlerErrorFailure() {
    Toast.show("Payment Failed", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  void handlerExternalWallet() {
    Toast.show("External Wallet", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Razorpay in Flutter"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 170, left: 15, right: 15),
            child: TextField(
              controller: textEditingController,
              cursorColor: Colors.black,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                prefixIcon: Icon(FontAwesomeIcons.rupeeSign),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                hintText: "Enter Amount",
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          RaisedButton(
            onPressed: () {
              openCheckout();
              Toast.show(textEditingController.text, context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            },
            color: Colors.blue,
            child: Text(
              "Pay Now",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
