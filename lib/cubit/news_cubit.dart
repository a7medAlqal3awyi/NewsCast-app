import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_project_name/core/constants/api_constants.dart';
import 'package:your_project_name/network/dio_helper.dart';

import '../view/business/business_screen.dart';
import '../view/health/health_screen.dart';
import '../view/sport/sport_screen.dart';
import '../view/tech/tech_screen.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  void changeIndexBottomNavBar(int index) {
    currentIndex = index;
    emit(ChangeIndexBottomNavBar());
  }

  List<Widget> screens = [
    const TechScreen(),
    const HealthScreen(),
    const BusinessScreen(),
    const SportsScreen(),
  ];

  List tech = [];

  getTech() {
    emit(GetTechLoadingNews());
    if (tech.isEmpty) {
      DioHelper.getData(endPoint: ApiConstants.topHeadlines, query: {
        'country': 'us',
        'category': 'technology',
        'apiKey': ApiConstants.apiKey,
      }).then((value) {
        tech = (value.data['articles'] as List).where((article) {
          // Filter out articles with null attributes
          return article['urlToImage'] != null &&
              article['title'] != null &&
              article['description'] != null &&
              article['url'] != null;
        }).toList();
        emit(GetTechSuccessNews());
      }).catchError((e) {
        emit(GetTechErrorNews());
      });
    } else {
      emit(GetTechSuccessNews());
    }
  }

  List business = [];

  getBusiness() {
    emit(GetBusinessLoadingNews());
    if (business.isEmpty) {
      DioHelper.getData(endPoint: ApiConstants.topHeadlines, query: {
        'country': 'us',
        'category': 'business',
        'apiKey': ApiConstants.apiKey,
      }).then((value) {
        business = (value.data['articles'] as List).where((article) {
          // Filter out articles with null attributes
          return article['urlToImage'] != null &&
              article['title'] != null &&
              article['url'] != null;
        }).toList();
        emit(GetBusinessSuccessNews());
      }).catchError((e) {
        emit(GetBusinessErrorNews());
      });
    } else {
      emit(GetBusinessSuccessNews());
    }
  }

  List sports = [];

  getSports() {
    emit(GetSportsLoadingNews());
    if (sports.isEmpty) {
      DioHelper.getData(endPoint: ApiConstants.topHeadlines, query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': ApiConstants.apiKey,
      }).then((value) {
        sports = (value.data['articles'] as List).where((article) {
          // Filter out articles with null attributes
          return article['urlToImage'] != null &&
              article['title'] != null &&
              article['url'] != null;
        }).toList();
        emit(GetSportsSuccessNews());
      }).catchError((e) {
        emit(GetSportsErrorNews());
      });
    } else {
      emit(GetSportsSuccessNews());
    }
  }

  List health = [];

  getHealth() {
    emit(HealthLoadingNews());
    if (health.isEmpty) {
      DioHelper.getData(endPoint: ApiConstants.topHeadlines, query: {
        'q': 'health',
        'apiKey': ApiConstants.apiKey,
      }).then((value) {
        health = (value.data['articles'] as List).where((article) {
          // Filter out articles with null attributes
          return article['urlToImage'] != null &&
              article['title'] != null &&
              article['url'] != null;
        }).toList();
        emit(HealthSuccessNews());
      }).catchError((error) {
        emit(HealthErrorNews());
      });
    }
  }
}
