import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:how_to_use_sembast_db/data/dao/i_food_data_dao.dart';
import 'package:how_to_use_sembast_db/data/models/food_data.dart';
import 'package:how_to_use_sembast_db/data/services/random_food_data_generator.dart';
import 'package:kt_dart/kt.dart';

part 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  FoodCubit(this._foodDataDao) : super(FoodState.initial());

  Future<void> loadFoods() async {
    await _reloadFoods();
  }

  Future<void> addRandomFood() async {
    emit(state.copyWith(foodListOption: none(), isProcessing: true));
    final foodData = RandomFoodGenerator.getRandomFood();
    await _foodDataDao.insert(foodData);
    emit(state.copyWith(isProcessing: false));
    await _reloadFoods();
  }

  Future<void> deleteFood(FoodData foodData) async {
    emit(state.copyWith(foodListOption: none(), isProcessing: true));
    await _foodDataDao.delete(foodData);
    emit(state.copyWith(isProcessing: false));
    await _reloadFoods();
  }

  Future<void> updateWithRandomFood() async {
    emit(state.copyWith(foodListOption: none(), isProcessing: true));
    final foodList = await _foodDataDao.getAllSortedByName();
    if (foodList.isNotEmpty()) {
      final randomIndex = Random().nextInt(foodList.size);
      final randomFood = foodList[randomIndex];
      final updatedFood = randomFood.copyWith(isLiked: !randomFood.isLiked);
      await _foodDataDao.update(updatedFood);
    }
    emit(state.copyWith(isProcessing: false));
  }

  Future<void> _reloadFoods() async {
    emit(state.copyWith(isProcessing: true));
    final foods = await _foodDataDao.getAllSortedByName();
    emit(state.copyWith(foodListOption: some(foods), isProcessing: false));
  }

  final IFoodDataDao _foodDataDao;
}
