import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class JobState extends Equatable {
  final bool isLoading;

  const JobState({required this.isLoading});

  const JobState.initial({this.isLoading = false});

  @override
  List<Object> get props => [isLoading];

  @override
  bool get stringify => true;

  JobState copyWith({bool? isLoading}) {
    return JobState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
