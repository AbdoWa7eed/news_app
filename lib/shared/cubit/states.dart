abstract class NewsStates {}
class NewsIntialState extends NewsStates{}
class NewsChangeTapBarState extends NewsStates{}
class NewsBusinessLoadingState extends NewsStates{}
class NewsBusinessSucssesState extends NewsStates{}
class NewsBusinessErrorState extends NewsStates{
  
  String? error;
  NewsBusinessErrorState(error);
}
class NewsSportsLoadingState extends NewsStates{}
class NewsSportsSucssesState extends NewsStates{}
class NewsSportsErrorState extends NewsStates{
  
  String? error;
  NewsSportsErrorState(error);
}
class NewsScienceLoadingState extends NewsStates{}
class NewsScienceSucssesState extends NewsStates{}
class NewsScienceErrorState extends NewsStates{
  
  String? error;
  NewsScienceErrorState(error);
}
class NewsTechLoadingState extends NewsStates{}
class NewsTechSucssesState extends NewsStates{}
class NewsTechErrorState extends NewsStates{
  
  String? error;
  NewsTechErrorState(error);
}
class NewsSreachLoadingState extends NewsStates{}
class NewsSreachSucssesState extends NewsStates{}
class NewsSreachErrorState extends NewsStates{
  
  String? error;
  NewsSreachErrorState(error);
}
class ChangeAppModeState extends NewsStates{}
