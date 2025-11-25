import 'package:equatable/equatable.dart';
import '../../../models/user_model.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserError extends UserState {
  final String message;
  UserError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserListLoaded extends UserState {
  final List<UserModel> users;
  UserListLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class UserDetailLoaded extends UserState {
  final UserModel user;
  UserDetailLoaded(this.user);

  @override
  List<Object?> get props => [user];
}
