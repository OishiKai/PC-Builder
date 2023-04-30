import 'package:custom_pc/models/pc_parts.dart';
import 'package:custom_pc/widgets/parts_list/parts_category_parameter_select_modal/cpu_cooler_parameter_modal.dart';
import 'package:custom_pc/widgets/parts_list/parts_category_parameter_select_modal/cpu_parameter_modal.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';

class ParameterSelectModal extends StatelessWidget {
  const ParameterSelectModal(this.category, {super.key});

  final _mainColor = const Color.fromRGBO(60, 130, 80, 1);
  final _subColor = const Color(0xFFEDECF2);
  final PartsCategory category;

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

  Widget switchSearchParameterModal() {
    switch (category) {
      case PartsCategory.cpu:
        return const CpuParameterModal();
      case PartsCategory.cpuCooler:
        return const CpuCoolerParameterModal();
      default:
        return const CpuCoolerParameterModal();
    }
  }
}
