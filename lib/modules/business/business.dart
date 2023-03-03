// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class Business extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
      var cubit = NewsCubit.get(context);
      var list = cubit.business;
      return ConditionalBuilder(
        condition: list.isNotEmpty,
        builder: (context) 
        { 
          return Expanded(child: BuildScreenList(list , context , cubit.isDark));
        },
        fallback: (context)
        {
          return CircularProgressIndicator();
        });
    },
     listener: (context, state) {
       
     },);
  }
}