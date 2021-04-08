import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:furniture_design/review.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'classes.dart';
import 'reviews.dart';

class AddReview extends StatefulWidget {
  AddReview();

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<AddReview> {
  TextEditingController _controller1 = TextEditingController();
  List<int> list = [];
  List<int> list2 = [];
  List<File> files = [];
  bool now = false;
  String desc = '';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height / 752;
    final width = size.width / 360;
    final DateTime date = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white.withOpacity(.85),
        elevation: 1,
        centerTitle: false,
        title: Text('Add a comment',
            style: GoogleFonts.acme(
                fontSize: 18 * width,
                fontWeight: FontWeight.normal,
                color: Colors.black)),
        actions: [
          GestureDetector(
              onTap: () {
                double first = list.length.toDouble();
                double second = list2.length == 0 ? 0 : 0.5;
                double rate = first + second;

                setState(() {
                  widgetlist.add(Review(
                      true,
                      files,
                      userholder.name,
                      '0' +
                          date.day.toString() +
                          '.' +
                          '0' +
                          date.month.toString() +
                          '.' +
                          date.year.toString(),
                      rate,
                      desc,
                      userholder.image));
                  listint = 1;
                });
                userholder.addreview = false;
                itemholder.avgRate =
                    (rate + (itemholder.avgRate * itemholder.numberOfReviews)) /
                        (itemholder.numberOfReviews + 1);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Reviews()));
                itemholder.numberOfReviews = itemholder.numberOfReviews + 1;
              },
              child: Icon(Icons.send,
                  size: 22 * width, color: colors.activeColor)),
          SizedBox(width: 20 * width)
        ],
      ),
      backgroundColor: Colors.grey,
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white.withOpacity(.75),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 350 * width,
                padding: EdgeInsets.only(
                    left: 8 * width, top: 10 * height, bottom: 10 * height),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.9),
                    border: Border(
                        bottom: BorderSide(width: 2, color: Colors.black26))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50 * width,
                      height: 50 * width,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(userholder.image),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      width: 265 * width,
                      padding: EdgeInsets.only(
                        right: 10 * width,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userholder.name,
                              style: GoogleFonts.acme(
                                  fontSize: 18 * width,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                          SizedBox(height: 5 * height),
                          Container(
                            height: 20 * height,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width: 120 * width,
                                    height: 20 * height,
                                    child: ListView.builder(
                                      itemCount: 5,
                                      scrollDirection: Axis.horizontal,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              EdgeInsets.only(right: 5 * width),
                                          child: GestureDetector(
                                            onDoubleTap: () {
                                              if (!list.contains(index)) {
                                                if (index == 0) {
                                                  setState(() {
                                                    list2.add(0);
                                                  });
                                                } else {
                                                  if (index -
                                                          list.reduce(max) ==
                                                      1) {
                                                    setState(() {
                                                      list2.contains(index)
                                                          ? list2.remove(index)
                                                          : list2.add(index);
                                                    });
                                                  }
                                                }
                                              }
                                              print(list2);
                                            },
                                            onTap: () {
                                              if (!list.contains(index)) {
                                                if (index == 0) {
                                                  setState(() {
                                                    list.add(0);
                                                  });
                                                } else {
                                                  if (index -
                                                          list.reduce(max) ==
                                                      1) {
                                                    setState(() {
                                                      list.add(index);
                                                    });
                                                  }
                                                }
                                              } else if (list.contains(index) &&
                                                  index - list.reduce(max) ==
                                                      0) {
                                                setState(() {
                                                  list.remove(index);
                                                });
                                              }

                                              if (list.contains(index) &&
                                                  index - list.reduce(max) ==
                                                      0) {
                                                setState(() {
                                                  list2.remove(index);
                                                });
                                              }
                                              print(list);
                                            },
                                            child: Icon(
                                                list.contains(index)
                                                    ? EvaIcons.star
                                                    : list2.contains(index)
                                                        ? FontAwesome
                                                            .star_half_alt
                                                        : EvaIcons.starOutline,
                                                size: 18 * width,
                                                color: Colors.orange),
                                          ),
                                        );
                                      },
                                    )),
                                Text(
                                    date.day.toString() +
                                        '.' +
                                        date.month.toString() +
                                        '.' +
                                        date.year.toString(),
                                    style: GoogleFonts.acme(
                                        fontSize: 14 * width,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black54)),
                              ],
                            ),
                          ),
                          SizedBox(height: 15 * height),
                          Padding(
                            padding: EdgeInsets.only(top: 10 * height),
                            child: SizedBox(
                              width: 270 * width,
                              height: 200 * height,
                              child: TextField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                controller: _controller1,
                                minLines: null,
                                maxLines: null,
                                expands: true,
                                style: GoogleFonts.acme(
                                    fontSize: 16 * width,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black.withOpacity(.7)),
                                decoration: InputDecoration(
                                    hintText: 'Comment',
                                    hintStyle: GoogleFonts.acme(
                                        fontSize: 16 * width,
                                        fontWeight: FontWeight.normal,
                                        color: colors.activeColor)),
                                onChanged: (value) {
                                  setState(() {
                                    desc = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 20 * height, left: 5 * width),
                              child: !now
                                  ? Text('Product images (Optional)',
                                      style: GoogleFonts.acme(
                                          fontSize: 18 * width,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black.withOpacity(.7)))
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Product images',
                                            style: GoogleFonts.acme(
                                                fontSize: 16 * width,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black
                                                    .withOpacity(.7))),
                                        GestureDetector(
                                          onTap: () async {
                                            if (files.length < 3) {
                                              PickedFile image =
                                                  await ImagePicker().getImage(
                                                      source:
                                                          ImageSource.gallery,
                                                      maxWidth: 1800,
                                                      maxHeight: 1800,
                                                      imageQuality: 50);

                                              setState(() {
                                                files.add(File(image.path));
                                              
                                              });
                                            }
                                            if (files.length==3) {
                                              setState(() {
                                                  now = false;
                                              });
                                            }
                                          },
                                          child: Icon(EvaIcons.plus,
                                              size: 18 * width,
                                              color: colors.activeColor),
                                        )
                                      ],
                                    )),
                          SizedBox(
                            height: 80 * height,
                            width: 270 * width,
                            child: files.length == 0
                                ? GestureDetector(
                                    onTap: () async {
                                      var status =
                                          await Permission.photos.status;

                                      if (!status.isGranted) {
                                        await Permission.photos.request();
                                      }
                                      if (status.isGranted) {
                                        PickedFile image = await ImagePicker()
                                            .getImage(
                                                source: ImageSource.gallery,
                                                maxWidth: 1800,
                                                maxHeight: 1800,
                                                imageQuality: 50);

                                        setState(() {
                                          files.add(File(image.path));
                                          now = true;
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 80 * height,
                                      width: 250 * width,
                                      color: Colors.white.withOpacity(.5),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20 * width,
                                          vertical: 20 * height),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(EvaIcons.image,
                                              size: 20 * width,
                                              color: colors.activeColor),
                                          SizedBox(width: 10 * width),
                                          Text('Add images',
                                              style: GoogleFonts.acme(
                                                  fontSize: 16 * width,
                                                  fontWeight: FontWeight.normal,
                                                  color: colors.activeColor)),
                                        ],
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: files.length,
                                    scrollDirection: Axis.horizontal,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, _a) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: 8 * width,
                                            top: 10 * height,
                                            bottom: 10 * height),
                                        child: Container(
                                            width: 80 * width,
                                            height: 80 * height,
                                            decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5 * width)),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5 * width)),
                                              child: Image.file(files[_a],
                                                  width: 80 * width,
                                                  height: 80 * width,
                                                  fit: BoxFit.cover),
                                            )),
                                      );
                                    }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
