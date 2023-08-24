// ignore: file_names
import 'package:flutter/cupertino.dart';
import '../../../models/doctorProfile_model.dart';

abstract class DataState {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final DoctorProfile doctorProfile;

  DataLoaded({@required this.doctorProfile});

  @override
  List<Object> get props => [doctorProfile];
}

class DataError extends DataState {
  final String errorMessage;

  DataError({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
