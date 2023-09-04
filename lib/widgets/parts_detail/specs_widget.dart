import 'package:flutter/material.dart';

class SpecsWidgets extends StatelessWidget {
  const SpecsWidgets(this.specs, {super.key});
  final Map<String, String?> specs;

  List<Container> _setUpWidgets(BuildContext context) {
    List<Container> widgets = [];
    specs.forEach((key, value) {
      if (value != null && value != '　') {
        widgets.add(Container(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.b,
                children: [
                  Icon(
                    Icons.info,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    key,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ));
      }
    });
    return widgets;
  }

  // 先頭2件のスペック情報のみ返す
  Column generalSpecs(BuildContext context) {
    final widgets = _setUpWidgets(context);
    return Column(
      children: [
        widgets[0],
        widgets[1],
      ],
    );
  }

  // 先頭3件以降のスペックのみ返す
  @override
  Widget build(BuildContext context) {
    final widgets = _setUpWidgets(context);
    return Column(
      children: [
        for (int i = 2; i < widgets.length; i++) widgets[i],
      ],
    );
  }
}
