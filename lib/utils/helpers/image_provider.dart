/*
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasktime_bloc/utils/services/image_resizer.dart';

void _retrieveImgFromCamera() async{
  var pickedFile = await picker.getImage(source: ImageSource.camera);

  setState(() {
    if (pickedFile != null){
      asyncInit(pickedFile.path);
    }
  });
}

void _retrieveImgFromGallery() async {
  var pickedFile = await picker.getImage(source: ImageSource.gallery);

  setState(() {
    if (pickedFile != null){
      asyncInit(pickedFile.path);
    }
  });
}

void showPicker(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Photo Library'),
                    onTap: () {
                      _retrieveImgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    _retrieveImgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
  );
}
*/
