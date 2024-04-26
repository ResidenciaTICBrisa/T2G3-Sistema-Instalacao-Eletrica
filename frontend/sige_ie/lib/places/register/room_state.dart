import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';


class Roomlocation extends StatefulWidget {
  @override
  _RoomlocationState createState() => _RoomlocationState();
}

class _RoomlocationState extends State<Roomlocation>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.sigeIeBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color:Colors.white),
          onPressed: ()=> Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 35),
              decoration: BoxDecoration(
                color: AppColors.sigeIeBlue,
                borderRadius: 
                BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Center(
                child:Text('Local-Sala',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color:Colors.white )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



























































































