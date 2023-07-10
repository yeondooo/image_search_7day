import 'package:flutter/material.dart';
import 'package:image_search_7day/core/result.dart';
import 'package:image_search_7day/domain/use_case/get_top_five_most_viewd_image_use_case.dart';
import 'package:image_search_7day/presentation/main/main_state.dart';

class MainViewModel with ChangeNotifier {
  final GetTopFiveMoseViewdImageUseCase _getTopFiveMoseViewdImageUseCase;

  MainViewModel(this._getTopFiveMoseViewdImageUseCase);

  MainState _state = const MainState();

  MainState get state => _state;

  void fetchImages(String query) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final result = await _getTopFiveMoseViewdImageUseCase.execute(query);

    switch (result) {
      case Success(:final data):
        _state = state.copyWith(photos: data, isLoading: false);
        notifyListeners();
      case Error(:final e):
        _state = state.copyWith(isLoading: false);
    }
  }
}
