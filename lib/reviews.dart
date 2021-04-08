import 'package:flutter/material.dart';
import 'package:furniture_design/review.dart';
import 'package:google_fonts/google_fonts.dart';

import 'addreview.dart';
import 'classes.dart';

class Reviews extends StatefulWidget {
  Reviews({Key key}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

int listint = 0;
List<Widget> widgetlist = [Container()];

class _ReviewsState extends State<Reviews> {
  bool readmore = true;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height / 752;
    final width = size.width / 360;

    List list = [
      [
        'https://secure.img1-fg.wfcdn.com/im/34689039/resize-h700-w700%5Ecompr-r85/1150/115033355/Borba+2+Seater+Loveseat.jpg',
        'https://secure.img1-fg.wfcdn.com/im/54430317/resize-h500-w500%5Ecompr-r85/9998/99985750/default_name.jpg',
        'https://secure.img1-fg.wfcdn.com/im/83536475/resize-h500-w500%5Ecompr-r85/1082/108206050/default_name.jpg'
      ],
      [
        'https://secure.img1-fg.wfcdn.com/im/62819961/resize-h700-w700%5Ecompr-r85/9279/92799620/Clayborn+2+Seater+Loveseat.jpg',
        'https://secure.img1-fg.wfcdn.com/im/10140592/resize-h700-w700%5Ecompr-r85/1150/115032771/Trinity+2+Seater+Loveseat.jpg',
      ],
      [
        'https://secure.img1-fg.wfcdn.com/im/32247664/c_crop-h700-w700%5Eresize-h700-w700%5Ecompr-r85/1245/124579848/default_name.jpg',
        'https://secure.img1-fg.wfcdn.com/im/74064134/c_crop-h700-w700%5Eresize-h700-w700%5Ecompr-r85/1241/124128684/default_name.jpg',
        'https://secure.img1-fg.wfcdn.com/im/85533511/c_crop-h700-w700%5Eresize-h700-w700%5Ecompr-r85/1239/123902503/default_name.jpg'
      ],
    ];

    List<String> desc = [
      'We bought the 3 seater for our new home and we are super pleased with how it looks! You also receive the small rectangular pillow in the middle, which was a nice surprise. It is very comfy to sit on and is easy to move (two person job - dont drag as you may snap the legs!). Perfect for a lockdown streaming binge!',
      'Exactly as described and delivery and customer service was excellent',
      'I love the material, it has an expensive look to it. I\'m glad I managed to purchase it in the sale, I wouldn\'t pay full price for it. I purchased mint green but I\'m sure I got duck egg blue instead. Although from reading other reviews the mint green one does look blue too.'
    ];

//using a setstae down the widget tree for this function to change its states is not possible, since at that time the widget is already drawn from the function
//to use your function is like telling it to go back to the function and check again the value and change it which is not practical for this case.

    return WillPopScope(
      onWillPop: () async {
        int count = 0;
        Navigator.popUntil(context, (route) => count++ == 3);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white.withOpacity(.85),
          elevation: 1,
          centerTitle: false,
          title: Text('Reviews',
              style: GoogleFonts.acme(
                  fontSize: 18 * width,
                  fontWeight: FontWeight.normal,
                  color: Colors.black)),
        ),
        body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white.withOpacity(.85),
          padding: EdgeInsets.all(10 * width),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: 80 * height,
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10 * width),
                          child: Text(
                              '${itemholder.avgRate.toStringAsFixed(1)}',
                              style: GoogleFonts.acme(
                                  fontSize: 64 * width,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                        ),
                        SizedBox(width: 25 * width),
                        Container(
                          height: 60 * height,
                          width: 100 * width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 100 * width,height:30*height,
                                child: Center(
                                  child: Text('from',
                                      style: GoogleFonts.acme(
                                          fontSize: 16 * width,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black54)),
                                ),
                              ),
                              Center(
                                child: Text(
                                    '${itemholder.numberOfReviews} reviews',
                                    style: GoogleFonts.acme(
                                        fontSize: 18 * width,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black54)),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                widgetlist[listint],
                Review(
                    false,
                    list[0],
                    'Bridget Murphy',
                    '04.04.2021',
                    5.0,
                    desc[0],
                    'https://images.pexels.com/photos/3863793/pexels-photo-3863793.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                SizedBox(height: 10 * height),
                Review(
                    false,
                    list[1],
                    'Williams James',
                    '01.04.2021',
                    4.5,
                    desc[1],
                    'https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                Review(
                    false,
                    list[2],
                    'Belinda Allison',
                    '25.03.2021',
                    4.0,
                    desc[2],
                    'https://images.pexels.com/photos/1102341/pexels-photo-1102341.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
              ],
            ),
          ),
        ),
        bottomNavigationBar: userholder.addreview == false
            ? Container(width: size.width, height: 0)
            : Container(
                height: 60 * height,
                width: size.width,
                color: Colors.white70,
                padding: EdgeInsets.only(left: 10 * width),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 40 * width,
                        height: 40 * height,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(userholder.image),
                                fit: BoxFit.cover))),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddReview()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10 * width))),
                        width: 270 * width,
                        height: 40 * height,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10 * width),
                            Text('Add a comment',
                                style: GoogleFonts.acme(
                                    fontSize: 16 * width,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54)),
                          ],
                        ),
                      ),
                    ),
                    //  Icon(Icons.send, size: 18 * width, color: colors.activeColor)
                  ],
                )),
      ),
    );
  }
}
