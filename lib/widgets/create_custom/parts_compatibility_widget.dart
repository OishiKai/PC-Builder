import 'package:custom_pc/models/parts_compatibility.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';

class PartsCompatibilityWidget extends StatelessWidget {
  const PartsCompatibilityWidget(this.compatibility, {super.key});
  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);
  final PartsCompatibility compatibility;

  List<Widget> _compatibilityTexts() {
    List<Widget> list = [];
    compatibility.isCompatible.forEach((key, value) {
      if (value == null) {
        list.add(
          Row(
            children: [
              const Icon(
                Icons.help,
                size: 16,
                color: Colors.grey,
              ),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 1,
              ),
              Text(
                '$key判定不可',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      } else if (value) {
        list.add(Row(
          children: [
            Icon(
              Icons.check_circle,
              size: 16,
              color: _mainColor,
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 1,
            ),
            Text(
              '$key一致',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: _mainColor,
              ),
            ),
          ],
        ));
      } else {
        list.add(Row(
          children: [
            const Icon(
              Icons.error_rounded,
              size: 16,
              color: Colors.red,
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 1,
            ),
            Text(
              '$key非対応',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ));
      }

      if (list.length < compatibility.isCompatible.length) {
        list.add(const SizedBox(
          height: 8,
        ));
      }
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 1, horizontal: SizeConfig.blockSizeHorizontal * 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            compatibility.pair[0].categoryShortName,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _mainColor,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Image.network(
                            compatibility.imageUrls[0],
                            width: SizeConfig.blockSizeHorizontal * 14,
                            height: SizeConfig.blockSizeHorizontal * 14,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      Icon(
                        Icons.multiple_stop_outlined,
                        size: 20,
                        color: _mainColor,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            compatibility.pair[1].categoryShortName,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _mainColor,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Image.network(
                            compatibility.imageUrls[1],
                            width: SizeConfig.blockSizeHorizontal * 14,
                            height: SizeConfig.blockSizeHorizontal * 14,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 2,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _compatibilityTexts(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
