import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mutligenesys/bottom_sheets.dart';
import 'package:mutligenesys/home/model/home_model.dart';

class HomeApiProvider
{
  Client client = Client();

  Future<HomeModel> fetchHomeData(BuildContext context) async
  {
    try
    {
      var response = await client.get(
        'https://5ea2d0c1b9f5ca00166c322a.mockapi.io/api/v1/home/'
      );

      if(response.statusCode == HttpStatus.ok)
        {
          return HomeModel.fromJson(jsonDecode(response.body));
        }
    }
    on SocketException catch (e)
    {
      BottomSheets().noInternetBottomSheet(context, () {
        Navigator.pop(context);

        /*
        * Call the method to fetch Results List
        * */
        fetchHomeData(context);
      });
    }
  }
}