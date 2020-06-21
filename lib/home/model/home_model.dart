class HomeModel
{
  String message;
  UserData userData;
  List<Ads> adsList;
  List<Subjects> subjectsList;
  List<Universities> universityList;

  HomeModel.fromJson(Map<dynamic, dynamic> json)
  {
    message = json['message'];

    userData = UserData.fromJson(json['data']['profile']);

    List<Ads> tempAdsList = [];
    for(int i = 0; i < json['data']['ads'].length; i++)
      {
        Ads ads = Ads(json['data']['ads'][i]);
        tempAdsList.add(ads);
      }
    adsList = tempAdsList;

    List<Subjects> tempSubjectsList = [];
    for(int i = 0; i < json['data']['subjects'].length; i++)
      {
        Subjects subjects = Subjects(json['data']['subjects'][i]);
        tempSubjectsList.add(subjects);
      }
    subjectsList = tempSubjectsList;

    List<Universities> tempUniversityList = [];
    for(int i = 0; i < json['data']['universities'].length; i++)
      {
        Universities universities = Universities(json['data']['universities'][i]);
        tempUniversityList.add(universities);
      }
    universityList = tempUniversityList;
  }
}

class UserData
{
  String name;

  UserData.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
  }
}

class Ads
{
  String imageUrl;

  Ads(ads)
  {
    imageUrl = ads['url'];
  }
}

class Subjects
{
  String subjectName;

  Subjects(subjects)
  {
    subjectName = subjects['subjectName'];
  }
}

class Universities
{
  String universityName;

  Universities(universities)
  {
    universityName = universities['name'];
  }
}