
// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/business.dart';
import 'package:news_app/modules/science/science.dart';
import 'package:news_app/modules/sports/sports.dart';
import 'package:news_app/modules/tech/tech.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/shared_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsIntialState());
  List<Widget> screens = [Business() , Sports() , Science() , Tech()];
  List<Widget> Items = [
      Tab(text: 'Business'),
      Tab(text: 'Sports'),
      Tab(text: 'Science'),
      Tab(text: 'Technology'),
  ];
  int screenIndex = 0;
  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];
  List<dynamic> tech = [];
  bool isDark = false;
  static NewsCubit get(context) => BlocProvider.of(context);
  void ChangeAppMode({bool? fromShared})
  {
    if(fromShared != null)
    {
       isDark = fromShared;
       print('1');
       emit(ChangeAppModeState());
    }
    else 
    {
      isDark = !isDark;
      SharedHalper.putbool(key : 'isDark' , value: isDark).then((value)
      {
         emit(ChangeAppModeState());
      }).catchError((onError)
      {
        print('Error While Sharing data : $onError');
      });
     
    } 
  }
  void ChangeTapBarState(index)
  {
    screenIndex = index;
    if(index == 1)
    getSportData();
    else if(index == 2)
    getScienceData();
    else if(index == 3)
    getTechData();
    else 
    getBussinesData();
    emit(NewsChangeTapBarState());
  }
  void getBussinesData()
  {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country' : 'eg',
      'category' : 'business',
      'apiKey' : '1a3d839585cb422d885c58f2a71564d4'

    }).then((value)
    {
      business = value.data['articles'];
      emit(NewsBusinessSucssesState());
      }).catchError((onError)
    {
      print('Error While Getting : $onError');
      emit(NewsBusinessErrorState(onError));
    });
  }
  void getSportData()
  {
    emit(NewsSportsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country' : 'eg',
      'category' : 'sports',
      'apiKey' : '1a3d839585cb422d885c58f2a71564d4'

    }).then((value)
    {
      sports = value.data['articles'];
      emit(NewsSportsSucssesState());
      }).catchError((onError)
    {
      print('Error While Getting : $onError');
      emit(NewsSportsErrorState(onError));
    });
  }
  void getScienceData()
  {
    emit(NewsScienceLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country' : 'eg',
      'category' : 'science',
      'apiKey' : '1a3d839585cb422d885c58f2a71564d4'

    }).then((value)
    {
      science = value.data['articles'];
      emit(NewsScienceSucssesState());
      }).catchError((onError)
    {
      print('Error While Getting : $onError');
      emit(NewsScienceErrorState(onError));
    });
  }
  void getTechData()
  {
    emit(NewsTechLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country' : 'eg',
      'category' : 'technology',
      'apiKey' : '1a3d839585cb422d885c58f2a71564d4'

    }).then((value)
    {
      tech = value.data['articles'];
      emit(NewsTechSucssesState());
      }).catchError((onError)
    {
      print('Error While Getting : $onError');
      emit(NewsTechErrorState(onError));
    });
  }
  void getSearchData(
{
  required String searched
}
  )
  {

    emit(NewsSreachLoadingState());
    search = [];
    DioHelper.getData(url: "v2/everything", query: {
      'q' : '$searched',
      'apiKey': '1a3d839585cb422d885c58f2a71564d4',
    }).then((value)
    {
      search = value.data['articles'];
      emit(NewsSreachSucssesState());
      }).catchError((onError)
    {
      print('Error While Searching : $onError');
      emit(NewsSreachErrorState(onError));
    });
  }
}