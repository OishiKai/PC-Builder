import 'package:custom_pc/domain/search_parameter_fetcher.dart';
import 'package:custom_pc/pages/dashboard.dart';
import 'package:custom_pc/providers/search_parameter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../providers/edit_custom.dart';

class CreateCustomFloatingActionButton extends ConsumerWidget {
  const CreateCustomFloatingActionButton({super.key});

  void showProgressDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () async {
        // 初回のみ検索条件を取得する
        if (ref.read(searchParameterNotifierProvider) == null) {
          showProgressDialog(context);
          final params = await SearchParameterFetcher.getAllParams();
          ref.read(searchParameterNotifierProvider.notifier).set(params);
          context.pop();
        }

        ref.read(bottomNavigationBarVisibilityProvider.notifier).update((state) => false);
        ref.read(editCustomNotifierProvider.notifier).createCustom();
        context.push('/create');
      },
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      child: const Icon(
        Icons.add,
        size: 32,
      ),
    );
  }
}
