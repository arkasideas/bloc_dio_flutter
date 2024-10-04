import 'package:bloc_dio/data/datasource/remote_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final RemoteDatasource remoteDataSource;
  UserBloc({required this.remoteDataSource}) : super(UserInitial()) {
    on<LoadUser>((event, emit) async {
      emit(UserLoading());
      try{
        final result = await remoteDataSource.getUsers();
        emit(UserLoaded(result.data));
      }
      catch(e){
        emit(UserError(e.toString()));
      }
    });
  }
}
