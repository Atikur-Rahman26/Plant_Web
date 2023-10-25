import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant/constants.dart';
import 'package:plant/data/plants_data_managing.dart';
import 'package:plant/domain/add_sell_post_data.dart';
import 'package:plant/screens/home/home_screen.dart';

class AddSellPost extends StatefulWidget {
  static const id = "AddSellPost";
  const AddSellPost({super.key});

  @override
  State<AddSellPost> createState() => _AddSellPostState();
}

class _AddSellPostState extends State<AddSellPost> {
  var _plantNameTextEditingController = TextEditingController();
  var _plantPriceTextEditingController = TextEditingController();
  var _plantAvailableItemTextEditingController = TextEditingController();
  var _sellerHomeAddressTextEditingController = TextEditingController();
  var _plantNoteTextEditingController = TextEditingController();
  var _dateEditingController = TextEditingController();

  final List<String> _divisionDropDownList = [
    'Barishal',
    'Chottogram',
    'Dhaka',
    'Khulna',
    'Mymensingh',
    'Rajshahi',
    'Rangpur',
    'Sylhet',
  ];
  List<String> _districtDropDownList = [];
  List<String> _upzillaDropDownList = [];
  late String _plantName;
  late double _plantPrice;
  late int _plantAvailableItem;
  late String _sellerHomeAddress;
  late String _sellingID;
  late String _sellerID;
  late String _date;
  late String _home;
  late String _note;
  late String _upzilla = "";
  late String _district = "";
  String _division = "";
  late int _indexDivision;
  late int _indexDistrict;
  XFile? _plantImage;

  bool _clickedPlantName = false;
  bool _clickedPlantPrice = false;
  bool _clickedPlantAvailableItem = false;
  bool _clickedSellerHomeAddress = false;
  bool _clickedUploadDate = false;
  bool _clickedNote = false;
  bool _uploadedImage = false;
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
  BoxDecoration containerDecoration = const BoxDecoration(
    color: kCartBackgroundColor,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
  );

