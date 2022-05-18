import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class ObjectRecognition extends StatefulWidget {
  const ObjectRecognition({Key? key}) : super(key: key);

  @override
  _ObjectRecognitionState createState() => _ObjectRecognitionState();
}

class _ObjectRecognitionState extends State<ObjectRecognition> {
  // @override
  late ImageLabeler imageLabeler;
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
    imageLabeler = GoogleMlKit.vision.imageLabeler();
  }

  void deactivate() {
    imageLabeler.close();
  }

  String result = 'Result To Be Shown Here';
  String result1 = '';
  String result2 = '';
  File? image;
  ImagePicker? imagePicker;

  pickimagefromgallery() async {
    PickedFile? pickedfile =
        await imagePicker!.getImage(source: ImageSource.gallery);
    image = File(pickedfile!.path);
    setState(() {
      image;
      performimage();
    });
  }

  pickimagefromcamera() async {
    PickedFile? pickedfile =
        await imagePicker!.getImage(source: ImageSource.camera);
    image = File(pickedfile!.path);
    setState(() {
      image;
      performimage();
    });
  }

  performimage() async {
    final inputimage = InputImage.fromFile(image!);

    final List<ImageLabel> labels = await imageLabeler.processImage(inputimage);

    result = '';

    setState(() {
      for (ImageLabel label in labels) {
        final String text = label.label;
        final int index = label.index;
        final double confidence = label.confidence;

        result += text + '  ' + confidence.toStringAsFixed(2) + "\n";
        // result1 += index.toString();
        // result2 += confidence.toString();
      }
      setState(() {
        result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Center(
            child: Image.asset(
              'icons/insight2.png',
              semanticLabel: 'Insight VOR',
              scale: 5,
            ),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  alignment: Alignment.center,
                  // height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFCAF0F8),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFF48CAE4), width: 6)),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        result,
                        style:
                        TextStyle(fontSize: 24, color: Color(0xFF03045E)),
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        image!,
                        fit: BoxFit.scaleDown,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            pickimagefromgallery();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.image,
                                  size: 100,
                                  color: Color(0xFF0077B6),
                                ),
                                Text(
                                  'Gallery',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Color(0xFF0077B6),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            pickimagefromcamera();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 100,
                                  color: Color(0xFF0077B6),
                                ),
                                Text(
                                  'Camera',
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Color(0xFF0077B6),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: image != null
                    ? Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Color(0xFF03045E),
                      borderRadius: BorderRadius.circular(20),
                      // border: Border.all(color: Color(0xFF48CAE4), width: 6),
                    ),
                    child:GestureDetector(
                      onTap: (){
                        setState(() {
                          image = null;
                          result = 'Result To Be Shown Here ';
                        });
                      },
                      child: Text('Load Another Image',style:
                      TextStyle(fontSize: 20, color: Color(0xFF00B4D8)),),
                    ))
                    : Container(),
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
