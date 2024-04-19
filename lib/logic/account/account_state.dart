part of 'account_cubit.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  final UserDataModel userDataModel;

  AccountSuccess({required this.userDataModel});
}

class AccountFailure extends AccountState {
  final String message;

  AccountFailure({required this.message});
}

class AccountLogout extends AccountState {
  final String message;

  AccountLogout({required this.message});
}
