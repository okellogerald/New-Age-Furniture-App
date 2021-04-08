import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furniture_design/forgotpassword.dart';
import 'package:furniture_design/home.dart';
import 'package:furniture_design/login.dart';
import 'package:furniture_design/sign.dart';
import 'package:furniture_design/signup.dart';
import 'package:google_fonts/google_fonts.dart';

import 'categories.dart';
import 'classes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        'sign': (context) => Sign(),
        'login': (context) => LogIn(),
        'signup': (context) => SignUp(),
        'forgotpassword': (context) => ForgotPassword(),
        'categories': (context) => Categories(),
        'home': (context) => Home(),

      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;
  PageController _pageControlller = PageController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height / 752;
    final width = size.width / 360;

    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: PageView.builder(
              itemCount: 3,
              controller: _pageControlller,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: size.width,
                  height: 530 * height,
                  child: index == 0
                      ? Image.asset('assets/image1.png', fit: BoxFit.contain)
                      : index == 1
                          ? Stack(
                              children: [
                                Positioned(
                                    bottom: 70 * height,
                                    child: Image.asset('assets/image2.png',
                                        width: size.width,
                                        height: 430 * height,
                                        fit: BoxFit.cover))
                              ],
                            )
                          : Stack(
                              children: [
                                Positioned(
                                    top: 115 * height,
                                    child: Image.asset('assets/image3.png',
                                        width: size.width,
                                        height: 390 * height,
                                        fit: BoxFit.cover))
                              ],
                            ),
                );
              },
              onPageChanged: (value) {
                setState(() {
                  _index = value;
                });
              },
            ),
          ),
          Container(
            width: size.width,
            height: 130 * height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 46 * width,
                    height: 10 * height,
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              right: index == 2 ? 0 : 8 * width),
                          child: Container(
                            height: 10 * height,
                            width: 10 * width,
                            decoration: BoxDecoration(
                                color: _index == index
                                    ? colors.mainColor
                                    : colors.inactiveColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(50 * width))),
                          ),
                        );
                      },
                    )),
                Text(
                    _index == 0
                        ? 'Office Furniture'
                        : _index == 1
                            ? 'Relaxing Furniture'
                            : 'Home Furniture',
                    style: GoogleFonts.acme(
                        fontSize: 20 * width, color: colors.blackColor)),
                Container(
                  height: 60 * height,
                  width: 270 * width,
                  child: Text(
                      _index == 0
                          ? 'Designs inspired by the new generation with a classic touch'
                          : _index == 1
                              ? 'Let your style make an impression on people'
                              : 'Designed for your comfort',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.acme(
                          fontSize: 16 * width, color: Colors.black.withOpacity(.7))),
                )
              ],
            ),
          ),
          Container(
            width: size.width,
            height: 92 * height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'sign');
                  },
                  child: Text('SKIP',
                      style: GoogleFonts.acme(
                          fontSize: 16 * width, color: Colors.black54)),
                ),
                SizedBox(height: 10 * height)
              ],
            ),
          )
        ],
      ),
    ));
  }
}
