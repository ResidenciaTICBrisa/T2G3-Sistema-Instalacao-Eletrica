import 'package:flutter/material.dart';

class FacilitiesPage extends StatefulWidget {
  @override
  _FacilitiesPageState createState() => _FacilitiesPageState();
}

class _FacilitiesPageState extends State<FacilitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('App de Navegação'),
      automaticallyImplyLeading: false,
    ));
  }
}
