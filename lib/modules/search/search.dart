

// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class Search extends StatelessWidget {
var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
      return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        var list = cubit.search;
        return Scaffold(
           appBar: AppBar(title: Text('News App')),
           body: Column(
            children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 50,
                child: DefFormFild(
                  onChange: (value) 
                  {
                    if(searchController.text != "")
                        cubit.getSearchData(searched: searchController.text);
                  },
                      isDark: cubit.isDark,
                      controller: searchController,
                     keyType: TextInputType.text,
                      lable: 'search',
                      Prefix: Icon(Icons.search),
                      validator: (value)
                      {
                        if(value!.isEmpty)
                        return "Search  mustn't be Empty";
                      }),
              ),
            ),
            SizedBox(height: 5,),
            ConditionalBuilder(
            condition: searchController.text.isNotEmpty,
             builder: (context) {
               return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     (state is NewsSreachLoadingState)? CircularProgressIndicator() 
                      :  Expanded(child: BuildScreenList(list, context, cubit.isDark ))
                  ],
                ));
             },
             fallback: (context) {
               return Expanded(
                 child: Center(
                  child: Container(child: 
                  Text('No Searched Items' , style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),)),
                 ),
               );
             },
            ),
           ]),
        );
      } , listener: (context, state) {
        
      });
}
}