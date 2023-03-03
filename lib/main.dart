// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/components/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/shared_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:universal_platform/universal_platform.dart';

void main()  {
  BlocOverrides.runZoned(
    ()  async {
    WidgetsFlutterBinding.ensureInitialized();
    bool isDesketop = UniversalPlatform.isDesktop;
    bool isMac = UniversalPlatform.isMacOS;
    if(isMac || isDesketop)
    {
      await DesktopWindow.setMinWindowSize(Size(700, 650));
    }
      DioHelper.init();
      await SharedHalper.init();
      bool? isDark = SharedHalper.getBool("isDark");
      runApp(MyApp(isDark));  
    },
    blocObserver: MyBlocObserver(),
  ); 
}

class MyApp extends StatelessWidget {
  bool? isDark;
    MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context) => NewsCubit()..getBussinesData()..ChangeAppMode(fromShared: isDark), 
    child: BlocConsumer<NewsCubit , NewsStates>(
      listener: (context, state) {
        },
      builder: (context, state) {
        return  MaterialApp(
      themeMode: NewsCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
        tabBarTheme: TabBarTheme(labelColor: Colors.white,),
        appBarTheme: AppBarTheme(
         color: Colors.black38,
         iconTheme: IconThemeData(color: Colors.white),
         titleTextStyle: TextStyle(color: Colors.white , fontSize: 25 , fontWeight: FontWeight.bold),
          elevation: 0,
          brightness: Brightness.dark,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black38 ,
         statusBarIconBrightness: Brightness.light),
          foregroundColor: Colors.black
        ),
        scaffoldBackgroundColor: Colors.black38,
        inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: Colors.white,
        fillColor: Colors.grey[900],
         iconColor: Colors.white,
         enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Colors.deepOrange)
                  ),
         labelStyle: TextStyle(color: Colors.white),
          filled: true
        ),
        fixTextFieldOutlineLabel: true,
      primarySwatch: Colors.deepOrange,    
      primaryTextTheme: TextTheme(bodySmall: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
            bodyText2: TextStyle(color: Colors.white),
                  bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
        )),
        ),
      debugShowCheckedModeBanner: false,
      title: 'Newsy',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.black,
            fontSize: 25 , fontWeight: FontWeight.bold),
          brightness: Brightness.dark,
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white ),
          foregroundColor: Colors.black
        ),
        scaffoldBackgroundColor: Colors.white,
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black
        ),
        textTheme: TextTheme(
                    bodyText1: TextStyle(
                  color: NewsCubit.get(context).isDark ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
        )),
        ),
      home: NewsLayout(),
      
    );
      },
    ));
  }
}
