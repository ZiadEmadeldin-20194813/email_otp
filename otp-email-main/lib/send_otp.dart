import 'package:email_otp/email_otp.dart';
import 'package:emailotp/otp_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController email = TextEditingController();
  EmailOTP myauth = EmailOTP();
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
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50,),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                           'images/email.png',scale: 4.0,
                        ),
                      ),
                      SizedBox(height: 30,),
                      const SizedBox(
                        height: 50,
                        child: Text(
                          "Enter your Email to get OTP",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Card(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.mail,
                                  color:Colors.black45 ,
                                ),
                                hintText: "Email Address",

                                border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0),),
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 12),
                          width: size.width * 0.9,
                          child: ClipRRect(
                            child: SizedBox(height: 50, child:  ElevatedButton(
                              // padding: EdgeInsets.symmetric(vertical: 18,horizontal: 38),
                              // color: Colors.deepOrange,
                              onPressed: () async {

                                String email1 = email.text;
                                myauth.setConfig(
                                    appEmail: "contact@hdevcoder.com",
                                    appName: "Future National Bank",
                                    userEmail: email.text,
                                    otpLength: 4,
                                    otpType: OTPType.digitsOnly);
                                if (await myauth.sendOTP() == true) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("OTP has been sent"),
                                  ));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(

                                          builder: (context) => OtpScreen(
                                            myauth: myauth
                                          )));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                    Text("Please enter a valid email"),
                                  ));
                                }

                              },
                              child: Text(
                                'Send OTP',
                                style:
                                TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Color(0xff8d0000)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:BorderRadius.circular(10),
                                        side: BorderSide(color: Color(0xff8d0000))
                                    ),)
                              ),
                            )),
                          )),

                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
