import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:mutligenesys/branches/bloc/branches_bloc.dart';
import 'package:mutligenesys/branches/model/branches_model.dart';
import 'package:mutligenesys/home/bloc/home_bloc.dart';
import 'package:mutligenesys/home/model/home_model.dart';
import 'package:mutligenesys/home/model/home_model.dart';
import 'package:mutligenesys/home/model/home_model.dart';
import 'package:random_color/random_color.dart';
import 'package:snaplist/snaplist.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  /*
  * Global Instance of Integer Variables
  * */
  int _selectPage = 0;

  @override
  void initState() {
    /*
    * Fetch Dashboard Data
    * */
    homeBloc.fetchHome(context);

    /*
    * Fetch Branches Data
    * */
    new Future.delayed(new Duration(seconds: 2), () {
      branchesBloc.fetchBranches(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            'Dashboard',
            style: TextStyle(fontFamily: 'Productsans', color: Colors.black),
          ),
        ),
        body: Container(
            color: Colors.white,
            child: StreamBuilder(
              stream: homeBloc.home,
              builder: (context, AsyncSnapshot<HomeModel> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return LinearProgressIndicator();

                  if (snapshot.connectionState == ConnectionState.active) {
                    return loadDashboardData(snapshot.data);
                    //return Container();
                  }
                }
                else if (snapshot.hasError)
                  return Text('Something went wrong!', style: TextStyle(
                      fontFamily: 'ProductSans', fontSize: 26.0),);

                return LinearProgressIndicator();
              },
            )
        ),
        bottomNavigationBar: BottomNavigationBar(
        onTap: (int index){
          setState(() {
            _selectPage = index;
          });
        },
        currentIndex: _selectPage,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home,),
            title: new Text('Home',
              style: TextStyle(fontSize: 14.0,fontFamily: 'Productsans'),),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.book,
            ),
            title: new Text('Ebook',
              style: TextStyle(fontSize: 14.0,fontFamily: 'Productsans'),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ondemand_video,
            ),
            title: Text('My Course',
              style: TextStyle(fontSize: 14.0,fontFamily: 'Productsans'),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,
            ),
            title: Text('Settings',
              style: TextStyle(fontSize: 12.0,fontFamily: 'productsans'),),
          ),
        ],
      ),
    );
  }

  /*
  * Method to load Dashboard Data
  * */
  Widget loadDashboardData(HomeModel homeModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SingleChildScrollView(
        child:  Column(
          children: [

            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    'Good Evening',
                    style: TextStyle(fontFamily: 'Productsans',
                        fontSize: 18.0,
                        color: Colors.purple[200]),
                  ),

                  Text(
                    homeModel.userData.name,
                    style: TextStyle(fontFamily: 'Productsans',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 8.0,
            ),

            /*
            * Display Ads
            * */
            loadSnapList(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
                homeModel.adsList
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Text(
                'SUBJECTS',
                style: TextStyle(fontFamily: 'Productsans',
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),

            /*
            * Display Subjects
            * */
            loadSubjects(homeModel.subjectsList),

            Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Text(
                  'BRANCHES',
                  style: TextStyle(fontFamily: 'Productsans',
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),

            /*
            * StreamBuilder for Branches
            * */
            Container(
                child: StreamBuilder(
                  stream: branchesBloc.branches,
                  builder: (context, AsyncSnapshot<BranchesModel> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return LinearProgressIndicator();

                      if (snapshot.connectionState == ConnectionState.active) {
                        return loadBranches(snapshot.data.branchesDataList);
                        //return Container();
                      }
                    }
                    else if (snapshot.hasError)
                      return Text('Something went wrong!', style: TextStyle(
                          fontFamily: 'ProductSans', fontSize: 26.0),);

                    return CircularProgressIndicator();
                  },
                ),
              ),

            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Text(
                'UNIVERSITIES',
                style: TextStyle(fontFamily: 'Productsans',
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),

            /*
            * Display Universities
            * */
            loadUniversities(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
                homeModel.universityList
            ),

          ],
        ),
      ),
    );
  }

  /*
  * Method to display Ads Images
  * */
  Widget loadSnapList(double width, double height, List<Ads> adsList) {
    final Size cardSize = Size(width / 1.05, height / 4);
    return Container(
      height: height / 4,
      child: SnapList(
        sizeProvider: (index, data) => cardSize,
        separatorProvider: (index, data) => Size(10.0, 10.0),
        positionUpdate: (int index) {
          if (index == adsList.length - 1) {
            setState(() {
              adsList = new List.from(adsList)
                ..addAll(adsList);
            });
          }
        },
        builder: (context, index, data) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              splashColor: Colors.purpleAccent,
              child: adsList[index].imageUrl == null
                  || adsList[index].imageUrl == ""
                  || adsList[index].imageUrl.isEmpty
                  ? Container()
                  : Card(
                  shadowColor: Colors.grey,
                  elevation: 3.0,
                  child: ExtendedImage.network(
                      adsList[index].imageUrl,
                      fit: BoxFit.fill,
                      cache: true)
              ),
            ),
          );
        },
        count: adsList.length,
      ),
    );
  }

  /*
  * Method to load Subjects
  * */
  Widget loadSubjects(List<Subjects> subjectsList)
  {
    return Container(
      height: 610.0,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 6.0, crossAxisSpacing: 6.0, childAspectRatio: 1.7),
          itemCount: subjectsList.length,
          itemBuilder: (BuildContext context, int index){

            var split = subjectsList[index].subjectName.split('   ');
            String subjName = split[1];

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.purple[100]
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: (){},
                  splashColor: Colors.white,
                  child: Center(
                    child: Text(
                        subjName,
                      style: TextStyle(fontFamily: 'Productsans'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  /*
  * Method to load Branches
  * */
  Widget loadBranches(List<BranchesData> branchesList)
  {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      height: 200.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
        itemCount: branchesList.length,
          itemBuilder: (BuildContext context, int index){

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (){},
              splashColor: Colors.purple[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 120.0,
                      width: 120.0,
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Image.network(
                            branchesList[index].imageUrl,
                            fit: BoxFit.cover,
                            height: 50.0,
                            width: 50.0,
                            loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null ?
                                  loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      width: 130.0,
                      child: Text(
                        branchesList[index].branchName,
                        style: TextStyle(fontFamily: 'Productsans'),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
      }),
    );
  }

  /*
  * Method to display universities
  * */
  Widget loadUniversities(double width, double height, List<Universities> universityList) {
    final Size cardSize = Size(width / 1.3, height / 6);
    return Container(
      height: height / 6,
      margin: EdgeInsets.only(bottom: 20.0),
      child: SnapList(
        sizeProvider: (index, data) => cardSize,
        separatorProvider: (index, data) => Size(10.0, 10.0),
        positionUpdate: (int index) {
          if (index == universityList.length - 1) {
            setState(() {
              universityList = new List.from(universityList)
                ..addAll(universityList);
            });
          }
        },
        builder: (context, index, data) {
          return Container(
            child: Card(
              elevation: 3.0,
              child: InkWell(
                onTap: (){},
                splashColor: Colors.purple[100],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    RotatedBox(
                      quarterTurns: 1,
                      child: ClipPath(
                        clipper: WaveClipperTwo(reverse: true),
                        child: Container(
                          height: 90.0,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.purple[100],
                        ),
                      ),
                    ),

                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                            universityList[index].universityName,
                          style: TextStyle(fontFamily: 'Productsans', fontSize: 18.0),
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),

                    Container(
                      width: 40.0,
                      height: 40.0,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        count: universityList.length,
      ),
    );
  }
}
