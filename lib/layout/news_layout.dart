


// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget
{
  
  Widget build(context)
  {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener:  (context, state) {
      },
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
      appBar: AppBar(title: Text('Newsy'),
      actions: [
         IconButton(onPressed: ()
        {
          NavigatTo(context, Search());
        }, icon: Icon(Icons.search)),
        IconButton(onPressed: ()
        {
          cubit.ChangeAppMode();
        }, icon: Icon(Icons.brightness_4_outlined)),
      ],),
      body: Column(
        children: [
            DefaultTabController(
              length: cubit.Items.length,
              child: TabBar(tabs: cubit.Items,
             labelStyle: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold) ,
             indicatorSize: TabBarIndicatorSize.label,
             indicatorWeight: 5,
              physics: BouncingScrollPhysics(),
              isScrollable: true,       
              padding: EdgeInsets.symmetric(horizontal: 8),  
              onTap: (value) 
              {
                cubit.ChangeTapBarState(value);
              } ,
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                width: double.infinity,
            //    color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  cubit.screens[cubit.screenIndex]
                ],)),
            ),
      ]),
    );
    }  
    );
  }
}