import 'package:bloc/bloc.dart';
import 'package:flutter_fiers/Data/Models/leaguesmodel.dart';
import 'package:flutter_fiers/Data/Repositories/leaguesRepo.dart';
import 'package:meta/meta.dart';

part 'leagues_state.dart';

class LeaguesCubit extends Cubit<LeaguesState> {
  LeaguesCubit() : super(LeaguesInitial());

  LeaguesRepo Getleagues =LeaguesRepo();
  leagues(int id) async {
    emit(Loading());

    try {
      await Getleagues.leagues(id).then((value) {
        if (value != null) {
          emit(Success(response : value));
        } else {
          emit(Error());
        }
      });
    } catch (error) {
      emit(Error());
    }
}
}