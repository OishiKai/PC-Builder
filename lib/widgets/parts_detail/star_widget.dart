import 'package:flutter/material.dart';

class StarWidget extends StatelessWidget {
  const StarWidget(this.star, {super.key});
  final int? star;

  List<Icon> describeStars() {
    const fullStar = Icon(
      Icons.star,
      color: Colors.orange,
      size: 20,
    );

    const halfStar = Icon(
      Icons.star_half,
      color: Colors.orange,
      size: 20,
    );

    const emptyStar = Icon(
      Icons.star_border_purple500_sharp,
      color: Colors.orange,
      size: 20,
    );

    if (this.star == null) {
      return List.filled(5, emptyStar);
    }

    final star = this.star!;

    List<Icon> stars = [];

    final fullStarCount = star ~/ 10;
    final fullStars = List.filled(fullStarCount, fullStar);
    stars.addAll(fullStars);

    if (star % 10 == 0) {
      final emptyStarCount = 5 - fullStarCount;
      final emptyStars = List.filled(emptyStarCount, emptyStar);

      stars.addAll(emptyStars);
    } else {
      stars.add(halfStar);
      final emptyStarCount = 4 - fullStarCount;
      final emptyStars = List.filled(emptyStarCount, emptyStar);
      stars.addAll(emptyStars);
    }

    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: describeStars(),
    );
  }
}
