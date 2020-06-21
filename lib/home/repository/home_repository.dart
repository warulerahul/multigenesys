import 'package:flutter/material.dart';
import 'package:mutligenesys/home/model/home_model.dart';
import 'package:mutligenesys/home/repository/home_api_provider.dart';

class HomeRepository
{
  final homeApiProvider = HomeApiProvider();

  Future<HomeModel> fetchHome(BuildContext context) => homeApiProvider.fetchHomeData(context);
}