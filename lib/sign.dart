import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'classes.dart';

class Sign extends StatelessWidget {
  const Sign({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height / 752;
    final width = size.width / 360;
    return Scaffold(
      body: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                child: Image.asset('assets/landing.png', fit: BoxFit.cover),
              ),
              Positioned(
                top: 35 * height,
                left: 50 * width,
                child: Container(
                  width: 270 * width,
                  height: 250 * height,
                  color:Colors.transparent,
                  child: Center(
                    child: Container(
                      width: 135 * width,
                      height: 100 * height,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              width: 50 * width,
                              height: 45 * height,
                              child: Image.asset('assets/logo.png',
                                  fit: BoxFit.contain)),
                          Text('NEW AGE\nFURNITURE',
                              style: GoogleFonts.acme(
                                  fontSize: 16 * width,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  left: 50 * width,
                  bottom: 30 * height,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'signup');
                        },
                        child: Container(
                            width: 270 * width,
                            height: 50 * height,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(3 * width)),
                                border:
                                    Border.all(color: Colors.white, width: 2)),
                            child: Center(
                              child: Text('SIGN UP',
                                  style: GoogleFonts.lato(
                                      fontSize: 16 * width,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            )),
                      ),
                      SizedBox(height: 20 * height),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: Container(
                            width: 270 * width,
                            height: 50 * height,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3 * width)),
                              color: colors.mainColor,
                            ),
                            child: Center(
                              child: Text('LOG IN',
                                  style: GoogleFonts.lato(
                                      fontSize: 16 * width,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            )),
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}
