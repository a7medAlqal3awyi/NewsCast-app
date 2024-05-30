import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:your_project_name/cubit/news_cubit.dart';
import 'package:your_project_name/cubit/news_state.dart';

import 'core/routting/routes.dart';
import 'core/routting/routting.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getTech()..getBusiness()..getSports()..getHealth(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return const ScreenUtilInit(
            designSize: Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.layout,
              onGenerateRoute: AppRouter.generateRoute,
            ),
          );
        },
      ),
    );
  }
}
