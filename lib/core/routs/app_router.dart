import 'package:go_router/go_router.dart';

import 'package:zker/feature/home/presentation/views/widgets/bottom_nav_bar.dart';
import 'package:zker/feature/sapha/data/models/ziker_model/ziker_model.dart';
import 'package:zker/feature/sapha/presentation/views/sapha_view.dart';
import 'package:zker/feature/sapha/presentation/views/widgets/sapha_item_details.dart';

class AppRouter {
  // Init router once and reuse
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => const BottomNavBarScreen(),
      ),
      GoRoute(
        name: 'sapha',
        path: '/sapha',
        // لو عايزة تبعتي بيانات: state.extra
        builder: (context, state) => const SaphaView(),
      ),
       GoRoute(
        name: 'saphaDetails',
        path: '/saphaDetails',
        // لو عايزة تبعتي بيانات: state.extra
        builder: (context, state){
          final zikerModel =state.extra as ZikerModel;
         return SaphaItemDetails(zikerModel:zikerModel ,);
        } 
      ),
    ],
  );
}
