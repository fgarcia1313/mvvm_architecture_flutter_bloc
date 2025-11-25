import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_event.dart';
import 'user_state.dart';
import '../../../services/user_service.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;

  UserBloc(this.userService) : super(UserInitial()) {
    // 1. Obtener todos los usuarios
    on<LoadUsers>(_onLoadUsers);

    // 2. Obtener usuario por ID
    on<LoadUserById>(_onLoadUserById);

    // Simulación de onInit()
    add(LoadUsers());
  }

  // ---------------------------
  // 1. Cargar todos los usuarios
  // ---------------------------
  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final result = await userService.getAllUsers();
      emit(UserListLoaded(result));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  // ---------------------------
  // 2. Cargar usuario por ID
  // ---------------------------
  Future<void> _onLoadUserById(LoadUserById event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final user = await userService.getUserById(event.id);
      emit(UserDetailLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
