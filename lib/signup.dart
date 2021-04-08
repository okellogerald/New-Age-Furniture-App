import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'classes.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool password = true;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height / 752;
    final width = size.width / 360;
    return WillPopScope(
      onWillPop: () async {
        _controller1.clear();
        _controller2.clear();
        _controller3.clear();
        setState(() {
          password = true;
        });
          Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 * width),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 50 * height),
                    GestureDetector(
                        onTap: () {
                          _controller1.clear();
                          _controller2.clear();
                          _controller3.clear();
                          setState(() {
                            password = true;
                          });
                          Navigator.pop(context);
                        },
                        child: Icon(EvaIcons.close, size: 25 * width)),
                    SizedBox(height: 30 * height),
                    Padding(
                      padding: EdgeInsets.only(left: 4 * width),
                      child: Text('Sign Up',
                          style: GoogleFonts.acme(
                              // letterSpacing: .5,
                              fontSize: 25 * width,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                    ),
                    SizedBox(height: 90 * height),
                    Center(
                      child: SizedBox(
                          width: 300 * width,
                          height: 80 * height,
                          child: TextFormField(
                            style: GoogleFonts.acme(
                                fontWeight: FontWeight.normal,
                                fontSize: 18 * width,
                                color: Colors.black54),
                            controller: _controller1,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 30 * width),
                                labelStyle: GoogleFonts.acme(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18 * width,
                                    color: Colors.black54),
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30 * width)))),
                          )),
                    ),
                    SizedBox(height: 20 * height),
                    Center(
                      child: SizedBox(
                          width: 300 * width,
                          height: 80 * height,
                          child: TextFormField(
                            style: GoogleFonts.acme(
                                fontWeight: FontWeight.normal,
                                fontSize: 18 * width,
                                color: Colors.black54),
                            controller: _controller2,
                            obscureText: password,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 30 * width),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      password =
                                          password == true ? false : true;
                                    });
                                  },
                                  child: Icon(
                                      password == true
                                          ? EvaIcons.eyeOffOutline
                                          : EvaIcons.eyeOutline,
                                      size: 18 * width),
                                ),
                                labelStyle: GoogleFonts.acme(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18 * width,
                                    color: Colors.black54),
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30 * width)))),
                          )),
                    ),
                    SizedBox(height: 20 * height),
                    Center(
                      child: SizedBox(
                          width: 300 * width,
                          height: 80 * height,
                          child: TextFormField(
                            style: GoogleFonts.acme(
                                fontWeight: FontWeight.normal,
                                fontSize: 18 * width,
                                color: Colors.black54),
                            controller: _controller2,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 30 * width),
                                labelStyle: GoogleFonts.acme(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18 * width,
                                    color: Colors.black54),
                                labelText: 'Phone',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30 * width)))),
                          )),
                    ),
                    SizedBox(height: 60 * height),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 70 * width,
                          height: 70 * height,
                          decoration: BoxDecoration(
                              color: colors.mainColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(50 * width))),
                          child: Center(
                              child: Icon(EvaIcons.arrowForwardOutline,
                                  color: Colors.white, size: 22 * width)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
