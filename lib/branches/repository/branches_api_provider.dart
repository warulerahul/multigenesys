
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:mutligenesys/branches/model/branches_model.dart';

import '../../bottom_sheets.dart';

class BranchesApiProvider
{
  Client client = Client();

  Future<BranchesModel> fetchBranches(BuildContext context) async
  {
    try
    {
      var response = await client.get(
        'https://5ea2d0c1b9f5ca00166c322a.mockapi.io/api/v1/subjects'
      );

      if(response.statusCode == HttpStatus.ok)
        {
          return BranchesModel.fromJson(jsonDecode(response.body));
        }
    }
    on SocketException catch (e)
    {
      BottomSheets().noInternetBottomSheet(context, () {
        Navigator.pop(context);

        /*
        * Call the method to fetch Results List
        * */
        fetchBranches(context);
      });
    }
  }
}