import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/actions/adapt.dart';

class DialogRatingBar extends StatefulWidget {
  final double rating;
  final Function(double) submit;

  DialogRatingBar({this.rating, this.submit});

  @override
  DialogRatingBarState createState() => DialogRatingBarState();
}

class DialogRatingBarState extends State<DialogRatingBar> {
  double rating;
  Function(double) submit;
  @override
  void initState() {
    rating = widget.rating;
    submit = widget.submit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Adapt.px(20))),
      children: <Widget>[
        Container(
          width: Adapt.px(300),
          height: Adapt.px(100),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RatingBar(
                initialRating: rating / 2,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  half: const Icon(
                    Icons.star_half_outlined,
                    color: Colors.amber,
                  ),
                  empty: const Icon(
                    Icons.star_border_outlined,
                    color: Colors.grey,
                  ),
                ),
                glow: false,
                allowHalfRating: true,
                onRatingUpdate: (rated) {
                  setState(() {
                    rating = rated * 2;
                  });
                },
              ),
              SizedBox(
                width: Adapt.px(20),
              ),
              Text(
                rating.toStringAsFixed(0),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Adapt.px(35)),
              )
            ],
          ),
        ),
        Divider(
          height: Adapt.px(40),
        ),
        Container(
          height: Adapt.px(40),
          child: TextButton(
            child: Text('ok',
                style: TextStyle(
                    color: Colors.blueAccent, fontSize: Adapt.px(35))),
            onPressed: () {
              submit(rating);
              Navigator.of(context).pop();
            },
          ),
        )
      ],
    );
  }
}
