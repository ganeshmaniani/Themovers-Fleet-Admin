import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class FaqState extends Equatable {
  final bool isLoading;

  const FaqState({required this.isLoading});

  const FaqState.initial({this.isLoading = false});

  @override
  List<Object> get props => [isLoading];

  @override
  bool get stringify => true;

  FaqState copyWith({bool? isLoading}) {
    return FaqState(isLoading: isLoading ?? this.isLoading);
  }
}
