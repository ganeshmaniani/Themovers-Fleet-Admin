import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({this.index = 0});

  final int index;

  HomeState copyWith({int? index}) {
    return HomeState(index: index ?? this.index);
  }

  @override
  List<Object?> get props => [index];
}
