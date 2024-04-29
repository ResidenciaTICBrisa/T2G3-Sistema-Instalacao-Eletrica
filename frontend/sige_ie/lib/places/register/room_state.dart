import 'package:flutter/material.dart';
import 'package:sige_ie/config/app_styles.dart';


class Roomlocation extends StatefulWidget {
  @override
  _RoomlocationState createState() => _RoomlocationState();
}

class _RoomlocationState extends State<Roomlocation>{

  String? selectedFloor;
  final List<String> floors = ['Andar 1','Andar 2','Andar 3','Andar 4','Andar 5'];

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
            SizedBox(height:60),
             Padding(
              padding:const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[
                Text('Andar',
                style: TextStyle(
                  fontSize:16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black )),
                  SizedBox(height:10),
                  Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: 
                     BorderRadius.circular(10),
                  ),
                  child: DropdownButtonHideUnderline(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<String>(
                          value: selectedFloor,
                          hint: Text('Selecione o Andar'),
                          isExpanded: true,
                          items: floors.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedFloor = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                SizedBox(height:40),
                Text('Sala',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:Colors.black)),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: 
                         BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Digite o nome da Sala',
                          border:InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10),
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    
              ],
              ), )
          ],
        ),
      ),
    );
  }
}



























































































