import 'package:flutter/material.dart';

import '../../../models/custom.dart';

class StoredCustomCard extends StatelessWidget {
  const StoredCustomCard({super.key, required this.custom});
  final Custom custom;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Row(
            children: [
              SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        custom.getMainPartsImage(),
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.darken,
                      ))),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  custom.name!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    custom.formatPrice(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    custom.date!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
