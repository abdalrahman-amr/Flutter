abstract class NewsStates{}

class NewsInitialState extends NewsStates{}
class NewsBotNavChangeState extends NewsStates{}


class NewsGetBusinessLoadingState extends NewsStates{}
class NewsGetBusinessSuccessState extends NewsStates{}
class NewsGetBusinessFailureState extends NewsStates{


  late final String error;
  NewsGetBusinessFailureState(this.error);
}


class NewsGetSportsLoadingState extends NewsStates{}
class NewsGetSportsSuccessState extends NewsStates{}
class NewsGetSportsFailureState extends NewsStates{


  late final String error;
  NewsGetSportsFailureState(this.error);
}

class NewsGetScienceLoadingState extends NewsStates{}
class NewsGetScienceSuccessState extends NewsStates{}
class NewsGetScienceFailureState extends NewsStates{


  late final String error;
  NewsGetScienceFailureState(this.error);
}


class NewsGetSearchLoadingState extends NewsStates{}
class NewsGetSearchSuccessState extends NewsStates{}
class NewsGetSearchFailureState extends NewsStates{


  late final String error;
  NewsGetSearchFailureState(this.error);
}

