part of 'food_cubit.dart';

class FoodState extends Equatable {
  const FoodState({
    required this.foodListOption,
    required this.isProcessing,
  });

  final Option<KtList<FoodData>> foodListOption;
  final bool isProcessing;

  factory FoodState.initial() => FoodState(
        foodListOption: none(),
        isProcessing: false,
      );

  @override
  List<Object> get props => [foodListOption, isProcessing];

  FoodState copyWith({
    Option<KtList<FoodData>>? foodListOption,
    bool? isProcessing,
  }) {
    return FoodState(
      foodListOption: foodListOption ?? this.foodListOption,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}
