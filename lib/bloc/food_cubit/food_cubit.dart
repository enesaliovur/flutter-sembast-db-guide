import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  FoodCubit() : super(FoodInitial());

  Future<void> loadFoods() async {
    return;
  }

  Future<void> addRandomFood() async {
    return;
  }

  Future<void> updateWithRandomFood() async {
    return;
  }
}
