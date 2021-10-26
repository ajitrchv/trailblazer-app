import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/place.dart';
import 'dart:io';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier{

  List<Place> _items=[];
  List<Place> get items{
    return[..._items];
  }


  void addplace(String pickedTitle, File image, ){
    final newPlace = Place(id: DateTime.now().toIso8601String(),
    image: image,
    title: pickedTitle,
    location: null,
    );
  _items.add(newPlace);
  notifyListeners();
  DBHelper.insert('places', {
    'id': newPlace.id,
    'title': newPlace.title,
    'image': newPlace.image.path,
    
  });
  }
}
