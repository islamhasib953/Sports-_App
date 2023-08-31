import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fiers/Data/Models/get_players_model.dart';
import 'package:flutter_fiers/Data/Repositories/get_playersrepo.dart';

part 'get_players_state.dart';

class GetPlayersCubit extends Cubit<GetPlayersState> {
  GetPlayersCubit() : super(GetPlayersInitial());

  GetPlayersRepo playersRepo = GetPlayersRepo();

  getPlayers() async {
    emit(GetPlayersLoading());

    try {
      await playersRepo.getplayers().then((value) {
        if (value != null) {
          emit(GetPlayersSuccess(response: value));
        } else {
          emit(GetPlayersError());
        }
      });
    } catch (error) {
      emit(GetPlayersError());
    }
  }
}
