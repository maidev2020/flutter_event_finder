import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_event_finder/FadeAnimation.dart';
import 'package:page_transition/page_transition.dart';

class SearchSetup extends StatefulWidget{
  @override
  _SearchSetup createState() => _SearchSetup();

}

class _SearchSetup extends State<SearchSetup>{
  // Vars
  List<List<dynamic>> list = [["Vegan", "Vegie", "Gluten Free", "Helal"],[false, false, false, false]];
  double defaultDelay = 0.2;

  double switshAnimationDelay = 1.2;
  double searchAnimationDelay = 1.2;

  double defaultDistance = 0.5; // in km
  List<String> prices = ["€","€€","€€€"];
  int  defaultPriceValue = 2;

  double ratingValue = 4.5;


  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Search Settings"), backgroundColor: Colors.deepOrange,),
      floatingActionButton: FloatingActionButton.extended(
          elevation: 4.0, backgroundColor: Colors. deepOrange, onPressed: (){
            // Next Video
            //Navigator.push(context, PageTransition(child: LocationSetup(), type:  PageTransitionType.fade));

      }, label: const Text("Next")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(child: new SizedBox(height: 48,),),

      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 16, left: 16),
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 5,),
                FadeAnimation(switshAnimationDelay += defaultDelay, Container(
                  child: Text("Diet Restriction", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black54), textAlign:  TextAlign.center,),
                  width: double.infinity,

                )),
                Container(
                  child: SizedBox(height: 200, child: ListView.builder(itemCount: list[0].length,itemBuilder: (BuildContext context, int index){
                    return FadeAnimation(switshAnimationDelay +=defaultDelay, Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(list[0][index], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.black54),),
                            ),

                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                list[1][index] = !list[1][index]; // bool = true, bool b = !a = false
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Column(
                                children: <Widget>[
                                  CustomSwitchButton(
                                    backgroundColor: list[1][index] == true ? Colors.green : Colors.red,
                                    unCheckedColor: Colors.white,
                                    animationDuration: Duration(milliseconds: 400),
                                    checkedColor: Colors.white,
                                    checked: list[1][index],
                                  ),

                                ],
                              ),
                            ),
                          )

                        ],
                      ),
                    ));
                  }
                  ),),

                ),

                // SearchParameter
                SizedBox(height: 5,),
                FadeAnimation(searchAnimationDelay +=defaultDelay, Container(
                  child: Text("Search Parameters", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black54),textAlign: TextAlign.center,),
                  width: double.infinity,
                )),
                FadeAnimation(searchAnimationDelay += defaultDelay, Container(
                  child: searchParamters(text: "Distance:", value: defaultDistance, unit:"KM"),
                )),
                FadeAnimation(searchAnimationDelay += defaultDelay, Container(
                  child: Slider(
                    value: defaultDistance,
                    min: 0.0,
                    max: 5.0,
                    divisions: 10,
                    activeColor: Colors.deepOrange,
                    inactiveColor: Colors.black54,
                    label: "$defaultDistance KM",
                    onChanged: (double newValue){
                      setState(() {
                        defaultDistance = newValue;
                      });
                    },
                  ),
                )),

                // Price

                FadeAnimation(searchAnimationDelay += defaultDelay, Container(
                  child: searchParamters(text: "Price:", value: defaultPriceValue, unit:"€"),
                )),
                FadeAnimation(searchAnimationDelay += defaultDelay, Container(
                  child: Slider(
                    value: defaultPriceValue.toDouble(),
                    min: 1,
                    max: 3,
                    divisions: 2,
                    activeColor: Colors.deepOrange,
                    inactiveColor: Colors.black54,
                    label: prices[defaultPriceValue-1],
                    onChanged: (double newValue){
                      setState(() {
                          defaultPriceValue= newValue.toInt();
                      });
                    },
                  ),
                )),

                // Rating
                FadeAnimation(searchAnimationDelay += defaultDelay, Container(
                  child: searchParamters(text: "Rating:", value: ratingValue, unit:"*"),
                )),
                FadeAnimation(searchAnimationDelay += defaultDelay, Container(
                  child: Slider(
                    value: ratingValue,
                    min: 1,
                    max: 5,
                    divisions: 8,
                    activeColor: Colors.deepOrange,
                    inactiveColor: Colors.black54,
                    label: "$ratingValue *",
                    onChanged: (double newValue){
                      setState(() {
                        ratingValue= newValue;
                      });
                    },
                  ),
                )),


              ],
            ),
          ),
        ),
      ),
    );
  }

  searchParamters({text, value, unit}) {

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FadeAnimation(searchAnimationDelay += defaultDelay, Text(text, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300, color: Colors.black54),)),
          FadeAnimation(searchAnimationDelay += defaultDelay, Container(
            margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 2 -100),
            child: Text(unit == "€" ? prices[value -1 ] : unit == "*" ? "$ratingValue" : "$value KM", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w200, color: Colors.black54)),
          ))
        ],
      ),
    );
  }
}































