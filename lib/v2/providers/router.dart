import 'package:custom_pc/v2/next_tab_page.dart';
import 'package:custom_pc/v2/pages/custom_detail_page.dart';
import 'package:custom_pc/v2/pages/dashboard.dart';
import 'package:custom_pc/v2/pages/edit_custom_page.dart';
import 'package:custom_pc/v2/pages/parts_detail_page.dart';
import 'package:custom_pc/v2/pages/parts_list_page.dart';
import 'package:custom_pc/v2/pages/stored_custom_list_page.dart';
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
                    path: 'detail/:id',
                    builder: (context, state) {
                      final String id = state.pathParameters['id']!;
                      return CustomDetailPage(
                        id: id,
                      );
                    },
                    routes: [
                      GoRoute(
                        name: 'edit',
                        path: 'edit',
                        pageBuilder: (context, state) => const MaterialPage(
                          fullscreenDialog: true,
                          child: EditCustomPageV2(),
                        ),
                        routes: [
                          GoRoute(
                            name: 'partsDetailForEdit',
                            path: 'partsDetailForEdit/:usage/:categoryName',
                            builder: (context, state) {
                              final usage = state.pathParameters['usage']!;
                              final id = state.pathParameters['id']!;
                              final categoryName = state.pathParameters['categoryName']!;
                              return PartsDetailPageV2(
                                usageValue: usage,
                                customId: id,
                                categoryName: categoryName,
                              );
                            },
                          ),
                          GoRoute(
                            name: 'partsList',
                            path: 'partsList',
                            builder: (context, state) {
                              return const PartsListPageV2();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'parts/:usage/:id/:categoryName',
                    builder: (context, state) {
                      final usage = state.pathParameters['usage']!;
                      final id = state.pathParameters['id']!;
                      final categoryName = state.pathParameters['categoryName']!;
                      return PartsDetailPageV2(
                        usageValue: usage,
                        customId: id,
                        categoryName: categoryName,
                      );
                    },
                  ),
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
