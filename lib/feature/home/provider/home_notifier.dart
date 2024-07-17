import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:themovers_fleet_admin/feature/home/provider/home_state.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(const HomeState());

  void onIndexChanged(int index) {
    state = state.copyWith(index: index);
  }
}
