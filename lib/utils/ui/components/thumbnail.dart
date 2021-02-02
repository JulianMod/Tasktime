import 'dart:isolate';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tasktime_bloc/src/models/task_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:tasktime_bloc/src/resources/database_provider.dart';
import 'package:path/path.dart';

class Thumbnail extends StatefulWidget {
  final TaskItem task;
  final Size imageSize;

  Thumbnail({Key key, this.task, this.imageSize}) : super(key: key);
  @override
  _ThumbnailState createState() => _ThumbnailState();
}

///logic and layout for thumbnail widget
class _ThumbnailState extends State<Thumbnail> {
  //TODO: change resize to crop, resizing creates lot of visual artifacts
  List<int> imgBytes;
  Isolate isolate;
  TaskItem task;
  String imageString = 'Choose an image';

  final picker = ImagePicker();

  @override
  void initState() {
    task = widget.task;
    if (task.taskImagePath?.isNotEmpty ?? false) {
      //I have to load an image here
      imgBytes = File(task.taskImagePath).readAsBytesSync();
    }

    super.initState();
  }

  void _retrieveImgFromCamera() async{
    var pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null){
        _asyncInit(pickedFile.path);
      }
    });
  }

  void _retrieveImgFromGallery() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null){
        _asyncInit(pickedFile.path);
      }
    });
  }

  void _showPicker(context) {
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

  static void _isolateEntry(dynamic d) async {
    //isolate resizes and saves resized image
    final receivePort = ReceivePort();
    d.send(receivePort.sendPort);

    final config = await receivePort.first;

    final file = File(config['path']);
    final bytes = await file.readAsBytes();

    img.Image image = img.decodeImage(bytes);
    img.Image thumbnail = img.copyResizeCropSquare(
        image,
        config['size'].width.toInt()
    );
    final oldPath = config['path'];
    final newPath = oldPath + '_resized';
    final resizedImage = img.encodeNamedImage(thumbnail, basename(config['path']));

    File(newPath)..writeAsBytesSync(resizedImage);

    d.send({
      'image': resizedImage,
      'path': newPath
    });
  }

  void _asyncInit(String imagePath) async {
    String newPath;

    setState(() {
      imageString = 'Loading the image...';
    });
    final receivePort = ReceivePort();
    isolate = await Isolate.spawn(_isolateEntry, receivePort.sendPort);

    receivePort.listen((dynamic data) {
      if (data is SendPort) {
        if (mounted) {
          data.send({
            'path': imagePath,
            'size': widget.imageSize
          });
        }
      } else {
        if (mounted) {
          setState(() {
            data.forEach((key, value){
              switch(key) {
                case 'image': {
                  imgBytes = value;
                }
                break;
                case 'path': {
                  newPath = value;
                  task.taskImagePath = newPath;
                }
              }
            });
            dbUpdate(task);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    if (isolate != null) {
      isolate.kill();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //getting screen size by this method rebuilds the UI when the keyboard appears
    //hence it causes problems when I want to edit the textfield with taskname and duration
    //task = widget.task;
    return GestureDetector(
      onTap: () {
        _showPicker(context);
      },
      child: imgBytes != null
          ? Image.memory(imgBytes,
        fit: BoxFit.cover,
      )
          : Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).hintColor
            ),
            borderRadius: BorderRadius.all(Radius.circular(4.0)
            )
        ),
        height: widget.imageSize.width,
        width: widget.imageSize.width,
        child: Align(
            alignment: Alignment.center,
            child:
            Text(
              imageString,
              style: Theme.of(context).textTheme.headline6,
            )
        ),
      ),
    );
  }
}