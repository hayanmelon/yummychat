import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AddImage extends StatefulWidget {
  const AddImage(this.addImageFunc, {Key? key}) : super(key: key);

  final Function(File pickedImage) addImageFunc;

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {

  File? pickedImage;

  void _pickImage()async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50, // 중간값 50
      maxHeight : 150,
    );
    setState(() {
      if(pickedImageFile != null) {
        pickedImage = File(pickedImageFile.path); // File 객체에 Path 값을 전달해서 리턴된 File 타입의 함수를 pickedImage 변수에 대입
      }
    });
    widget.addImageFunc(pickedImage!); // 현재 위젯(AddImage)의 addImageFunc를 불러온다
 }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: 150,
      height: 300,
      child: Column(

        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            backgroundImage: pickedImage != null ? FileImage(pickedImage!) : null,
          ),
          SizedBox(height: 10,),
          // Add Image 버튼
          OutlinedButton.icon(
            onPressed: (){
              _pickImage();
            },
            icon : Icon(Icons.image),
            label : Text('Add icon'),
          ),
          SizedBox(height: 80,),
          TextButton.icon(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            label: Text('Close'),
          )
        ],
      ),
    );
  }


}
