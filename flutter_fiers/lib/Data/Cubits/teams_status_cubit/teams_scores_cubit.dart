import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../screens/teams.dart';
import '../../models/tems_model/tems_model.dart';
import '../../models/top_scorers_model/top_scorers_model.dart';
import '../../repositories/teams_repo/team_repo.dart';
import '../../repositories/top_scorers_repo/topscorers_repo.dart';
part 'teams_scores_state.dart';

class TeamsScoresCubit extends Cubit<TeamsScoresState> {
  TeamsScoresCubit() : super(TeamsScoresInitial());

  getTeam(int id) {
    TeamsScorer().getTeams(search.text, id).then((value) {
      if (value != null) emit(TeamsScoresTeams(ourresponse: value));
    });
  }

  getTopScorers(int id) {
    TopScorer().getTopScorers(id).then((value) {
      if (value != null) emit(TeamsScoresTopScorers(response: value));
    });
  }
}
