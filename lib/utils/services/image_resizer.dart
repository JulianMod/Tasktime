/*
import 'dart:isolate';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'package:path/path.dart';

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
void asyncInit(String imagePath) async {
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
}*/
