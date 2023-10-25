import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:plant/data/posts_database.dart';
import 'package:plant/screens/home/home_screen.dart';

import '../../../constants.dart';
import '../../../domain/post_details.dart';

class WritePost extends StatefulWidget {
  static const String id = "WritePost";
  const WritePost({super.key});

  @override
  State<WritePost> createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  bool _uploadedPhoto = false;
  String imageUrl = "n";
  XFile? _postImage;
  late String _time;
  late String _userName;
  late String _date;
  late String _userPhoto;
  late String _plantPhoto;
  late String _plantDescription;
  late String _postID;
  late int _value;

  void getTimeAndDate() {
    DateTime _selectedDate = DateTime.now();
    _date = DateFormat('MM-dd-yyyy').format(_selectedDate);

    TimeOfDay _selectedTime = TimeOfDay.now();
    _time = _formatTime(_selectedTime);
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  final ImagePicker _picker = ImagePicker();
  EdgeInsets containerPadding = const EdgeInsets.only(
    left: 15,
    right: 15,
    top: 5,
  );

  EdgeInsets containerMargin = const EdgeInsets.only(
    left: 10,
    right: 10,
    bottom: 10,
    top: 10,
  );

  Future getImage(ImageSource media) async {
    var image = await _picker.pickImage(source: media);

    setState(() {
      if (image != null) {
        _uploadedPhoto = true;
        _postImage = image;
      }
    });
  }

  void imagePickingAlertBox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            title: const Text(
              "Please choose media to select",
              style: TextStyle(
                  fontSize: 22,
                  color: kTextColor,
                  fontWeight: FontWeight.normal),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: <Widget>[
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 60,
                  color: kPrimaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        imageUrl = "n";
                        setState(() {
                          _uploadedPhoto = false;
                          _postImage = null;
                        });
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    TextButton(
                      onPressed: () async {
                        getTimeAndDate();
                        if (_postImage != null) {
                          imageUrl = _postImage!.path;
                          _plantPhoto = imageUrl;
                        }
                        _userName = HomeScreen.user.userName;
                        _userPhoto = HomeScreen.user.userImage;
                        String str = _time + _date;
                        str = str.replaceAll(":", "");
                        str = str.replaceAll("-", "");
                        _value = int.parse(str);
                        _postID = _userName + _time + _date;
                        _postID = _postID.replaceAll(" ", "_");
                        _postID = _postID.replaceAll(":", "");
                        _postID = _postID.replaceAll("-", "");
                        PostsDatabase postsdatabase = PostsDatabase();
                        bool uploaded = await postsdatabase.addPosts(
                          PostInformation(
                              userName: _userName,
                              date: _date,
                              userPhoto: _userPhoto,
                              plantPhoto: _plantPhoto,
                              plantDescription: _plantDescription,
                              postID: _postID,
                              value: _value),
                        );
                        if (uploaded) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(
                        Icons.done_outline,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Thought: ",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
                TextField(
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  maxLines: 8,
                  decoration: const InputDecoration(
                    hintText: ("Write down what's on your mind"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  onChanged: (text) {
                    _plantDescription = text;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        imagePickingAlertBox();
                      },
                      child: const Icon(
                        Icons.add_photo_alternate_outlined,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        imageUrl = "n";
                        setState(() {
                          _uploadedPhoto = false;
                        });
                      },
                      child: const Icon(
                        Icons.no_photography_outlined,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: imageUrl == "n"
                      ? Container()
                      : Image(
                          image: AssetImage(imageUrl),
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width * .75,
                      height: MediaQuery.of(context).size.width * .5,
                      padding: containerPadding,
                      margin: containerMargin,
                      decoration: BoxDecoration(
                        border: Border.all(color: kTextColor),
                      ),
                      child: _uploadedPhoto
                          ? Image.file(
                              File(_postImage!.path),
                              fit: BoxFit.fill,
                            )
                          : const FittedBox(
                              child: Icon(
                                Icons.photo_size_select_actual_outlined,
                              ),
                            )),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
