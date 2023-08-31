part of 'get_players_cubit.dart';

@immutable
sealed class GetPlayersState {}

final class GetPlayersInitial extends GetPlayersState {}

final class GetPlayersLoading extends GetPlayersState {}

final class GetPlayersSuccess extends GetPlayersState {
  final GetPLayersModel response;
  GetPlayersSuccess({required this.response});
}

final class GetPlayersError extends GetPlayersState {}
