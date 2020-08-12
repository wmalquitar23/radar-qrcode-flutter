import 'package:bloc/bloc.dart';

enum SelectedRegistrationType { Individual, Establishment }

class GettingstartedCubit extends Cubit<SelectedRegistrationType> {
  GettingstartedCubit() : super(SelectedRegistrationType.Individual);

  void toggleSelectedRegistrationType() {
    if (state == SelectedRegistrationType.Individual) {
      emit(SelectedRegistrationType.Establishment);
    } else {
      emit(SelectedRegistrationType.Individual);
    }
  }
}
