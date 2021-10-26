import 'package:location/location.dart';
import 'package:flutter/material.dart';
import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function locsel;
  //const LocationInput({Key? key}) : super(key: key);
  LocationInput(this.locsel);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  
  
  String _previewImageUrl = '';

    Future<void> _getCurrentLocation() async {
        Location location = new Location();
     
        bool _serviceEnabled;
        PermissionStatus _permissionGranted;
        LocationData _locData;
     
        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            return;
          }
        } //checks whether location service is enabled ondevice,
        //if not it requests the user to enable it and returns if not enabled
     
        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            return;
          }
        }//checks whether app has permision to acess location,if not it requests permission
        //if permission is denied, it returns
     
        _locData = await location.getLocation();
        // print(_locData.latitude);
        // print(_locData.longitude);
        final previewUrl = LocationHelper.generateLocationPreviewImage(
          latitude: _locData.latitude, 
          longitude: _locData.longitude
          );
          setState(() {
            _previewImageUrl = previewUrl;
          });
          widget.locsel(_locData.latitude, _locData.longitude);
      }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == ''
              ? const Center(
                child: Text(
                    'No Location choosen!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blueGrey, fontWeight: FontWeight.bold),
                  ),
              )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on_outlined),
                label: const Text(
                  'Get current Location',
                  style: TextStyle(color: Colors.indigo),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
