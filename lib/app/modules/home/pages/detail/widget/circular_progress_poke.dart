import 'package:flutter/material.dart';

class CircularProgressPoke extends StatelessWidget {
  
  final Color color;

  const CircularProgressPoke({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: SizedBox(
          height: 15,
          width: 15,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ),
    );
  }
}
