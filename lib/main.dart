import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_event_finder/FadeAnimation.dart';
import 'package:flutter_event_finder/SearchSetup.dart';
import 'package:page_transition/page_transition.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() =>_HomePage();

}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  AnimationController _scaleController;
  Animation _scaleAnimation;

  bool hide = false;

  @override
  void initState() {
    super.initState();

    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scaleAnimation =
    Tween<double>(begin: 1.0, end: 30.0).animate(_scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.push(context,
              PageTransition(child: SearchSetup(), type:PageTransitionType.fade));
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scaleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.deepOrange[400], Colors.deepOrange[600]]
            )
        ),
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FadeAnimation(
                  1, Text("Find the best restaurant near you for a good meal.",
                style: TextStyle(color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    height: 1.1),)),
              SizedBox(height: 30,),
              FadeAnimation(1.2, Text("Let us find a restaurant for your taste",
                style: TextStyle(color: Colors.white.withOpacity(0.7),
                    fontSize: 25,
                    fontWeight: FontWeight.w100),)),
              SizedBox(
                height: 150,
              ),
              FadeAnimation(2, InkWell(
                onTap: (){
                  setState(() {
                    hide= true;
                  });
                  _scaleController.forward();
                },
                child: AnimatedBuilder(
                  animation: _scaleController,
                  builder: (context, child)=> Transform.scale(scale: _scaleAnimation.value,
                  child: Container(
                    height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.deepOrange[900]
                      ),
                    child: hide == false ?
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Find nearest restaurant", style: TextStyle(color: Colors.white, fontSize: 17),),
                        Icon(Icons.arrow_forward, color: Colors.white,)
                      ],
                    ): Container(),
                  ),),
                ),
              )),
              SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }
}
