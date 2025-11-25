import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUsers extends UserEvent {}

class LoadUserById extends UserEvent {
  final int id;
  LoadUserById(this.id);

  @override
  List<Object?> get props => [id];
}
