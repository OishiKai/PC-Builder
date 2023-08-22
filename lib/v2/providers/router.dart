import 'package:custom_pc/v2/custom_detail_page.dart';
import 'package:custom_pc/v2/dashboard.dart';
import 'package:custom_pc/v2/next_tab_page.dart';
import 'package:custom_pc/v2/stored_custom_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../next_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/next',
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: NextPage(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Dashboard(navigationShell: navigationShell);
        },
        branches: [
          // ボトムナビゲーションバーのルート分岐2
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) {
                  return const StoredCustomListPageV2();
                },
                routes: [
                  GoRoute(
                    path: 'detail',
                    builder: (context, state) {
                      return const CustomDetailPage();
                    },
                  )
                ],
              ),
            ],
          ),
          // ボトムナビゲーションバーのルート分岐3を追加
          StatefulShellBranch(
            routes: [
              // このブランチルートを追加する
              // 各ルートとそのサブルート (利用可能な場合) 例: profile/uuid/details
              GoRoute(
                path: '/nextTab',
                builder: (context, state) {
                  return const NextTabPage();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
