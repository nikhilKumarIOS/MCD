import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../services/api.dart';
import 'home_events.dart';
import 'home_state.dart';
import 'package:rxdart/rxdart.dart';

class DoctorDashboardBloc {
  final _stateController = BehaviorSubject<DoctorDashboardState>();
  final ApiService _apiService = ApiService();

  Stream<DoctorDashboardState> get stateStream => _stateController.stream;

  DoctorDashboardBloc() {
    _stateController.add(InitialDoctorDashboardState());
  }

  void fetchRecommendedAndBookedAppointments() async {
    try {
      _stateController.add(LoadingDoctorDashboardState());

      final recommendedAppointments =
          await _apiService.getRecommendAppointment();
      final bookedAppointments = await _apiService.getBookedAppointments();

      final combinedAppointments =
          List.from(recommendedAppointments['specializationCategory'])
            ..addAll(bookedAppointments['specializationCategory']);

      _stateController.add(BookedAppointmentsLoadedState(combinedAppointments));
    } catch (error) {
      _stateController.add(ErrorLoadingAppointmentsState(error.toString()));
    }
  }

  void dispose() {
    _stateController.close();
    _apiService.dispose();
  }
}

// Import other necessary classes...

// ... Other imports ...

// class DoctorDashboardBloc
//     extends Bloc<DoctorDashboardEvent, DoctorDashboardState> {
//   final ApiService _apiService = ApiService();

//   DoctorDashboardBloc() : super(InitialDoctorDashboardState()) {
//     on<FetchRecommendedAndBookedAppointmentsEvent>((event, emit) async {
//       try {
//         emit(LoadingDoctorDashboardState());

//         final recommendedAppointments =
//             await _apiService.getRecommendAppointment();
//         final bookedAppointments = await _apiService.getBookedAppointments();

//         final combinedAppointments =
//             List.from(recommendedAppointments['specializationCategory'])
//               ..addAll(bookedAppointments['specializationCategory']);

//         emit(BookedAppointmentsLoadedState(combinedAppointments));
//       } catch (error) {
//         emit(ErrorLoadingAppointmentsState(error.toString()));
//       }
//     });
//   }

//   @override
//   Future<void> close() {
//     _apiService.dispose();
//     return super.close();
//   }
// }
