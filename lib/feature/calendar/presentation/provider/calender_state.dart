import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class CalenderState extends Equatable {
  final bool isLoading;

  const CalenderState({required this.isLoading});

  const CalenderState.initial({this.isLoading = false});

  @override
  List<Object> get props => [isLoading];

  @override
  bool get stringify => true;

  CalenderState copyWith({bool? isLoading}) {
    return CalenderState(isLoading: isLoading ?? this.isLoading);
  }
}
