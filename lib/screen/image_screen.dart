import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_saver/screen/image_view.dart';

import '../provider/GetStatusProvider.dart';
class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {

  bool _isFetched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<GetStatusProvider>(builder: (context, file, child) {
          if (_isFetched == false) {
            file.getStatus(".jpg");
            Future.delayed(const Duration(microseconds: 1), () {
              _isFetched = true;
            });
          }
          return file.isWhatsappAvailable == false
              ? const Center(
            child: Text("Whatsapp not available"),
          )
              : file.getImages.isEmpty
              ? const Center(
            child: Text("No image available"),
          )
              : Container(
            padding: const EdgeInsets.all(20),
            child: GridView(
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              children: List.generate(file.getImages.length, (index) {
                final data = file.getImages[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (_) => ImageViewScreen(
                            imagePath: data.path,
                          )),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(data.path))),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );
              }),
            ),
          );
        }));
  }
}
