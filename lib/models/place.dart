
import 'package:flutter/material.dart';
import 'dart:io';

class PlaceLocation{
  final double latitude;
  final double longiitude;
  final String adress;

  PlaceLocation(this.adress, {
    required this.latitude, 
    required this.longiitude,
  });
}    


class Place {
  final String id;
  final String title;
  final PlaceLocation? location;
  final File image;

  Place( {

    required this.id,
    required this.title,
    required this.location,
    required this.image,

  });

}