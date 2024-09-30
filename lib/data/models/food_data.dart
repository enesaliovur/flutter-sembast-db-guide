import 'dart:convert';

import 'package:equatable/equatable.dart';

class FoodData extends Equatable {
  final int? id;
  final String name;
  final bool isLiked;

  const FoodData({
    this.id,
    required this.name,
    required this.isLiked,
  });

  FoodData copyWith({
    int? id,
    String? name,
    bool? isLiked,
  }) {
    return FoodData(
      id: id ?? this.id,
      name: name ?? this.name,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'is_liked': isLiked});
    result.addAll({'id': id});

    return result;
  }

  factory FoodData.fromMap(Map<String, dynamic> map) {
    return FoodData(
      name: map['name'] as String,
      isLiked: map['is_liked'] as bool,
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodData.fromJson(String source) =>
      FoodData.fromMap(json.decode(source));

  @override
  List<Object?> get props => [name, isLiked];

  @override
  bool? get stringify => true;
}
