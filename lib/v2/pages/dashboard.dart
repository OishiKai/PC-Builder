import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final bottomNavigationBarVisibilityProvider = StateProvider<bool>((ref) => true);

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibility = ref.watch(bottomNavigationBarVisibilityProvider);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Visibility(
        visible: visibility,
        child: Transform.translate(
          offset: const Offset(0, -1),
          child: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.library_books_rounded), label: 'ライブラリ'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
            ],
            onTap: _onTap,
          ),
        ),
      ),
    );
  }

  void _onTap(index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
