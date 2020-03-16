import 'package:flutter/cupertino.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget{
  final double delay;
  final Widget childComponent;

  FadeAnimation(this.delay, this.childComponent);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween(
      [
        Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
        Track("translateY").add(Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0), curve: Curves.easeOut),
      ]
    );

    return ControlledAnimation(
      delay: Duration(milliseconds: (500*delay).round()),
      duration: tween.duration,
      tween: tween,
      child: childComponent,
      builderWithChild: (context, childComponent, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(offset: Offset(0, animation["translateY"]),
          child: childComponent,),
      ),
    );
  }
}