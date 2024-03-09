import 'package:flutter/material.dart';
import 'package:kitajom/provider/review_provider.dart';
import 'package:kitajom/utils/colors.dart';
import 'package:provider/provider.dart';
class RatingWidget extends StatefulWidget {
  final bool isReview;
  final num rating;
  const RatingWidget({super.key, this.isReview = true, this.rating = 0});

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  num _currentRating = 0;
  double _size = 20;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isReview) {
      setState(() {
        _size = 30;
      });
    }
  }

  void modifyRating(int rate) {
    if (widget.isReview) {
      setState(() {
        if(_currentRating != rate) {
          _currentRating = rate;
        }
        else{
          _currentRating = 0;
        }
      });
      Provider.of<ReviewProvider>(context, listen: false).setRating(_currentRating);
    }
  }

  Icon star(int rate) {
    if (!widget.isReview) {
      return widget.rating >= rate ? Icon(Icons.star, size: _size, color: yellow,) : Icon(Icons.star_border, size: _size,color: yellow,);
    } else {
      return _currentRating >= rate ? Icon(Icons.star, size: _size,color: yellow,) : Icon(Icons.star_border, size: _size,color: yellow,);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap:true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return GestureDetector(onTap: () {
              modifyRating(index + 1);
            }, child: star(index + 1));
          }),
    );
  }
}

