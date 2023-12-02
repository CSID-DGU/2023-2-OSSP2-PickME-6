import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AddImage extends StatefulWidget{
  const AddImage({super.key});


  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  final user = FirebaseAuth.instance.currentUser;
  File? pickedImage;
  void _pickImage() async{
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 150
    );
    setState(() {
      if(pickedImageFile != null) {
        pickedImage = File(pickedImageFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.only(top:10),
      width: 150,
      height: 300,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            backgroundImage: pickedImage != null ? FileImage(pickedImage!) : null,
          ),
          SizedBox(
            height: 10,
          ),
          OutlinedButton.icon(
            onPressed: (){
              _pickImage();
            },
            icon: Icon(Icons.image),
            label: Text('이미지 선택'),
          ),
          
          SizedBox(
            height: 80,
          ),
          TextButton.icon(
            onPressed : () async {
              final refImage = FirebaseStorage.instance.ref()
                  .child('user_profile')
                  .child(user!.uid + '.png');
              await refImage.putFile(pickedImage!);
              final url = await refImage.getDownloadURL();
              print(url);
              await FirebaseFirestore.instance
                  .collection('user')
                  .doc(user!.uid)
                  .update(
                  {
                    'profile_image' : url
                  });
              Navigator.pop(context);
            },
            icon: Icon(Icons.save),
            label: Text('저장'),
          ),
        ],
      ),
    );
  }

}
