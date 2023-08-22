import 'package:custom_pc/v2/dashboard.dart';
import 'package:custom_pc/v2/next_tab_page.dart';
import 'package:custom_pc/v2/stored_custom_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../next_page.dart';
import '../sub_route_page.dart';

// このGlobalKeyは、GoRouterのインスタンスを取得するために必要です。
final _rootNavigatorKey = GlobalKey<NavigatorState>();
// このGlobalKeyは、各タブのGoRouterインスタンスを取得するために必要です。
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => const StoredCustomListPageV2(),
      // ),
      GoRoute(
        path: '/next',
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: NextPage(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // カスタムシェル（BottomNavigationBar など）を実装したウィジェットを返します。
          // ステートフルな方法で他のブランチにナビゲートできるように、 // [StatefulNavigationShell] が渡されます。
          return Dashboard(navigationShell: navigationShell);
        },
        // branchesとは、IndexedStackの子ウィジェットとして表示されるGoRouterのブランチを指定します。
        branches: [
          // ボトムナビゲーションバーのルート分岐1
          // StatefulShellBranch(
          //   navigatorKey: _sectionNavigatorKey,
          //   // このブランチルートを追加する
          //   // 各ルートとそのサブルート (利用可能な場合) 例: feed/uuid/details
          //   routes: <RouteBase>[
          //     GoRoute(
          //       path: '/',
          //       builder: (context, state) => const StoredCustomListPageV2(),
          //       routes: <RouteBase>[
          //         GoRoute(
          //           path: RouterPath.details,
          //           builder: (context, state) {
          //             return const DetailsPage(label: 'FeedDetailsをFullPathで渡す');
          //           },
          //         )
          //       ],
          //     ),
          //   ],
          // ),
          // ボトムナビゲーションバーのルート分岐2
          StatefulShellBranch(
            // navigatorKey: _sectionNavigatorKey,
            // initialLocation: '/',
            routes: [
              // このブランチルートを追加する
              // 各ルートとそのサブルート (利用可能な場合) 例: shope/uuid/details
              GoRoute(
                path: '/home',
                builder: (context, state) {
                  return const StoredCustomListPageV2();
                },
                routes: [
                  GoRoute(
                    path: 'sub_route',
                    builder: (context, state) {
                      return const SubRoutePage();
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
