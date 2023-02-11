import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final ImagePicker _picker = ImagePicker();
  File? fileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uploads Photo'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 150,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              onTap: () async {
                                XFile? image = await _picker.pickImage(
                                    source: ImageSource.camera);
                                if (image?.path != '') {
                                  fileImage = File(image!.path);
                                  Navigator.pop(context);
                                }
                              },
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('ถ่ายภาพ'),
                            ),
                            ListTile(
                              onTap: () async {
                                XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image?.path != '') {
                                  fileImage = File(image!.path);
                                  Navigator.pop(context);
                                }
                              },
                              leading: const Icon(Icons.photo),
                              title: const Text('เลือกรูปภาพ'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).whenComplete(() => setState(() {}));
              },
              child: const Text('Uploads'),
            ),
            fileImage != null ? Image.file(fileImage!) : Container()
          ],
        ),
      ),
    );
  }
}
