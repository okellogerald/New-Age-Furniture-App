import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'classes.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller1 = TextEditingController();

    final Size size = MediaQuery.of(context).size;
    final height = size.height / 752;
    final width = size.width / 360;
    return WillPopScope(
      onWillPop: () async {
        _controller1.clear();
          Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white70,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 * width),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50 * height),
                  GestureDetector(
                      onTap: () {
                        _controller1.clear();
                        Navigator.pop(context);
                      },
                      child: Icon(EvaIcons.close, size: 25 * width)),
                  SizedBox(height: 30 * height),
                  Padding(
                    padding: EdgeInsets.only(left: 4 * width),
                    child: Text('Forgot Password',
                        style: GoogleFonts.acme(
                            fontSize: 25 * width,
                            fontWeight: FontWeight.w700,
                            color: Colors.black)),
                  ),
                  SizedBox(height: 20 * height),
                  Container(
                    width: 270 * width,
                    child: Text(
                        'Please enter your email address. You will receive a link to create a new password via email',
                        style: GoogleFonts.acme(
                            fontSize: 16 * width,
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ),
                  SizedBox(height: 50 * height),
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
                              contentPadding: EdgeInsets.only(left: 30 * width),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 70 * width,
                        height: 70 * height,
                        decoration: BoxDecoration(
                            color: colors.mainColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50 * width))),
                        child: Center(
                          child: Text('Send',
                              style: GoogleFonts.acme(
                                  fontSize: 25 * width,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
