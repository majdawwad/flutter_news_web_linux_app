abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavBarState extends NewsStates {}

//Business
class NewsChangeIsLoadingDataBuisnessState extends NewsStates {}

class NewsChangeGetDataBuisnessSuccessState extends NewsStates {}

class NewsSlectedBusinessItemState extends NewsStates {}

class NewsDesktopSelectedBusinessState extends NewsStates {}

class NewsChangeGetDataBuisnessErrorState extends NewsStates {
  final String error;

  NewsChangeGetDataBuisnessErrorState(this.error);
}

//Sports
class NewsChangeIsLoadingDataSportsState extends NewsStates {}

class NewsChangeGetDataSportsSuccessState extends NewsStates {}

class NewsChangeGetDataSportsErrorState extends NewsStates {
  final String error;

  NewsChangeGetDataSportsErrorState(this.error);
}

//Sciences
class NewsChangeIsLoadingDataSciencesState extends NewsStates {}

class NewsChangeGetDataSciencesSuccessState extends NewsStates {}

class NewsChangeGetDataSciencesErrorState extends NewsStates {
  final String error;

  NewsChangeGetDataSciencesErrorState(this.error);
}

//Health
class NewsChangeIsLoadingDataHealthState extends NewsStates {}

class NewsChangeGetDataHealthSuccessState extends NewsStates {}

class NewsChangeGetDataHealthErrorState extends NewsStates {
  final String error;

  NewsChangeGetDataHealthErrorState(this.error);
}

//Technologies
class NewsChangeIsLoadingDataTechnologiesState extends NewsStates {}

class NewsChangeGetDataTechnologiesSuccessState extends NewsStates {}

class NewsChangeGetDataTechnologiesErrorState extends NewsStates {
  final String error;

  NewsChangeGetDataTechnologiesErrorState(this.error);
}

//Search
class NewsChangeIsLoadingDataSearchState extends NewsStates {}

class NewsChangeGetDataSearchSuccessState extends NewsStates {}

class NewsChangeGetDataSearchErrorState extends NewsStates {
  final String error;

  NewsChangeGetDataSearchErrorState(this.error);
}
