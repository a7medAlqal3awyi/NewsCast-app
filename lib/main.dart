import 'package:flutter/material.dart';

import 'network/dio_helper.dart';
import 'news_app.dart';

void main() async{
  DioHelper.init();

  runApp(const NewsApp());
}

