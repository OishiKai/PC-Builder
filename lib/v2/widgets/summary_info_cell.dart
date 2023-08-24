import 'package:custom_pc/models/pc_parts.dart';
import 'package:flutter/material.dart';

/// 詳細画面で表示する、パーツの概要を表示するセル
class SummaryInfoCell extends StatelessWidget {
  const SummaryInfoCell({
    super.key,
    required this.icon,
    required this.title,
    required this.category,
    required this.backgroundColor,
    required this.textColor,
  });

  final IconData icon;
  final String title;
  final PartsCategory category;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // cell間の余白
      padding: const EdgeInsets.all(4),
      child: Container(
        padding: const EdgeInsets.all(4),
        // 二列で表示するためpaddingを考慮して、画面*45%
        width: MediaQuery.of(context).size.width * 0.45,
        height: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: textColor,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: textColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              category.categoryShortName,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
