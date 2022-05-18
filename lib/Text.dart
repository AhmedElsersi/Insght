import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class TextRecognition extends StatefulWidget {
  const TextRecognition({Key? key}) : super(key: key);

  @override
  _TextRecognitionState createState() => _TextRecognitionState();
}

class _TextRecognitionState extends State<TextRecognition> {
  // @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
  }

  String result = 'Result To Be Shown Here ';
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
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText recognisedText =
        await textDetector.processImage(inputimage);
    result = '';
    setState(() {
      for (TextBlock block in recognisedText.blocks) {
        final String txt = block.text;
        for (TextLine line in block.lines) {
          for (TextElement element in line.elements) {
            result += element.text + ' ';
          }
        }
        result += "\n\n";
      }
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
              'icons/insight1.png',
              semanticLabel: 'Insight OCR',
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
            ),
          ],
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
