import 'package:flutter/material.dart';
import 'package:mutligenesys/branches/model/branches_model.dart';

import 'branches_api_provider.dart';

class BranchesRepository
{
  final branchesApiProvider = BranchesApiProvider();

  Future<BranchesModel> fetchBranches(BuildContext context) => branchesApiProvider.fetchBranches(context);
}