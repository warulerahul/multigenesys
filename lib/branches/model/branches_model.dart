class BranchesModel
{
  String message;

  List<BranchesData> branchesDataList;

  BranchesModel.fromJson(Map<String, dynamic> json)
  {
    message = json['message'];

    List<BranchesData> tempBranchesDataList = [];
    for(int i = 0; i < json['data'].length; i++)
      {
        BranchesData branchesData = BranchesData(json['data'][i]);
        tempBranchesDataList.add(branchesData);
      }
    branchesDataList = tempBranchesDataList;
  }
}

class BranchesData
{
  int id;
  String branchName, imageUrl, courseId;
  bool isActive;

  BranchesData(branchesData)
  {
    id = branchesData['id'];
    branchName = branchesData['branchName'];
    imageUrl = branchesData['image'];
    courseId = branchesData['courseId'];
    isActive = branchesData['active'];
  }
}