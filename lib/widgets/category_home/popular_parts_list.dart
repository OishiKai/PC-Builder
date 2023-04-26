import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter/material.dart';

class PopularPartsList extends StatelessWidget {
  const PopularPartsList(this.parts, {super.key});

  final PcParts parts;
  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      margin: const EdgeInsets.only(right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(),
              Image.network(
                parts.image,
                height: 120,
              ),
              const Spacer(),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(
              parts.maker,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: _mainColor,
              ),
            ),
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              parts.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: _mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Text(
              parts.price,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
