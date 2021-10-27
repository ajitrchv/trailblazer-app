import 'package:flutter/material.dart';
import './location_input.dart' as loc;
import '../helpers/location_helper.dart';
import 'package:location/location.dart';

class ImageDialog extends StatefulWidget {
final Function locsel;
ImageDialog(this.locsel);
  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  @override

  

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



  Widget build(BuildContext context) {
    return Dialog(

      child: Container(
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
      // child: Container(
      //   width: 200,
      //   height: 200,
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: ExactAssetImage('lib/assets/tamas.jpg'),
      //       fit: BoxFit.cover
      //     )
      //   ),
      // ),
    );
  }
}