  PlantsDataManagement _plantsDataManagement = PlantsDataManagement();
  final ImagePicker picker = ImagePicker();
  Future getImage(ImageSource media) async {
    var image = await picker.pickImage(source: media);

    setState(() {
      if (image != null) {
        _uploadedImage = true;
        _plantImage = image;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 35,
            color: kBackgroundColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              size: 35,
              color: kBackgroundColor,
            ),
          ),
        ],
      ),
      body: Container(
        color: kBackgroundColor,
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: containerPadding,
                margin: containerMargin,
                decoration: containerDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _clickedPlantName == true ? "Plant name" : "",
                      style: const TextStyle(color: kTextColor),
                      textAlign: TextAlign.center,
                    ),
                    TextField(
                      style: const TextStyle(
                        color: kTextColor,
                      ),
                      keyboardType: TextInputType.text,
                      controller: _plantNameTextEditingController,
                      onChanged: (value) {
                        _plantName = value;
                      },
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        hintText:
                            _clickedPlantName == false ? 'Plant name' : null,
                      ),
                      onTap: () {
                        setState(() {
                          _clickedPlantName = true;
                          _clickedPlantPrice = false;
                          _clickedPlantAvailableItem = false;
                          _clickedSellerHomeAddress = false;
                          _clickedUploadDate = false;
                          _clickedNote = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: containerPadding,
                    margin: containerMargin,
                    decoration: containerDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _clickedPlantPrice == true ? "Plant price" : "",
                          style: const TextStyle(color: kTextColor),
                          textAlign: TextAlign.center,
                        ),
                        TextField(
                          style: const TextStyle(color: kTextColor),
                          keyboardType: TextInputType.number,
                          controller: _plantPriceTextEditingController,
                          onChanged: (value) {
                            _plantPrice = double.parse(value);
                          },
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              color: kTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                            hintText: _clickedPlantPrice == false
                                ? 'Plant price'
                                : null,
                          ),
                          onTap: () {
                            setState(() {
                              _clickedPlantName = false;
                              _clickedPlantPrice = true;
                              _clickedPlantAvailableItem = false;
                              _clickedSellerHomeAddress = false;
                              _clickedUploadDate = false;
                              _clickedNote = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: containerPadding,
                    margin: containerMargin,
                    decoration: containerDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _clickedPlantAvailableItem == true ? "Item" : "",
                          style: const TextStyle(color: kTextColor),
                          textAlign: TextAlign.center,
                        ),
                        TextField(
                          style: const TextStyle(color: kTextColor),
                          keyboardType: TextInputType.number,
                          controller: _plantAvailableItemTextEditingController,
                          onChanged: (value) {
                            _plantAvailableItem = int.parse(value);
                          },
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              color: kTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                            hintText: _clickedPlantAvailableItem == false
                                ? 'Item'
                                : null,
                          ),
                          onTap: () {
                            setState(() {
                              _clickedPlantName = false;
                              _clickedPlantPrice = false;
                              _clickedPlantAvailableItem = true;
                              _clickedSellerHomeAddress = false;
                              _clickedUploadDate = false;
                              _clickedNote = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: containerPadding,
                margin: containerMargin,
                decoration: containerDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _clickedSellerHomeAddress == true ? "Home address" : "",
                      style: const TextStyle(color: kTextColor),
                      textAlign: TextAlign.center,
                    ),
                    TextField(
                      style: const TextStyle(
                        color: kTextColor,
                      ),
                      keyboardType: TextInputType.text,
                      controller: _sellerHomeAddressTextEditingController,
                      onChanged: (value) {
                        _sellerHomeAddress = value;
                      },
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        hintText: _clickedSellerHomeAddress == false
                            ? 'Home address'
                            : null,
                      ),
                      onTap: () {
                        setState(() {
                          _clickedPlantName = false;
                          _clickedPlantPrice = false;
                          _clickedPlantAvailableItem = false;
                          _clickedSellerHomeAddress = true;
                          _clickedUploadDate = false;
                          _clickedNote = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: containerPadding,
                margin: containerMargin,
                decoration: const BoxDecoration(
                  color: kCartBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: DropdownButton(
                  onTap: () {
                    setState(() {
                      _clickedPlantName = false;
                      _clickedPlantPrice = false;
                      _clickedPlantAvailableItem = false;
                      _clickedSellerHomeAddress = false;
                      _clickedUploadDate = false;
                      _clickedNote = false;
                    });
                  },
                  // dropdownColor: kCartBackgroundColor,
                  borderRadius: BorderRadius.circular(30),
                  menuMaxHeight: MediaQuery.of(context).size.height * .35,
                  hint: _division.isEmpty
                      ? const Text('Division')
                      : Text(
                          _division,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                  items: _divisionDropDownList.map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: kBackgroundColor,
                              width: MediaQuery.of(context).size.width * .9,
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 5, right: 10, left: 10),
                              child: Text(val),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 1,
                              child: Container(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _division = val!;
                        _upzilla = "";
                        _district = "";
                        if (_division == _divisionDropDownList[0]) {
                          _districtDropDownList = kDistrictsList[0];
                          _indexDivision = 0;
                        } else if (_division == _divisionDropDownList[1]) {
                          _districtDropDownList = kDistrictsList[1];
                          _indexDivision = 1;
                        } else if (_division == _divisionDropDownList[2]) {
                          _districtDropDownList = kDistrictsList[2];
                          _indexDivision = 2;
                        } else if (_division == _divisionDropDownList[3]) {
                          _districtDropDownList = kDistrictsList[3];
                          _indexDivision = 3;
                        } else if (_division == _divisionDropDownList[4]) {
                          _districtDropDownList = kDistrictsList[4];
                          _indexDivision = 4;
                        } else if (_division == _divisionDropDownList[5]) {
                          _districtDropDownList = kDistrictsList[5];
                          _indexDivision = 5;
                        } else if (_division == _divisionDropDownList[6]) {
                          _districtDropDownList = kDistrictsList[6];
                          _indexDivision = 6;
                        } else if (_division == _divisionDropDownList[7]) {
                          _districtDropDownList = kDistrictsList[7];
                          _indexDivision = 7;
                        }
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: containerPadding,
                margin: containerMargin,
                decoration: const BoxDecoration(
                  color: kCartBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: DropdownButton(
                  onTap: () {
                    setState(() {
                      _clickedPlantName = false;
                      _clickedPlantPrice = false;
                      _clickedPlantAvailableItem = false;
                      _clickedSellerHomeAddress = false;
                      _clickedUploadDate = false;
                      _clickedNote = false;
                    });
                  },
                  // dropdownColor: kCartBackgroundColor,
                  borderRadius: BorderRadius.circular(30),
                  menuMaxHeight: MediaQuery.of(context).size.height * .35,
                  hint: _district.isEmpty
                      ? const Text('District')
                      : Text(
                          _district,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                  items: _districtDropDownList.map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: kBackgroundColor,
                              width: MediaQuery.of(context).size.width * .9,
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 5, right: 10, left: 10),
                              child: Text(val),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 1,
                              child: Container(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _district = val!;
                        _upzilla = "";
                        _indexDistrict = findingIndex(
                            districtList: _districtDropDownList,
                            district: _district);
                        _upzillaDropDownList =
                            (kUpzillaLists[_indexDivision][_indexDistrict]);
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: containerPadding,
                margin: containerMargin,
                decoration: const BoxDecoration(
                  color: kCartBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: DropdownButton(
                  onTap: () {
                    setState(() {
                      _clickedPlantName = false;
                      _clickedPlantPrice = false;
                      _clickedPlantAvailableItem = false;
                      _clickedSellerHomeAddress = false;
                      _clickedUploadDate = false;
                      _clickedNote = false;
                    });
                  },
                  // dropdownColor: kCartBackgroundColor,
                  borderRadius: BorderRadius.circular(30),
                  menuMaxHeight: MediaQuery.of(context).size.height * .35,
                  hint: _upzilla.isEmpty
                      ? const Text('Upzilla')
                      : Text(
                          _upzilla,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                  isExpanded: true,
                  iconSize: 30.0,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                  items: _upzillaDropDownList.map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: kBackgroundColor,
                              width: MediaQuery.of(context).size.width * .9,
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 5, right: 10, left: 10),
                              child: Text(val),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 1,
                              child: Container(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    setState(
                      () {
                        _upzilla = val!;
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: containerPadding,
                margin: containerMargin,
                decoration: const BoxDecoration(
                  color: kCartBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _clickedNote == true ? "Note" : "",
                      style: const TextStyle(color: kTextColor),
                      textAlign: TextAlign.center,
                    ),
                    TextField(
                      style: const TextStyle(
                        color: kTextColor,
                      ),
                      keyboardType: TextInputType.text,
                      controller: _plantNoteTextEditingController,
                      onChanged: (value) {
                        _note = value;
                      },
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          color: kTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        hintText: _clickedNote == false ? 'Note' : null,
                      ),
                      onTap: () {
                        setState(() {
                          _clickedPlantName = false;
                          _clickedPlantPrice = false;
                          _clickedPlantAvailableItem = false;
                          _clickedSellerHomeAddress = false;
                          _clickedUploadDate = false;
                          _clickedNote = true;
                        });
                      },
                    ),
                  ],
                ),
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
                    child: _uploadedImage
                        ? Image.file(
                            File(_plantImage!.path),
                            fit: BoxFit.fill,
                          )
                        : const FittedBox(
                            child: Icon(
                              Icons.photo_size_select_actual_outlined,
                            ),
                          )),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .75,
                  height: 30,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kCartBackgroundColor),
                    ),
                    onPressed: () {
                      imagePickingAlertBox();
                    },
                    child: const Text(
                      "Upload image",
                      style: TextStyle(fontSize: 20, color: kTextColor),
                    ),
                  ),
                ),
              ),
              Center(
                child: MaterialButton(
                  color: kPrimaryColor,
                  onPressed: () async {
                    List<dynamic> tempList = getDateAndTime();
                    int _minValue = tempList[3];
                    _date = tempList[0];
                    _sellingID = _plantName +
                        HomeScreen.user.userName +
                        _minValue.toString();
                    _sellingID = _sellingID.replaceAll(" ", "");
                    SellPostsData addSellPost = SellPostsData(
                      plantName: _plantName,
                      plantID: _sellingID,
                      plantImage: _plantImage!.path,
                      date: _date,
                      location: _sellerHomeAddress,
                      upzilla: _upzilla,
                      district: _district,
                      division: _division,
                      price: _plantPrice,
                      note: _note,
                      soldPlants: 0,
                      totalPlants: _plantAvailableItem,
                      sellerName: HomeScreen.user.fullName,
                      sellerID: HomeScreen.user.userName,
                    );
                    bool _isUploaded = await _plantsDataManagement
                        .uploadPlantSellPost(addSellPost);
                    if (_isUploaded) {
                      print(addSellPost.plantID);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Upload",
                    style: TextStyle(
                      color: kBackgroundColor,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
              "Please choose media to seletct",
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
}

int findingIndex(
    {required List<String> districtList, required String district}) {
  int index = 0;
  for (int i = 0; i < districtList.length; i++) {
    if (district == districtList[i]) {
      index = i;
    }
  }
  return index;
}
