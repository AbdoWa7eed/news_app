// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:news_app/modules/web_veiw/web_veiw.dart';
import 'package:news_app/shared/cubit/cubit.dart';

Widget DefFormFild(
    {required TextEditingController controller,
    required TextInputType keyType,
    required String lable,
    ValueChanged<String>? onChange,
    ValueChanged<String>? onSubmit,
    bool isShow = false,
    Icon? Prefix,
    Widget? Suffix,
    GestureTapCallback? onTap,
    double radius = 50,
    required String? Function(String?)? validator,
    bool isDark = false}) {
  return TextFormField(
    onChanged: onChange,
    validator: validator,
    controller: controller,
    style: TextStyle(color: isDark ? Colors.white : Colors.black),
    decoration: InputDecoration(
        labelText: lable,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        prefixIcon: Prefix,
        suffixIcon: Suffix),
    obscureText: isShow,
    keyboardType: keyType,
    onFieldSubmitted: onSubmit,
    onTap: onTap,
  );
}

Widget BuildScreenItem(list, context, isDark) {
  String url;
  if (list['urlToImage'] == null || list['urlToImage'] == "") {
    url =
        "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg";
  } else {
    url = list['urlToImage'];
  }
  return InkWell(
    onTap: () {
      NavigatTo(context, WebVeiwScreen(list['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shadowColor: isDark ? Colors.grey : Colors.grey[900],
        color: isDark ? Colors.grey[900] : Colors.white,
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              height: 150,
              width: double.infinity,
              image: NetworkImage(url),
              fit: BoxFit.fill,
            ),
            Container(
              color: isDark ? Colors.grey[900] : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${list['title']}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: NewsCubit.get(context).isDark
                                ? Colors.white
                                : Colors.black)),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(Icons.date_range_outlined),
                        SizedBox(
                          width: 20,
                        ),
                        Text('2022-07-30T12:57:00Z'),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget BuildScreenList(List<dynamic> list, context, isDark) {
  return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: ((context, index) {
        return BuildScreenItem(list[index], context, isDark);
      }),
      separatorBuilder: ((context, index) {
        return SizedBox(
          height: 10,
        );
      }),
      itemCount: list.length);
}

void NavigatTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return widget;
    }),
  );
}
