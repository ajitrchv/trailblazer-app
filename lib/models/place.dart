
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:meta/meta.dart';

class PlaceLocation{
  final double? latitude;
  final double? longitude;
  var address;

  // PlaceLocation({
  //   required this.latitude,
  //   required this.longitude,
  // });
  PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
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