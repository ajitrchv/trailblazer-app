import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trailblazer_app/screens/place_details_screen.dart';
import './provider/great_places.dart';
import './screens/places_list_screen.dart';
import './screens/add_place_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // ({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),

      child: MaterialApp(
        title: 'Trailblazer',
        theme: ThemeData(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(secondary: Colors.amber)),
      
      home:   PlacesListScreen(),
      routes: {
        AddPlace.routeName: (ctx) => AddPlace(),
        PlacesListScreen.routeName: (ctx) => PlacesListScreen(),
        PlaceDetails.routeName: (ctx) => PlaceDetails(),
      },
      ),
    );
  }
}