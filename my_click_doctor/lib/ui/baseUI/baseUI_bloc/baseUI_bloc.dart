import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_click_doctor/models/doctorProfile_model.dart';
import '../../../services/api.dart';

import 'baseUI_events.dart';
import 'baseUI_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final ApiService apiService;

  DataBloc({@required this.apiService}) : super(DataInitial()) {
    on<GetDataEvent>((event, emit) => _mapGetDataEventToState(emit));
  }

  void _mapGetDataEventToState(Emitter<DataState> emit) async {
    emit(DataLoading());

    try {
      final Map<String, dynamic> apiResponse =
          await apiService.fetchDoctorProfile();
      final DoctorProfile doctorProfile = DoctorProfile.fromJson(apiResponse);
      emit(DataLoaded(doctorProfile: doctorProfile));
    } catch (error) {
      emit(DataError(errorMessage: 'Failed to load data: $error'));
    }
  }
}
