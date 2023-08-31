part of 'leagues_cubit.dart';

@immutable
sealed class LeaguesState {}

final class LeaguesInitial extends LeaguesState {}
final class Loading extends LeaguesState {}
final class Success extends LeaguesState {
  final LeaguesModel response;
  Success({required this.response});
}
final class Error extends LeaguesState {}
