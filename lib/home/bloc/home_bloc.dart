import 'package:flutter/material.dart';
import 'package:mutligenesys/home/model/home_model.dart';
import 'package:mutligenesys/home/repository/home_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc
{
  final homeRepository = HomeRepository();

  final homeFetcher = PublishSubject<HomeModel>();

  Stream<HomeModel> get home => homeFetcher.stream;

  fetchHome(BuildContext context) async
  {
    HomeModel homeModel = await homeRepository.fetchHome(context);
    homeFetcher.add(homeModel);
  }

  dispose()
  {
    homeFetcher.close();
  }
}

final homeBloc = HomeBloc();