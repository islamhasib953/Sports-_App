part of 'countries_cubit.dart';
@immutable
sealed class CountriesState {}
final class CountriesInitial extends CountriesState {}
final class CountriesLoading extends CountriesState {}
final class CountriesSuccess extends CountriesState {
  final CountriesModel response;
  CountriesSuccess({required this.response});
}
final class CountriesError extends CountriesState {}
