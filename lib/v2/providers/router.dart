import 'package:custom_pc/v2/pages/custom_detail_page.dart';
import 'package:custom_pc/v2/pages/dashboard.dart';
import 'package:custom_pc/v2/pages/edit_custom_page.dart';
import 'package:custom_pc/v2/pages/parts_detail_page.dart';
import 'package:custom_pc/v2/pages/parts_list_page.dart';
import 'package:custom_pc/v2/pages/setting_page.dart';
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
                          GoRoute(
                            name: 'partsDetailForCreate',
                            path: 'partsDetailForCreate/:usage/:listIndex',
                            builder: (context, state) {
                              final usage = state.pathParameters['usage']!;
                              final listIndex = state.pathParameters['listIndex']!;
                              return PartsDetailPageV2(
                                usageValue: usage,
                                listIndex: int.parse(listIndex),
                              );
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
              GoRoute(
                name: 'create',
                path: '/create',
                pageBuilder: (context, state) => const MaterialPage(
                  fullscreenDialog: true,
                  child: EditCustomPageV2(),
                ),
                routes: [
                  GoRoute(
                    name: 'create_partsDetail_selecting',
                    path: 'partsDetail/:usage/:categoryName',
                    builder: (context, state) {
                      final usage = state.pathParameters['usage']!;
                      final categoryName = state.pathParameters['categoryName']!;
                      return PartsDetailPageV2(
                        usageValue: usage,
                        categoryName: categoryName,
                      );
                    },
                  ),
                  GoRoute(
                    name: 'create_partsList',
                    path: 'partsList',
                    builder: (context, state) {
                      return const PartsListPageV2();
                    },
                    routes: [
                      GoRoute(
                        name: 'create_partsDetail_searching',
                        path: 'partsDetail/:usage/:listIndex',
                        builder: (context, state) {
                          final usage = state.pathParameters['usage']!;
                          final listIndex = state.pathParameters['listIndex']!;
                          return PartsDetailPageV2(
                            usageValue: usage,
                            listIndex: int.parse(listIndex),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/setting',
                builder: (context, state) {
                  return const SettingPage();
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
