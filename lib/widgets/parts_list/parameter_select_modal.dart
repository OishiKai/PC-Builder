import 'package:custom_pc/widgets/parts_list/parts_category_parameter_select_modal/cpu_cooler_parameter.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';

class ParameterSelectModal extends StatelessWidget {
  const ParameterSelectModal({super.key});

  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);
  final _subColor = const Color(0xFFEDECF2);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
        color: _mainColor,
      ),
      child: const CpuCoolerParameterModal(),
    );
  }
}
