import 'dart:math';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_design/classes.dart';
import 'package:furniture_design/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'classes.dart';

class LogIn extends StatefulWidget {
  LogIn();

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  bool password = true;

  final GoogleSignIn _googlSignIn = new GoogleSignIn();
  var user;
  @override
  void initState() {
    //calling delete user with FirebaseAuth.instance.currentUser.delete() the user has to have signed in recently for it to work
    //if not then error occurs and the intended action won't be done.
    //This actions solves it, it checks if the user was already signed in with google then using _user to reauthenticate if existing and to
    //sign in the user if did not exist before
    //that way, sign out or delete will always work.
    super.initState();
    User _user = FirebaseAuth.instance.currentUser;
    setState(() {
      user = _user;
    });
    print(user);
  }

  Future _signIn() async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 4),
      backgroundColor: Colors.black,
      content: Text('Signing you in...',
          style: GoogleFonts.acme(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.white)),
    ));

    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    if (user != null) {
      await FirebaseAuth.instance.currentUser
          .reauthenticateWithCredential(credential)
          .then((value) {
        userholder.name = value.user.displayName;
        userholder.image = value.user.photoURL;
        userholder.email = value.user.email;
        return;
      });
    } else {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        userholder.name = value.user.displayName;
        userholder.image = value.user.photoURL;
        userholder.email = value.user.email;
        return;
      });
    }

    //.then() CONVERTS FUTURE TO A NORMAL VARIABLE;
    /*    Future<UserCredential> userDetails = */

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userholder.email)
        .get()
        .then((value) async {
      if (!value.exists) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userholder.email)
            .set({}).then((value) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userholder.email)
              .collection('cart')
              .doc('00000')
              .set({
            'name': 'hello',
            'price': 0,
            'colors': [],
            'images': [],
            'quantities': []
          });
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userholder.email)
              .collection('wishlist')
              .doc('00000')
              .set({
            'name': 'name',
            'type': 'type',
            'price': 0,
            'colors': [],
            'images': []
          });
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userholder.email)
              .set({'wishList': [], 'cartItems': 0, 'cartTotalPrice': 0});
        });
      }
    });

    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new Home(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height / 752;
    final width = size.width / 360;

    return WillPopScope(
      onWillPop: () async {
        _controller1.clear();
        _controller2.clear();
        setState(() {
          password = true;
        });
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.grey,
          body: Container(
            width: size.width,
            height: size.height,
            color: Colors.white.withOpacity(.85),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20 * width),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 50 * height),
                    GestureDetector(
                        onTap: () {
                          _controller1.clear();
                          _controller2.clear();
                          setState(() {
                            password = true;
                          });
                          Navigator.pop(context);
                        },
                        child: Icon(EvaIcons.close, size: 25 * width)),
                    SizedBox(height: 30 * height),
                    Padding(
                      padding: EdgeInsets.only(left: 4 * width),
                      child: Text('Login',
                          style: GoogleFonts.acme(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, 'forgotpassword'),
                          child: Text(
                            'Forgot your password?',
                            style: GoogleFonts.acme(
                                fontWeight: FontWeight.normal,
                                fontSize: 16 * width,
                                color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60 * height),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.black,
                              content: Text('Signing you in...',
                                  style: GoogleFonts.acme(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white)),
                            ));
                            List<String> names = [
                              'John Doe',
                              'Willie Smith',
                              'James Miko',
                              'Adrian Mbappe',
                              'Christian Wayne'
                            ];

                            List<String> emails = [
                              'user@gmail.com',
                              'client@gmail.com',
                              'hello@gmail.com',
                              'user@outlook.com',
                              'hello@outlook.com',
                              'client@outlook.com'
                            ];

                            List<String> images = [
                              'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                              'https://image.freepik.com/free-photo/happy-man-with-long-thick-ginger-beard-has-friendly-smile_273609-16616.jpg',
                              'https://image.freepik.com/free-photo/close-up-confident-male-employee-white-collar-shirt-smiling-camera-standing-self-assured-against-studio-background_1258-26761.jpg',
                              'https://image.freepik.com/free-photo/curly-man-with-broad-smile-shows-perfect-teeth-being-amused-by-interesting-talk-has-bushy-curly-dark-hair-stands-indoor-against-white-blank-wall_273609-17092.jpg',
                            ];

                            Random _random = new Random();

                            userholder.name =
                                names[_random.nextInt(names.length)];
                            userholder.email =
                                emails[_random.nextInt(emails.length)];
                            userholder.image =
                                images[_random.nextInt(images.length)];

                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(userholder.email)
                                .get()
                                .then((value) async {
                              if (!value.exists) {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userholder.email)
                                    .set({}).then((value) async {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(userholder.email)
                                      .collection('cart')
                                      .doc('00000')
                                      .set({
                                    'name': 'hello',
                                    'price': 0,
                                    'colors': [],
                                    'images': [],
                                    'quantities': []
                                  });
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(userholder.email)
                                      .collection('wishlist')
                                      .doc('00000')
                                      .set({
                                    'name': 'name',
                                    'type': 'type',
                                    'price': 0,
                                    'colors': [],
                                    'images': []
                                  });
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(userholder.email)
                                      .set({
                                    'wishList': [],
                                    'cartItems': 0,
                                    'cartTotalPrice': 0
                                  });
                                });
                              }
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                            /*  String document = 'jH1Wy0D2x6f6DznPsdxW';
                            await FirebaseFirestore.instance
                                .collection('tables')
                                .doc(document)
                                .update({
                              '0price': 125.99,
                              '1name': 'Jordyn Console Table',
                              '5type': 'console',
                              '2images': [
                                'https://secure.img1-fg.wfcdn.com/im/92471146/resize-h700-w700%5Ecompr-r85/6277/62775718/Jordyn+Console+Table.jpg',
                              ],
                              '3colors': ['White'],
                              '4desc':
                                  'A geometric S-shape sets off this console table\'s modern design and makes it a great fit for any living room, bedroom or even hallway. A smooth high gloss finish paired with chrome give it a stylish look, while the in-built shelves offer plenty of space to store books, art, houseplants or any other household items. Assembly is required.',
                              '6brand': 1,
                              '7av-rate': 5.0,
                              '8no-reviews': 32,
                              '9included': [],
                            });

                            await FirebaseFirestore.instance
                                .collection('tables')
                                .doc(document)
                                .collection('reviews')
                                .doc('1')
                                .set({
                              'person-name': 'James Becker',
                              'person-image':
                                  'https://images.pexels.com/photos/3863793/pexels-photo-3863793.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                              'person-rate': 4.0,
                              'date': '05.04.2021',
                              'product-images': [
                                'https://secure.img1-fg.wfcdn.com/im/70095956/c_crop-h200-w200%5Ecompr-r85/1146/114632370/default_name.jpg',
                                'https://secure.img1-fg.wfcdn.com/im/10598266/c_crop-h200-w200%5Ecompr-r85/1146/114695106/default_name.jpg',
                                'https://secure.img1-fg.wfcdn.com/im/79424761/c_crop-h200-w200%5Ecompr-r85/1221/122112614/default_name.jpg'
                              ],
                              'person-review':
                                  'Love the sofa bed, great size for my living room! Quite easy to assemble but definitely need 2 people to do it! Easy to pull out into bed!'
                            });

                            await FirebaseFirestore.instance
                                .collection('tables')
                                .doc(document)
                                .collection('reviews')
                                .doc('2')
                                .set({
                              'person-name': 'Pharrel',
                              'person-image':
                                  'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                              'person-rate': 4.5,
                              'date': '02.04.2021',
                              'product-images': [
                                'https://secure.img1-fg.wfcdn.com/im/47583403/c_crop-h200-w200%5Ecompr-r85/1243/124346303/default_name.jpg',
                                'https://secure.img1-fg.wfcdn.com/im/58934316/c_crop-h200-w200%5Ecompr-r85/1243/124346302/default_name.jpg'
                              ],
                              'person-review':
                                  'Very cute ottoman but very small. Make sure you measure.',
                            });

                            await FirebaseFirestore.instance
                                .collection('tables')
                                .doc(document)
                                .collection('reviews')
                                .doc('3')
                                .set({
                              'person-name': 'Lynda Allison',
                              'person-image':
                                  'https://images.pexels.com/photos/4177650/pexels-photo-4177650.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                              'person-rate': 5.0,
                              'date': '01.04.2021',
                              'product-images': [],
                              'person-review':
                                  'This is a gorgeous large ottoman with great storage for linens or anything else. Super soft velvet. Just needed to screw in legs. I took one star off because The ottoman is wayyy darker grey than the photo. I’ll keep it because it’s so lovely and useful',
                            }); */
                          },
                          child: Container(
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
                        ),
                      ],
                    ),
                    SizedBox(height: 50 * height),
                    Center(
                      child: Text(
                        'OR',
                        style: GoogleFonts.acme(
                            fontWeight: FontWeight.normal,
                            fontSize: 16 * width,
                            color: Colors.black54),
                      ),
                    ),
                    SizedBox(height: 20 * height),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => _signIn(),
                          child: Card(
                            color: Colors.grey,
                            elevation: 5,
                            shadowColor: Colors.grey.withOpacity(.2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30 * width))),
                            child: Container(
                              width: 200 * width,
                              height: 60 * height,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.90),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(30 * width))),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 22 * width),
                                    child: Center(
                                        child: SvgPicture.asset(
                                            'assets/google.svg',
                                            width: 24 * width,
                                            height: 24 * width,
                                            fit: BoxFit.contain)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10 * width),
                                    child: Text(
                                      'Login with Google',
                                      style: GoogleFonts.acme(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16 * width,
                                          color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10 * width),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
