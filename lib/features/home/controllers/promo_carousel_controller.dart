import 'dart:async';
import 'package:flutter/material.dart';

class PromoCarouselController extends ChangeNotifier {
  final PageController pageController = PageController();

  Timer? _timer;
  int _currentPage = 0;
  int _totalBanners = 0;

  int get currentPage => _currentPage;

  void initTimer(int totalItems) {
    _totalBanners = totalItems;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(milliseconds: 4500), (timer) {
      if (_totalBanners == 0 || !pageController.hasClients) {
        return;
      }

      _currentPage = (_currentPage + 1) % _totalBanners;

      pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

      notifyListeners();
    });
  }

  void updatePage(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void goToPage(int index) {
    _currentPage = index;

    if (pageController.hasClients) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    pageController.dispose();
    super.dispose();
  }
}
