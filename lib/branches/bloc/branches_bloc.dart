import 'package:flutter/material.dart';
import 'package:mutligenesys/branches/repository/branches_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../model/branches_model.dart';

class BranchesBloc
{
  final branchesRepository = BranchesRepository();

  final branchesFetcher = PublishSubject<BranchesModel>();

  Stream<BranchesModel> get branches => branchesFetcher.stream;

  fetchBranches(BuildContext context) async
  {
    BranchesModel branchesModel = await branchesRepository.fetchBranches(context);
    branchesFetcher.add(branchesModel);
  }

  dispose()
  {
    branchesFetcher.close();
  }
}

final branchesBloc = BranchesBloc();