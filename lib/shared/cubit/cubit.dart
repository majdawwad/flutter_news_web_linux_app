import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_web_linux_app/modules/bisness_screen/business_screen.dart';
import 'package:news_web_linux_app/modules/health_screen/health_screen.dart';
import 'package:news_web_linux_app/modules/sciences_screen/sciences_screen.dart';
import 'package:news_web_linux_app/modules/sports_screen/sports_screen.dart';
import 'package:news_web_linux_app/modules/technology_screen/technology_screen.dart';
import 'package:news_web_linux_app/shared/cubit/states.dart';
import 'package:news_web_linux_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> botomItem = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'الأعمال',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'الرياضة',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'العلوم',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.health_and_safety,
      ),
      label: 'الصحة',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.computer,
      ),
      label: 'التكنولوجيا',
    ),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const SciencesScreen(),
    const HealthScreen(),
    const TechnologyScreen(),
   
  ];

  void changebottomnavbar({
    required int index,
  }) {
    currentIndex = index;
    if (index == 1) {
      getDataSports();
    } else if (index == 2) {
      getDataSciences();
    } else if (index == 3) {
      getDataHealths();
    } else if (index == 4) {
      getDataTechnologies();
    }
    emit(NewsBottomNavBarState());
  }

  List<dynamic> business = [];
  int selectedCollectionItem = 0;
  bool isDesktopSelectedCollection = false;

  void selectedCollectionItems(index) {
    selectedCollectionItem = index;
    emit(NewsSlectedBusinessItemState());
  }

  void desktopSelectedCollections(bool value) {
    isDesktopSelectedCollection = value;
    emit(NewsDesktopSelectedBusinessState());
  }

  void getDataBuisness() {
    emit(NewsChangeIsLoadingDataBuisnessState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'f065031db4da4aa7b0604e970821bec0',
      },
    ).then((value) {
      business = value.data['articles'];

      emit(NewsChangeGetDataBuisnessSuccessState());
    }).catchError((error) {
      emit(NewsChangeGetDataBuisnessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getDataSports() {
    //emit(NewsChangeIsLoadingDataSportsState());

    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': 'f065031db4da4aa7b0604e970821bec0',
        },
      ).then((value) {
        sports = value.data['articles'];

        emit(NewsChangeGetDataSportsSuccessState());
      }).catchError((error) {
        emit(NewsChangeGetDataSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsChangeIsLoadingDataSportsState());
    }
  }

  List<dynamic> sciences = [];

  void getDataSciences() {
    if (sciences.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': 'f065031db4da4aa7b0604e970821bec0',
        },
      ).then((value) {
        sciences = value.data['articles'];

        emit(NewsChangeGetDataSciencesSuccessState());
      }).catchError((error) {
        emit(NewsChangeGetDataSciencesErrorState(error.toString()));
      });
    } else {
      emit(NewsChangeIsLoadingDataSciencesState());
    }
  }

  List<dynamic> healths = [];

  void getDataHealths() {
    if (healths.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'health',
          'apiKey': 'f065031db4da4aa7b0604e970821bec0',
        },
      ).then((value) {
        healths = value.data['articles'];

        emit(NewsChangeGetDataHealthSuccessState());
      }).catchError((error) {
        emit(NewsChangeGetDataHealthErrorState(error.toString()));
      });
    } else {
      emit(NewsChangeIsLoadingDataHealthState());
    }
  }

  List<dynamic> technologies = [];

  void getDataTechnologies() {
    if (technologies.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'technology',
          'apiKey': 'f065031db4da4aa7b0604e970821bec0',
        },
      ).then((value) {
        technologies = value.data['articles'];

        emit(NewsChangeGetDataTechnologiesSuccessState());
      }).catchError((error) {
        emit(NewsChangeGetDataTechnologiesErrorState(error.toString()));
      });
    } else {
      emit(NewsChangeIsLoadingDataTechnologiesState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsChangeIsLoadingDataSearchState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': 'f065031db4da4aa7b0604e970821bec0',
      },
    ).then((value) {
      search = value.data['articles'];

      emit(NewsChangeGetDataSearchSuccessState());
    }).catchError((error) {
      emit(NewsChangeGetDataSearchErrorState(error.toString()));
    });
  }
}
