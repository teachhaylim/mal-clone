import 'package:flutter/material.dart';
import 'package:mal_clone/utils/function.dart';

class StarRating extends StatefulWidget {
  const StarRating({Key? key, required this.ratingValue, this.size = 24, this.starColor = Colors.yellow, this.textStyle}) : super(key: key);

  final double? ratingValue;
  final Color starColor;
  final TextStyle? textStyle;
  final double size;

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star_rounded, color: widget.starColor, size: widget.size),
        const SizedBox(width: 4),
        Text(toDisplayText(widget.ratingValue), style: widget.textStyle),
      ],
    );
  }
}
