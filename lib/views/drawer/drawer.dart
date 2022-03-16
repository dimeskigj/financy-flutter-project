import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SideDrawer extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  SideDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Center(
              child: InkWell(
                  onTap: () async {
                    await _picker.pickImage(source: ImageSource.camera);
                  },
                  child: CircleAvatar(
                    child: Icon(
                      Icons.camera_alt,
                      size: 45,
                    ),
                    backgroundColor: Colors.white,
                    radius: 50,
                  )),
            ),
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
          )
        ],
      ),
    );
  }
}
