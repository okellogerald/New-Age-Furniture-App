import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class Review extends StatefulWidget {
  final bool isFile;
  final List list;
  final String name, date, desc, image;
  final double reviews;
  Review(this.isFile, this.list, this.name, this.date, this.reviews, this.desc,
      this.image);

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final height = size.height / 752;
    final width = size.width / 360;
    final int _index = widget.reviews.round();

    return Container(
      width: 350 * width,
      padding: EdgeInsets.only(
          left: 8 * width, top: 10 * height, bottom: 10 * height),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 2, color: Colors.black26))),
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
                    image: NetworkImage(widget.image), fit: BoxFit.cover)),
          ),
          Container(
            width: 265 * width,
            padding: EdgeInsets.only(
              right: 10 * width,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name,
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
                                padding: EdgeInsets.only(right: 5 * width),
                                child: Icon(
                                    _index != widget.reviews.toInt()
                                        ? index < _index - 1
                                            ? EvaIcons.star
                                            : index == _index - 1
                                                ? FontAwesome.star_half_alt
                                                : EvaIcons.starOutline
                                        : index <= _index - 1
                                            ? EvaIcons.star
                                            : EvaIcons.starOutline,
                                    size: 18 * width,
                                    color: Colors.orange),
                              );
                            },
                          )),
                      Text(widget.date,
                          style: GoogleFonts.acme(
                              fontSize: 14 * width,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54)),
                    ],
                  ),
                ),
                SizedBox(height: 15 * height),
                Text(widget.desc,
                    style: GoogleFonts.acme(
                        fontSize: 16 * width,
                        fontWeight: FontWeight.normal,
                        color: Colors.black.withOpacity(.7))),
                widget.list.length == 0
                    ? Container()
                    : SizedBox(
                        height: 80 * height,
                        width: 270 * width,
                        child: ListView.builder(
                            itemCount: widget.list.length,
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, _index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  right: 8 * width,
                                  top: 10 * height,
                                ),
                                child: Container(
                                    width: 80 * width,
                                    height: 80 * height,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5 * width)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5 * width)),
                                      child: widget.isFile
                                          ? Image.file(widget.list[_index],
                                              fit: BoxFit.cover)
                                          : Image.network(widget.list[_index],
                                              fit: BoxFit.cover),
                                    )),
                              );
                            }),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
