import 'package:bloc/bloc.dart';
import 'package:flutter_fiers/Data/Models/countries_model.dart';
import 'package:flutter_fiers/Data/Repositories/countries_repo.dart';
import 'package:meta/meta.dart';
part 'countries_state.dart';
class CountriesCubit extends Cubit<CountriesState> {
  CountriesCubit() : super(CountriesInitial());
  CountriesRepo newsRepo = CountriesRepo();
  getCountries() async {
     emit(CountriesLoading());
    try {
      await newsRepo.getCountries().then((value) {
        if (value != null) {
          emit(CountriesSuccess(response: value));
        } else {
          emit(CountriesError());
        }
      });
    } catch (error) {
      emit(CountriesError());
    }
  }
}

