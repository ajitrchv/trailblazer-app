import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  //const ImageInput({Key? key}) : super(key: key);
  final Function onSelectImage;
  ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  
//=======================================================================================================
//============== Clicking an Image ======================================================================

  File? _storedImage = null;
  Future<void> _takePicture() async{
    final picker = ImagePicker();
    final imageFile = await picker.pickImage
    (source: ImageSource.camera, maxWidth: 400);
    if(imageFile == null) {return;}
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    String appDocPath = appDir.path;
    final filename = path.basename(imageFile.path);
    final File SavedImage =
      await _storedImage!.copy('$appDocPath/$filename');
    widget.onSelectImage(SavedImage);
  }

//========================================================================================================

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(_storedImage!,
                  fit: BoxFit.cover, width: double.infinity)
              : const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'No image available for preview!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blueGrey, 
                        fontWeight: FontWeight.bold),
                  ),
                ),
          alignment: Alignment.center,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () {
              _takePicture();
            },
            icon: const Icon(Icons.add_a_photo_outlined),
            label: const Text('Take a photo'),
          ),
        ),
      ],
    );
  }
}
