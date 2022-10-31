import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:status_saver/provider/BottomNavProvider.dart';
import 'package:status_saver/screen/image_screen.dart';
import 'package:status_saver/screen/video_screen.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> page=[ImageScreen(),VideoScreen()];
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context,nav,child){
        return Scaffold(
          body: page[nav.curruntIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value){
              nav.changeIndex(value);
            },
            currentIndex: nav.curruntIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.image),label: "Image"),
              BottomNavigationBarItem(icon: Icon(Icons.video_call),label: "Video")
            ],
          ),
        );
      }

    );
  }
}
