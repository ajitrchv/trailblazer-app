import 'package:flutter/material.dart';
import '../widgets/image_inputs.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../provider/great_places.dart';

class AddPlace extends StatefulWidget {
  static const routeName = '/AddPlace';
  const AddPlace({Key? key}) : super(key: key);

  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _titleController = TextEditingController();
  late File _pickedImage;
  
  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if(_titleController.text.isEmpty || _pickedImage == null)
    {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addplace(
      _titleController.text, 
      _pickedImage
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
                        decoration: InputDecoration(label: Text('Something..')),
                        controller: _titleController,
                      ),
                      const SizedBox(height: 10,),
                       ImageInput(_selectImage),
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
