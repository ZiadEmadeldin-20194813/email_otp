import 'package:email_otp/email_otp.dart';
import 'package:emailotp/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';




class Otp extends StatelessWidget {
  const Otp({
    Key? key,
    required this.otpController,
  }) : super(key: key);
  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65,
      height: 65,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        showCursor: false,

        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          hintText: ('0'),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),borderSide: BorderSide(style: BorderStyle.solid,color: Colors.black,width: 0.8)),

        ),
        onSaved: (value) {},
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.myauth}) : super(key: key);
  final EmailOTP myauth;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  TextEditingController email = TextEditingController();
  EmailOTP myauth = EmailOTP();
  final CountdownController _controller =
  new CountdownController(autoStart: true);

  String otpController = "1234";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xff8d0000),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Color(0xff8d0000),
          centerTitle: true,
          title:
              Text('OTP authentication', style: TextStyle(color: Colors.white)),
        ),
        body: Container(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Start
                ElevatedButton(
                  child: Text('Start'),
                  onPressed: () {
                    _controller.start();
                  },
                ),
                // Pause
                ElevatedButton(
                  child: Text('Pause'),
                  onPressed: () {
                    _controller.pause();
                  },
                ),
                // Resume
                ElevatedButton(
                  child: Text('Resume'),
                  onPressed: () {
                    _controller.resume();
                  },
                ),
                // Stop
                ElevatedButton(
                  child: Text('Restart'),
                  onPressed: () {
                    _controller.restart();
                  },
                ),
              ],
            ),

    Countdown(
     controller: _controller,
    seconds: 60,
    build: (_, double time) => Text(
    time.toString(),
    style: TextStyle(
    fontSize: 60,
    ),
    ),
    interval: Duration(milliseconds: 1000),
    onFinished: () async {
      myauth.setConfig(
          appEmail: "contact@hdevcoder.com",
          appName: "Future National Bank",
          userEmail: email.text,
          otpLength: 4,
          otpType: OTPType.digitsOnly);
      if (await myauth.sendOTP() == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
      content: Text("OTP has been sent again"),
      ));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(
          content:
          Text("Please enter a valid email"),
        ));
      }
    },),

                     Text(
                      "Enter your verification code",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Otp(
                          otpController: otp1Controller,
                        ),
                        Otp(
                          otpController: otp2Controller,
                        ),
                        Otp(
                          otpController: otp3Controller,
                        ),
                        Otp(
                          otpController: otp4Controller,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                
                    SizedBox(height: 40,),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 12),
                        width: size.width * 0.9,
                        child: ClipRRect(
                          child: SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                // padding: EdgeInsets.symmetric(vertical: 18,horizontal: 38),
                                // color: Colors.deepOrange,
                                onPressed: () async {
                                  if (await widget.myauth.verifyOTP(
                                          otp: otp1Controller.text +
                                              otp2Controller.text +
                                              otp3Controller.text +
                                              otp4Controller.text) ==
                                      true) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("OTP is verified"),
                                    ));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Home()));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Invalid OTP"),
                                    ));
                                  }
                                },
                                child: Text(
                                  'Confirm',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xff8d0000)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                              color: Color(0xff8d0000))),
                                    )),
                              )),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
