import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:video_player/video_player.dart';
class VideoViewScreen extends StatefulWidget {
  final String? videoPath;
  const VideoViewScreen({Key? key,this.videoPath}) : super(key: key);

  @override
  State<VideoViewScreen> createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  ///list of buttons
  List<Widget> buttonsList = const [
    Icon(Icons.download),
    Icon(Icons.share),
  ];

  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    _chewieController = ChewieController(
        videoPlayerController: VideoPlayerController.file(
          File(widget.videoPath!),
        ),
        autoInitialize: true,
        autoPlay: true,
        looping: true,
        aspectRatio: 5 / 6,
        errorBuilder: ((context, errorMessage) {
          return Center(
            child: Text(errorMessage),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Chewie(controller: _chewieController!),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(buttonsList.length, (index) {
              return FloatingActionButton(
                heroTag: "$index",
                onPressed: () {
                  switch (index) {
                    case 0:
                      log("download video");
                      ImageGallerySaver.saveFile(widget.videoPath!)
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Video Saved")));
                      });
                      break;

                    case 1:
                      log("Share");
                      FlutterNativeApi.shareImage(widget.videoPath!);

                      break;
                  }
                },
                child: buttonsList[index],
              );
            })),
      ),
    );
  }
}
