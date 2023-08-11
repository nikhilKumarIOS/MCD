abstract class DoctorDashboardState {}

class InitialDoctorDashboardState extends DoctorDashboardState {}

class LoadingDoctorDashboardState extends DoctorDashboardState {}

class BookedAppointmentsLoadedState extends DoctorDashboardState {
  final List<dynamic> combinedAppointments;

  BookedAppointmentsLoadedState(this.combinedAppointments);
}

class ErrorLoadingAppointmentsState extends DoctorDashboardState {
  final String errorMessage;

  ErrorLoadingAppointmentsState(this.errorMessage);
}
