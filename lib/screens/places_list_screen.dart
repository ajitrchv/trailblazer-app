import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/add_place_screen.dart';
import '../provider/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  //const ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Places"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlace.routeName);
              },
              icon: const Icon(Icons.add_box),
            ),
          ],
        ),
        body: Consumer<GreatPlaces>(
          child: const Center(child: Text('Got No Places Yet!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.indigo),)),
          builder: (ctx, greatPlaces, ch) => (greatPlaces.items.isEmpty
              ? ch!
              : ListView.builder(
                  itemCount: greatPlaces.items.length,
                  itemBuilder: (ctx, i) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(greatPlaces.items[i].image),
                    ),
                    title: Text(greatPlaces.items[i].title),
                    onTap: () {},
                  ),
                )),
        ));
  }
}
