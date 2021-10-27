import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/great_places.dart';
import 'package:url_launcher/url_launcher.dart';


class PlaceDetails extends StatelessWidget {
  //const PlaceDetails({ Key? key }) : super(key: key);
  static const routeName = '/PlaceDetails';


 openMap(double? latitude,double? longitude) async {
  String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if(await canLaunch(googleUrl) != null) {
    await launch(googleUrl);
  } else {
    throw 'Could not open the map.';
  }
}

  @override
  Widget build(BuildContext context) {
    String routeId = ModalRoute.of(context)!.settings.arguments as String;
    var selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(routeId);

    var lat = selectedPlace.location!.latitude;
    var lng = selectedPlace.location!.longitude;

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location!.address,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed:() => openMap(lat, lng),
            // async {
            //   await showDialog(
            //     context: context,
            //     builder: (_) => navigateTo(lat, lng)
            //   );
           
            child: const Text(
              "View on map",
              style:
                  TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}


//https://stackoverflow.com/questions/47046637/open-google-maps-app-if-available-with-flutter   ==== Ref