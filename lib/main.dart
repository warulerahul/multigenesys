import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mutligenesys/screen/dashboard_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.purple
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {

    Future.delayed(Duration(seconds: 2), (){
      Navigator.pushAndRemoveUntil(context, PageTransition(duration: Duration(milliseconds: 300), type: PageTransitionType.leftToRight, child: DashboardScreen()), ModalRoute.withName(""));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      'MultiGenesys',
                      style: TextStyle(fontFamily: 'Productsans', fontSize: 36.0),
                    ),
                  ),

                  SpinKitThreeBounce(color: Colors.purple, size: 30.0,),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'www.multigenesys.com',
                style: TextStyle(fontFamily: 'Productsans', fontSize: 16.0),
              ),
            )
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
