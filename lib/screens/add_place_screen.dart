import 'package:flutter/material.dart';
import '../models/place.dart';
import '../widgets/image_inputs.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../provider/great_places.dart';
import '../widgets/location_input.dart';

class AddPlace extends StatefulWidget {
  static const routeName = '/AddPlace';
  const AddPlace({Key? key}) : super(key: key);

  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _titleController = TextEditingController();
  late File _pickedImage;
  late PlaceLocation _pickedLocation;
  
  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lng){
      _pickedLocation = PlaceLocation(latitude: lat, longitude: lng,);
  }

  void _savePlace() {
    if(_titleController.text.isEmpty || _pickedImage == null || _pickedLocation == null)
    {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text, 
      _pickedImage,
      _pickedLocation,
      );
      Navigator.of(context).pop();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
      ),
      body: Center(
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(label: Text('Tell us something about the place..')),
                        controller: _titleController,
                      ),
                      const SizedBox(height: 10,),
                       ImageInput(_selectImage),
                      const SizedBox(height:10),
                      LocationInput(_selectPlace),
                      //LocationInput(),
                      ],
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              onPressed: _savePlace,
              label: const Text('Add Place'),
              
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  primary: Theme.of(context).colorScheme.secondary,
                  onPrimary: Colors.black
                ),
              clipBehavior: Clip.antiAlias,
            ),
          ],
        ),
      ),
    );
  }
}
