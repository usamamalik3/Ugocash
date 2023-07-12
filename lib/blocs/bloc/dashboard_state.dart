abstract class DashboardState {}

class InitialDashboardState extends DashboardState {}

class LoadingDashboardState extends DashboardState {}

class SuccessDashboardState extends DashboardState {
  final String? email;
  final String? fundingId;
  final String? customerId;
  final String? balance;

  SuccessDashboardState(this.email, this.fundingId, this.customerId, this.balance);
}

class ErrorDashboardState extends DashboardState {
  final String errorMessage;

  ErrorDashboardState(this.errorMessage);
}
