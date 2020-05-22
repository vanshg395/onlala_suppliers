import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:onlala_suppliers/screens/video_preview_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/common_field.dart';
import '../widgets/common_button.dart';
import '../widgets/dropdown.dart';
import '../utils/constants.dart';
import './pdf_screen.dart';
import '../providers/auth.dart';

class ProductUploadScreen extends StatefulWidget {
  @override
  _ProductUploadScreenState createState() => _ProductUploadScreenState();

  final String deptName;
  final String catName;
  final String subcatName;
  final String subCatId;

  ProductUploadScreen(
      this.deptName, this.catName, this.subcatName, this.subCatId);
}

class _ProductUploadScreenState extends State<ProductUploadScreen> {
  int _currentPart = 1;
  bool _isLoading = false;
  Map<String, dynamic> _data = {
    'manufacturer_type': 'Manufacturer',
    'sample': 1,
    'bulk_order': 1,
    'time_range': '-',
  };

  Map<String, dynamic> _media = {
    'additional_images': [],
    'additional_videos': [],
    'catalogues': [],
  };

  GlobalKey<FormState> _formKey1 = GlobalKey();
  GlobalKey<FormState> _formKey2 = GlobalKey();
  GlobalKey<FormState> _formKey3 = GlobalKey();
  GlobalKey<FormState> _formKey4 = GlobalKey();
  String _sampleDimensionUnit;
  String _sampleWeightUnit;
  String _samplePolicyChoice = '1';
  String _paymentChoice = '1';
  String _portChoice = '1';
  String _samplePolicy;
  String _paymentMethod;
  String _portName;
  String _bulkPriceType;
  String _bulkPriceUnit;
  String _cartonWeightUnit;
  String _cartonDimensionUnit;
  bool _techTransfer = false;
  String _countryCode;

  @override
  void initState() {
    super.initState();
    getIp();
  }

  @override
  void dispose() {
    for (int i = 0; i < 25; i++) {
      _controllers[i].dispose();
    }
    super.dispose();
  }

  Future<void> getIp() async {
    try {
      final response = await http.get(
          'http://api.ipapi.com/api/check?access_key=95235ad01973864b1878b2ff1c4e9bc6');
      print(response.statusCode);
      if (response.statusCode == 200) {
        final resBody = json.decode(response.body);
        setState(() {
          _countryCode = resBody['country_code'];
        });
        print(_countryCode);
      }
    } catch (e) {
      print(e);
    }
  }

  List<TextEditingController> _controllers = [
    for (int i = 0; i < 25; i++) TextEditingController()
  ];

  List<FocusNode> _focus = [for (int i = 0; i < 25; i++) FocusNode()];

  void _submitPart1() {
    _formKey1.currentState.save();
    if (!_formKey1.currentState.validate()) {
      return;
    }
    setState(() {
      _currentPart++;
    });
  }

  void _submitPart2() {
    _formKey2.currentState.save();
    if (!_formKey2.currentState.validate()) {
      return;
    }
    if (_media['primary_image'] == null) {
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Error'),
          content: Text('Primary Image is not uploaded.'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      return;
    }
    setState(() {
      _currentPart++;
    });
  }

  void _submitPart3() {
    _formKey3.currentState.save();
    if (!_formKey3.currentState.validate()) {
      return;
    }
    if (_data['expiry_date'] == null) {
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Error'),
          content: Text('Expiry Date is note entered.'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      return;
    }
    setState(() {
      _currentPart++;
    });
  }

  Future<void> _submitPart4() async {
    FocusScope.of(context).unfocus();
    _formKey4.currentState.save();
    _data['tech_transfer_investment'] = _techTransfer ? 1 : 0;
    if (!_formKey4.currentState.validate()) {
      return;
    }
    if (_media['catalogues'] == []) {
      showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Error'),
          content: Text('Catalogue is not uploaded.'),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      print(_data);
      // print(_media);
      final url = baseUrl + 'product/add/';
      final response = await http.post(
        url,
        headers: {
          'Authorization': Provider.of<Auth>(context, listen: false).token,
          'Content-Type': 'application/json',
        },
        body: json.encode(_data),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 201) {
        final resBody = json.decode(response.body);
        final url2 = baseUrl + 'product/link/';
        final response2 = await http.post(
          url2,
          headers: {
            'Authorization': Provider.of<Auth>(context, listen: false).token,
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'sub_category': widget.subCatId,
            'sample': resBody['payload']['sample'],
            'product': resBody['payload']['product']['id'],
            'bulk_order': resBody['payload']['bulk_order'],
            'carton': resBody['payload']['carton'],
            'creator': Provider.of<Auth>(context, listen: false).userDetails[0]
                ['id'],
          }),
        );
        print(response2.statusCode);
        print(response2.body);
        if (response2.statusCode == 201) {
          final imageUploadUrl = baseUrl + 'product/image/add/';

          final multipartRequest1 =
              new http.MultipartRequest('POST', Uri.parse(imageUploadUrl));
          multipartRequest1.headers.addAll(
            {
              'Authorization': Provider.of<Auth>(context, listen: false).token,
              'Content-Type': 'application/json',
            },
          );
          final multipartFile1 = await http.MultipartFile.fromPath(
            'product_image',
            _media['primary_image'],
          );
          multipartRequest1.fields['image_name'] = 'Primary Image';
          multipartRequest1.fields['product'] =
              resBody['payload']['product']['id'];
          multipartRequest1.files.add(multipartFile1);
          final response3 = await multipartRequest1.send();
          print(response3.statusCode);
          print(await response3.stream.bytesToString());

          for (int i = 0; i < _media['additional_images'].length; i++) {
            final multipartRequest =
                new http.MultipartRequest('POST', Uri.parse(imageUploadUrl));
            multipartRequest.headers.addAll(
              {
                'Authorization':
                    Provider.of<Auth>(context, listen: false).token,
                'Content-Type': 'application/json',
              },
            );
            final multipartFile = await http.MultipartFile.fromPath(
              'product_image',
              _media['additional_images'][i],
            );
            multipartRequest.files.add(multipartFile);
            multipartRequest.fields['product'] =
                resBody['payload']['product']['id'];

            final response3 = await multipartRequest.send();
            print(response3.statusCode);
            print(await response3.stream.bytesToString());
          }

          final uploadVideoUrl = baseUrl + 'product/video/add/';

          final multipartRequest2 =
              new http.MultipartRequest('POST', Uri.parse(uploadVideoUrl));
          multipartRequest2.headers.addAll(
            {
              'Authorization': Provider.of<Auth>(context, listen: false).token,
              'Content-Type': 'application/json',
            },
          );
          final multipartFile2 = await http.MultipartFile.fromPath(
            'product_video',
            _media['primary_video'],
          );
          multipartRequest2.fields['video_name'] = 'Primary Video';
          multipartRequest2.fields['product'] =
              resBody['payload']['product']['id'];
          multipartRequest2.files.add(multipartFile2);
          final response4 = await multipartRequest2.send();
          print(response4.statusCode);
          print(await response4.stream.bytesToString());

          for (int i = 0; i < _media['additional_videos'].length; i++) {
            final multipartRequest =
                new http.MultipartRequest('POST', Uri.parse(uploadVideoUrl));
            multipartRequest.headers.addAll(
              {
                'Authorization':
                    Provider.of<Auth>(context, listen: false).token,
                'Content-Type': 'application/json',
              },
            );
            final multipartFile = await http.MultipartFile.fromPath(
              'product_video',
              _media['additional_videos'][i],
            );
            multipartRequest.files.add(multipartFile);
            multipartRequest.fields['product'] =
                resBody['payload']['product']['id'];

            final response4 = await multipartRequest.send();
            print(response4.statusCode);
            print(await response4.stream.bytesToString());
          }

          final uploadCatalogueUrl = baseUrl + 'product/catalogue/add/';
          for (int i = 0; i < _media['catalogues'].length; i++) {
            final multipartRequest4 = new http.MultipartRequest(
                'POST', Uri.parse(uploadCatalogueUrl));
            multipartRequest4.headers.addAll(
              {
                'Authorization':
                    Provider.of<Auth>(context, listen: false).token,
                'Content-Type': 'application/json',
              },
            );
            final multipartFile4 = await http.MultipartFile.fromPath(
              'product_catalog',
              _media['catalogues'][i],
            );
            if (i == 1)
              multipartRequest4.fields['catalg_name'] = 'Primary Catalogue';
            multipartRequest4.fields['product'] =
                resBody['payload']['product']['id'];
            multipartRequest4.files.add(multipartFile4);
            final response5 = await multipartRequest4.send();
            print(response5.statusCode);
            print(await response5.stream.bytesToString());
          }
        } else {
          await showDialog(
            context: context,
            child: AlertDialog(
              title: Text('Error'),
              content: Text('Something went wrong. Please try again later.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
      } else {
        await showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Error'),
            content: Text('Something went wrong. Please try again later.'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  Widget pU1View() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Text(
                'Product Info',
                style: Theme.of(context).primaryTextTheme.subtitle,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Select Type (Manufacturer)',
                style: Theme.of(context).primaryTextTheme.headline,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'Manufacturer',
                    groupValue: _data['manufacturer_type'],
                    onChanged: (value) {
                      setState(() {
                        _data['manufacturer_type'] = value;
                      });
                    },
                  ),
                  Text('Manufacturer'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'OEM_OBS',
                    groupValue: _data['manufacturer_type'],
                    onChanged: (value) {
                      setState(() {
                        _data['manufacturer_type'] = value;
                      });
                    },
                  ),
                  Text('OEM Own Brand'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'Trader',
                    groupValue: _data['manufacturer_type'],
                    onChanged: (value) {
                      setState(() {
                        _data['manufacturer_type'] = value;
                      });
                    },
                  ),
                  Text('Trader'),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Enter Minimum Quantity',
                style: Theme.of(context).primaryTextTheme.headline,
              ),
              SizedBox(
                height: 10,
              ),
              CommonField(
                placeholder: '0',
                borderColor: Colors.white,
                bgColor: Colors.white,
                fontSize: 16,
                borderRadius: 5,
                keyboardType: TextInputType.number,
                controller: _controllers[0],
                focusNode: _focus[0],
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focus[1]);
                },
                validator: (value) {
                  if (value == '') {
                    return 'This field is required.';
                  }
                },
                onSaved: (value) {
                  _data['sub_category'] = widget.subCatId;
                  _data['minimum_order_quantity'] = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Product Name',
                style: Theme.of(context).primaryTextTheme.headline,
              ),
              SizedBox(
                height: 10,
              ),
              CommonField(
                placeholder: 'Eg. Smart Video Doorbell',
                borderColor: Colors.white,
                maxLength: 30,
                bgColor: Colors.white,
                fontSize: 16,
                borderRadius: 5,
                focusNode: _focus[1],
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focus[2]);
                },
                controller: _controllers[1],
                validator: (value) {
                  if (value == '') {
                    return 'This field is required.';
                  }
                  if (value.length > 50) {
                    return 'Max Length is 50 characters.';
                  }
                },
                onSaved: (value) {
                  _data['product_name'] = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Product Description',
                style: Theme.of(context).primaryTextTheme.headline,
              ),
              SizedBox(
                height: 10,
              ),
              CommonField(
                placeholder: 'This is a smart Video Doorbell that rings.',
                maxLines: 5,
                maxLength: 1500,
                topPadding: 50,
                borderColor: Colors.white,
                bgColor: Colors.white,
                fontSize: 16,
                focusNode: _focus[2],
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focus[3]);
                },
                controller: _controllers[2],
                borderRadius: 5,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value == '') {
                    return 'This field is required.';
                  }
                },
                onSaved: (value) {
                  _data['product_description'] = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Industry Name',
                style: Theme.of(context).primaryTextTheme.headline,
              ),
              SizedBox(
                height: 10,
              ),
              CommonField(
                placeholder: 'Smart Bell, Sensor Bell',
                borderColor: Colors.white,
                bgColor: Colors.white,
                fontSize: 16,
                controller: _controllers[3],
                focusNode: _focus[3],
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focus[4]);
                },
                borderRadius: 5,
                validator: (value) {
                  if (value == '') {
                    return 'This field is required.';
                  }
                },
                onSaved: (value) {
                  _data['industry_name'] = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Other Synonyms',
                style: Theme.of(context).primaryTextTheme.headline,
              ),
              SizedBox(
                height: 10,
              ),
              CommonField(
                placeholder: 'Smart Bell, Sensor Bell',
                borderColor: Colors.white,
                bgColor: Colors.white,
                fontSize: 16,
                controller: _controllers[4],
                focusNode: _focus[4],
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focus[5]);
                },
                borderRadius: 5,
                validator: (value) {
                  if (value == '') {
                    return 'This field is required.';
                  }
                },
                onSaved: (value) {
                  _data['other_synonyms'] = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Model No. / Size',
                style: Theme.of(context).primaryTextTheme.headline,
              ),
              SizedBox(
                height: 10,
              ),
              CommonField(
                placeholder: 'ABCXXX',
                borderColor: Colors.white,
                bgColor: Colors.white,
                fontSize: 16,
                borderRadius: 5,
                controller: _controllers[5],
                focusNode: _focus[5],
                onFieldSubmitted: (_) {
                  FocusScope.of(context).unfocus();
                },
                validator: (value) {
                  if (value == '') {
                    return 'This field is required.';
                  }
                },
                onSaved: (value) {
                  _data['model_no'] = value;
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CommonButton(
                    bgColor: Theme.of(context).primaryColor,
                    borderColor: Theme.of(context).primaryColor,
                    title: 'NEXT',
                    textColor: Colors.white,
                    fontSize: 16,
                    // width: double.infinity,
                    borderRadius: 5,
                    width: 150,
                    onPressed: () {
                      _submitPart1();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pU2View() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Text(
                'Product Image',
                style: Theme.of(context).primaryTextTheme.subtitle,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 0.1,
                      color: Colors.grey,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Primary Product Image',
                      style: Theme.of(context).primaryTextTheme.headline,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CommonButton(
                      bgColor: Color(0xFFE9F0F3),
                      borderColor: Color(0xFFE9F0F3),
                      title: 'Upload File',
                      textColor: Theme.of(context).primaryColor,
                      fontSize: 16,
                      width: double.infinity,
                      borderRadius: 5,
                      onPressed: () async {
                        final filePath = await FilePicker.getFilePath(
                          type: FileType.image,
                        );
                        if (filePath == null) {
                          return;
                        }
                        File croppedFile = await ImageCropper.cropImage(
                          sourcePath: filePath,
                          aspectRatioPresets: [
                            CropAspectRatioPreset.square,
                            CropAspectRatioPreset.ratio3x2,
                            CropAspectRatioPreset.original,
                            CropAspectRatioPreset.ratio4x3,
                            CropAspectRatioPreset.ratio16x9
                          ],
                          androidUiSettings: AndroidUiSettings(
                            toolbarTitle: 'Cropper',
                            toolbarColor: Theme.of(context).primaryColor,
                            activeControlsWidgetColor:
                                Theme.of(context).primaryColor,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.original,
                            lockAspectRatio: false,
                          ),
                          iosUiSettings: IOSUiSettings(
                            minimumAspectRatio: 1.0,
                            showCancelConfirmationDialog: true,
                          ),
                        );
                        final multipartFile = await http.MultipartFile.fromPath(
                          'catalg',
                          croppedFile.path,
                        );
                        final length = multipartFile.length;
                        if (length > 5242880) {
                          await showDialog(
                            context: context,
                            child: AlertDialog(
                              title: Text('File is Too Large'),
                              content: Text(
                                  'Maximum File Size is 5MB. Please choose a smaller file.'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          );
                          return;
                        }
                        setState(() {
                          _media['primary_image'] = croppedFile.path;
                        });
                      },
                    ),
                    if (_media['primary_image'] != null) ...[
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Stack(
                          children: <Widget>[
                            // Image.asset(
                            //   _media['primary_image'],
                            //   width: 100,
                            // ),
                            Image.file(
                              File(
                                _media['primary_image'],
                              ),
                              width: 100,
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    _media['primary_image'] = null;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ]
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 0.1,
                      color: Colors.grey,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Additional Images',
                      style: Theme.of(context).primaryTextTheme.headline,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (_media['additional_images'].length < 10)
                      CommonButton(
                        bgColor: Color(0xFFE9F0F3),
                        borderColor: Color(0xFFE9F0F3),
                        title: 'Upload File',
                        textColor: Theme.of(context).primaryColor,
                        fontSize: 16,
                        width: double.infinity,
                        borderRadius: 5,
                        onPressed: _media['additional_images'].length < 10
                            ? () async {
                                final filePath = await FilePicker.getFilePath(
                                  type: FileType.image,
                                );
                                if (filePath == null) {
                                  return;
                                }
                                File croppedFile = await ImageCropper.cropImage(
                                  sourcePath: filePath,
                                  aspectRatioPresets: [
                                    CropAspectRatioPreset.square,
                                    CropAspectRatioPreset.ratio3x2,
                                    CropAspectRatioPreset.original,
                                    CropAspectRatioPreset.ratio4x3,
                                    CropAspectRatioPreset.ratio16x9
                                  ],
                                  androidUiSettings: AndroidUiSettings(
                                    toolbarTitle: 'Cropper',
                                    toolbarColor:
                                        Theme.of(context).primaryColor,
                                    activeControlsWidgetColor:
                                        Theme.of(context).primaryColor,
                                    toolbarWidgetColor: Colors.white,
                                    initAspectRatio:
                                        CropAspectRatioPreset.original,
                                    lockAspectRatio: false,
                                  ),
                                  iosUiSettings: IOSUiSettings(
                                    minimumAspectRatio: 1.0,
                                    showCancelConfirmationDialog: true,
                                  ),
                                );
                                final multipartFile =
                                    await http.MultipartFile.fromPath(
                                  'catalg',
                                  croppedFile.path,
                                );
                                final length = multipartFile.length;
                                if (length > 5242880) {
                                  await showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      title: Text('File is Too Large'),
                                      content: Text(
                                          'Maximum File Size is 5MB. Please choose a smaller file.'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('OK'),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ],
                                    ),
                                  );
                                  return;
                                }
                                setState(() {
                                  _media['additional_images']
                                      .add(croppedFile.path);
                                });
                              }
                            : null,
                      ),
                    if (_media['additional_images'].length != 0) ...[
                      SizedBox(
                        height: 20,
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisSpacing: 5,
                        crossAxisCount: 3,
                        children: [
                          ..._media['additional_images']
                              .map(
                                (image) => Center(
                                    child: Stack(
                                  children: <Widget>[
                                    Image.file(
                                      File(image),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _media['additional_images']
                                                .remove(image);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                              )
                              .toList()
                        ],
                      )
                    ]
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 0.1,
                      color: Colors.grey,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Primary Product Video',
                      style: Theme.of(context).primaryTextTheme.headline,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CommonButton(
                      bgColor: Color(0xFFE9F0F3),
                      borderColor: Color(0xFFE9F0F3),
                      title: 'Upload File',
                      textColor: Theme.of(context).primaryColor,
                      fontSize: 16,
                      width: double.infinity,
                      borderRadius: 5,
                      onPressed: () async {
                        final filePath = await FilePicker.getFilePath(
                          type: FileType.video,
                        );
                        if (filePath == null) {
                          return;
                        }
                        final multipartFile = await http.MultipartFile.fromPath(
                          'catalg',
                          filePath,
                        );
                        final length = multipartFile.length;
                        if (length > 5242880) {
                          await showDialog(
                            context: context,
                            child: AlertDialog(
                              title: Text('File is Too Large'),
                              content: Text(
                                  'Maximum File Size is 5MB. Please choose a smaller file.'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          );
                          return;
                        }
                        setState(() {
                          _media['primary_video'] = filePath;
                        });
                      },
                    ),
                    if (_media['primary_video'] != null) ...[
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(5),
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                child: Icon(
                                  Icons.play_circle_filled,
                                  size: 40,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => VideoPreviewScreen(
                                        _media['primary_video']),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              InkWell(
                                child: Icon(
                                  Icons.delete,
                                  size: 40,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  setState(() {
                                    _media['primary_video'] = null;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 0.1,
                      color: Colors.grey,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Additional Videos',
                      style: Theme.of(context).primaryTextTheme.headline,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CommonButton(
                      bgColor: Color(0xFFE9F0F3),
                      borderColor: Color(0xFFE9F0F3),
                      title: 'Upload File',
                      textColor: Theme.of(context).primaryColor,
                      fontSize: 16,
                      width: double.infinity,
                      borderRadius: 5,
                      onPressed: _media['additional_videos'].length < 10
                          ? () async {
                              final filePath = await FilePicker.getFilePath(
                                type: FileType.video,
                              );
                              if (filePath == null) {
                                return;
                              }
                              final multipartFile =
                                  await http.MultipartFile.fromPath(
                                'catalg',
                                filePath,
                              );
                              final length = multipartFile.length;
                              if (length > 5242880) {
                                await showDialog(
                                  context: context,
                                  child: AlertDialog(
                                    title: Text('File is Too Large'),
                                    content: Text(
                                        'Maximum File Size is 5MB. Please choose a smaller file.'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text('OK'),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              }
                              setState(() {
                                _media['additional_videos'].add(filePath);
                              });
                            }
                          : null,
                    ),
                    if (_media['additional_videos'].length != 0) ...[
                      SizedBox(
                        height: 20,
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisSpacing: 5,
                        crossAxisCount: 3,
                        children: [
                          ..._media['additional_videos']
                              .map(
                                (video) => Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: <Widget>[
                                      InkWell(
                                        child: Icon(
                                          Icons.play_circle_filled,
                                          size: 40,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) =>
                                                VideoPreviewScreen(video),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      InkWell(
                                        child: Icon(
                                          Icons.delete,
                                          size: 40,
                                          color: Colors.red,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _media['additional_videos']
                                                .remove(video);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList()
                        ],
                      )
                    ]
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CommonButton(
                    bgColor: Color(0xFFE9F0F3),
                    borderColor: Color(0xFFE9F0F3),
                    title: 'BACK',
                    textColor: Theme.of(context).accentColor,
                    fontSize: 16,
                    // width: double.infinity,
                    borderRadius: 5,
                    width: 150,
                    onPressed: () {
                      setState(() {
                        _currentPart--;
                      });
                    },
                  ),
                  CommonButton(
                    bgColor: Theme.of(context).primaryColor,
                    borderColor: Theme.of(context).primaryColor,
                    title: 'NEXT',
                    textColor: Colors.white,
                    fontSize: 16,
                    // width: double.infinity,
                    borderRadius: 5,
                    width: 150,
                    onPressed: () {
                      _submitPart2();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pU3View() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Text(
                'Sample Product Details',
                style: Theme.of(context).primaryTextTheme.subtitle,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Sample Availablity',
                style: Theme.of(context).primaryTextTheme.headline,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: _data['sample'],
                          onChanged: (value) {
                            setState(() {
                              _data['sample'] = value;
                            });
                          },
                        ),
                        Text('Yes'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: _data['sample'],
                          onChanged: (value) {
                            setState(() {
                              _data['sample'] = value;
                            });
                          },
                        ),
                        Text('No'),
                      ],
                    ),
                  ),
                ],
              ),
              if (_data['sample'] == 1) ...[
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Sample Policy',
                  style: Theme.of(context).primaryTextTheme.headline,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      value: '1',
                      groupValue: _samplePolicyChoice,
                      onChanged: (value) {
                        setState(() {
                          _samplePolicyChoice = value;
                        });
                      },
                    ),
                    Text('Select a Sample Policy from the list'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Radio(
                      value: '2',
                      groupValue: _samplePolicyChoice,
                      onChanged: (value) {
                        setState(() {
                          _samplePolicyChoice = value;
                        });
                      },
                    ),
                    Text('Enter your own Sample Policy'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                if (_samplePolicyChoice == '1')
                  MultilineDropdownButtonFormField(
                    isExpanded: true,
                    items: [
                      if (_countryCode != 'IN') ...[
                        DropdownMenuItem(
                          child: Text(
                            'Free samples are available',
                            softWrap: false,
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontFamily: Theme.of(context)
                                  .primaryTextTheme
                                  .display1
                                  .fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          value: 'Free samples are available',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Samples are free within a certain price range',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontFamily: Theme.of(context)
                                  .primaryTextTheme
                                  .display1
                                  .fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          value:
                              'Samples are free within a certain price range',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'We offer free samples, with shipping and charges paid by buyer',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontFamily: Theme.of(context)
                                  .primaryTextTheme
                                  .display1
                                  .fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          value:
                              'We offer free samples, with shipping and charges paid by buyer',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'We offer free samples, and will pay for sample costs, shipping and taxes',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontFamily: Theme.of(context)
                                  .primaryTextTheme
                                  .display1
                                  .fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          value:
                              'We offer free samples, and will pay for sample costs, shipping and taxes',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'We offer samples, with sample costs, shipping and taxes paid by buyer',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontFamily: Theme.of(context)
                                  .primaryTextTheme
                                  .display1
                                  .fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          value:
                              'We offer samples, with sample costs, shipping and taxes paid by buyer',
                        ),
                      ],
                      DropdownMenuItem(
                        child: Text(
                          'We don\'t offer free samples, but will reimburse the buyer once an order is confirmed',
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontFamily: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .fontFamily,
                            fontSize: 16,
                          ),
                        ),
                        value:
                            'We don\'t offer free samples, but will reimburse the buyer once an order is confirmed',
                      ),
                      DropdownMenuItem(
                        child: Text(
                          'Contact us for information regarding our sample policy',
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
                            fontFamily: Theme.of(context)
                                .primaryTextTheme
                                .display1
                                .fontFamily,
                            fontSize: 16,
                          ),
                        ),
                        value:
                            'Contact us for information regarding our sample policy',
                      ),
                    ],
                    value: _samplePolicy,
                    iconSize: 30,
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                    iconEnabledColor: Theme.of(context).cardColor,
                    iconDisabledColor: Theme.of(context).cardColor,
                    onChanged: (val) {
                      setState(() {
                        _samplePolicy = val;
                      });
                    },
                    onSaved: (value) {
                      _data['sample_policy'] = value;
                    },
                    validator: (value) {
                      if (_data['sample_policy'] == null) {
                        return 'This field is required.';
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0,
                        ),
                      ),
                      hintText: 'Sample Policy',
                      hintStyle: TextStyle(
                        fontSize: 16,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 16,
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 30,
                        right: 10,
                      ),
                      errorStyle: TextStyle(color: Colors.red[200]),
                    ),

                    // validator: (value) {
                    //   if (value == null) {
                    //     return 'This field is required.';
                    //   }
                    // },
                    // onSaved: (value) {
                    //   _data['identity_choice'] = value;
                    // },
                  )
                else if (_samplePolicyChoice == '2')
                  CommonField(
                    placeholder: 'Enter your Sample Policy',
                    borderColor: Colors.white,
                    bgColor: Colors.white,
                    fontSize: 16,
                    borderRadius: 5,
                    controller: _controllers[6],
                    focusNode: _focus[6],
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_focus[7]);
                    },
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == '') {
                        return 'This field is required.';
                      }
                    },
                    onSaved: (value) {
                      _data['sample_policy'] = value;
                    },
                  ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Sample Cost in EURO',
                  style: Theme.of(context).primaryTextTheme.headline,
                ),
                SizedBox(
                  height: 10,
                ),
                CommonField(
                  placeholder: '500',
                  borderColor: Colors.white,
                  bgColor: Colors.white,
                  fontSize: 16,
                  controller: _controllers[7],
                  focusNode: _focus[7],
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_focus[8]);
                  },
                  borderRadius: 5,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == '') {
                      return 'This field is required.';
                    }
                  },
                  onSaved: (value) {
                    _data['sample_cost'] = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 0.1,
                        color: Colors.grey,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Dimension per Unit (For Courier)',
                        style: Theme.of(context).primaryTextTheme.headline,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CommonField(
                        placeholder: 'Length',
                        borderColor: Colors.grey,
                        bgColor: Colors.white,
                        fontSize: 16,
                        controller: _controllers[8],
                        focusNode: _focus[8],
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_focus[9]);
                        },
                        borderRadius: 5,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == '') {
                            return 'This field is required.';
                          }
                        },
                        onSaved: (value) {
                          _data['sample_dimension_length'] = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CommonField(
                        placeholder: 'Width',
                        borderColor: Colors.grey,
                        controller: _controllers[9],
                        focusNode: _focus[9],
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_focus[10]);
                        },
                        bgColor: Colors.white,
                        fontSize: 16,
                        borderRadius: 5,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == '') {
                            return 'This field is required.';
                          }
                        },
                        onSaved: (value) {
                          _data['sample_dimension_width'] = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CommonField(
                        placeholder: 'Height',
                        borderColor: Colors.grey,
                        controller: _controllers[10],
                        focusNode: _focus[10],
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_focus[11]);
                        },
                        bgColor: Colors.white,
                        fontSize: 16,
                        borderRadius: 5,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == '') {
                            return 'This field is required.';
                          }
                        },
                        onSaved: (value) {
                          _data['sample_dimension_height'] = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MultilineDropdownButtonFormField(
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'Meters',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Meters',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Centimeters',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Centimeters',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Feet',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Feet',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Inches',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Inches',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Yards',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Yards',
                          ),
                        ],
                        value: _sampleDimensionUnit,
                        iconSize: 30,
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                        iconEnabledColor: Theme.of(context).cardColor,
                        iconDisabledColor: Theme.of(context).cardColor,
                        onChanged: (val) {
                          setState(() {
                            _sampleDimensionUnit = val;
                          });
                        },
                        validator: (value) {
                          if (_data['sample_dimension_unit'] == null) {
                            return 'This field is required.';
                          }
                        },
                        onSaved: (value) {
                          _data['sample_dimension_unit'] = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          alignLabelWithHint: true,
                          hintText: 'Unit',
                          hintStyle: TextStyle(
                            fontSize: 16,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 16,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 30,
                            right: 10,
                          ),
                          errorStyle: TextStyle(color: Colors.red[200]),
                        ),

                        // validator: (value) {
                        //   if (value == null) {
                        //     return 'This field is required.';
                        //   }
                        // },
                        // onSaved: (value) {
                        //   _data['identity_choice'] = value;
                        // },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 0.1,
                        color: Colors.grey,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Weight per Unit (For Courier)',
                        style: Theme.of(context).primaryTextTheme.headline,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CommonField(
                        placeholder: 'Weight',
                        borderColor: Colors.grey,
                        controller: _controllers[11],
                        focusNode: _focus[11],
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_focus[12]);
                        },
                        bgColor: Colors.white,
                        fontSize: 16,
                        borderRadius: 5,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == '') {
                            return 'This field is required.';
                          }
                        },
                        onSaved: (value) {
                          _data['sample_weight'] = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MultilineDropdownButtonFormField(
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'Grams',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Grams',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Kilograms',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Kilograms',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Metric Tonnes',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Metric Tonnes',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Pounds',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Pounds',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Tons (US)',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Tons (US)',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Tons (UK)',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Tons (UK)',
                          ),
                        ],
                        validator: (value) {
                          if (_data['sample_weight_unit'] == null) {
                            return 'This field is required.';
                          }
                        },
                        onSaved: (value) {
                          _data['sample_weight_unit'] = value;
                        },
                        value: _sampleWeightUnit,
                        iconSize: 30,
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                        iconEnabledColor: Theme.of(context).cardColor,
                        iconDisabledColor: Theme.of(context).cardColor,
                        onChanged: (val) {
                          setState(() {
                            _sampleWeightUnit = val;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          alignLabelWithHint: true,
                          hintText: 'Unit',
                          hintStyle: TextStyle(
                            fontSize: 16,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 16,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 30,
                            right: 10,
                          ),
                          errorStyle: TextStyle(color: Colors.red[200]),
                        ),

                        // validator: (value) {
                        //   if (value == null) {
                        //     return 'This field is required.';
                        //   }
                        // },
                        // onSaved: (value) {
                        //   _data['identity_choice'] = value;
                        // },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 0.1,
                        color: Colors.grey,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Order Lead Time Range',
                        style: Theme.of(context).primaryTextTheme.headline,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CommonField(
                        placeholder: 'Minimum Days',
                        borderColor: Colors.grey,
                        controller: _controllers[12],
                        focusNode: _focus[12],
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_focus[13]);
                        },
                        bgColor: Colors.white,
                        fontSize: 16,
                        borderRadius: 5,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == '') {
                            return 'This field is required.';
                          }
                        },
                        onSaved: (value) {
                          _data['sample_from_time_range'] = value;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Text('Days to'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CommonField(
                        placeholder: 'Maximum Days',
                        borderColor: Colors.grey,
                        controller: _controllers[13],
                        focusNode: _focus[13],
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        bgColor: Colors.white,
                        fontSize: 16,
                        borderRadius: 5,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == '') {
                            return 'This field is required.';
                          }
                        },
                        onSaved: (value) {
                          _data['sample_to_time_range'] = value;
                        },
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(
                height: 20,
              ),
              Text(
                'Expiry Date (Sample Products)',
                style: Theme.of(context).primaryTextTheme.headline,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  CommonButton(
                    bgColor: Color(0xFFE9F0F3),
                    borderColor: Color(0xFFE9F0F3),
                    title: 'Choose Expiry Date',
                    textColor: Theme.of(context).primaryColor,
                    fontSize: 16,
                    // width: double.infinity,
                    borderRadius: 5,
                    width: 200,
                    onPressed: () async {
                      final DateTime date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().add(Duration(days: 30)),
                        firstDate: DateTime.now().add(Duration(days: 30)),
                        lastDate: DateTime.now().add(Duration(days: 365 * 50)),
                      );
                      setState(() {
                        _data['expiry_date'] = date.toString().substring(0, 10);
                      });
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(_data['expiry_date'] ?? 'YYYY-MM-DD'),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CommonButton(
                    bgColor: Color(0xFFE9F0F3),
                    borderColor: Color(0xFFE9F0F3),
                    title: 'BACK',
                    textColor: Theme.of(context).accentColor,
                    fontSize: 16,
                    // width: double.infinity,
                    borderRadius: 5,
                    width: 150,
                    onPressed: () {
                      setState(() {
                        _currentPart--;
                      });
                    },
                  ),
                  CommonButton(
                    bgColor: Theme.of(context).primaryColor,
                    borderColor: Theme.of(context).primaryColor,
                    title: 'NEXT',
                    textColor: Colors.white,
                    fontSize: 16,
                    // width: double.infinity,
                    borderRadius: 5,
                    width: 150,
                    onPressed: () {
                      _submitPart3();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pU4View() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
              Text(
                'Payment Info',
                style: Theme.of(context).primaryTextTheme.subtitle,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 0.1,
                      color: Colors.grey,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Bulk Order Details',
                      style: Theme.of(context).primaryTextTheme.headline,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Bulk Order',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: _data['bulk_order'],
                                onChanged: (value) {
                                  setState(() {
                                    _data['bulk_order'] = value;
                                  });
                                },
                              ),
                              Text('Yes'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Radio(
                                value: 0,
                                groupValue: _data['bulk_order'],
                                onChanged: (value) {
                                  setState(() {
                                    _data['bulk_order'] = value;
                                  });
                                },
                              ),
                              Text('No'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (_data['bulk_order'] == 1) ...[
                      CommonField(
                        placeholder: 'Bulk Order Pricing (€)',
                        controller: _controllers[14],
                        focusNode: _focus[14],
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_focus[15]);
                        },
                        borderColor: Colors.grey,
                        bgColor: Colors.white,
                        fontSize: 16,
                        borderRadius: 5,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value == '') {
                            return 'This field is required.';
                          }
                        },
                        onSaved: (value) {
                          _data['bulk_order_price'] = value;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MultilineDropdownButtonFormField(
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'Piece',
                              softWrap: false,
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Piece',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Pieces',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Pieces',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Unit',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Unit',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Set',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Set',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Boxes',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Boxes',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Cartoons',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Cartoons',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Centimeters',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Centimeters',
                          ),
                        ],
                        value: _bulkPriceUnit,
                        iconSize: 30,
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                        iconEnabledColor: Theme.of(context).cardColor,
                        iconDisabledColor: Theme.of(context).cardColor,
                        onChanged: (val) {
                          setState(() {
                            _bulkPriceUnit = val;
                          });
                        },
                        onSaved: (value) {
                          _data['bulk_order_price_unit'] = value;
                        },
                        validator: (value) {
                          if (_data['bulk_order_price_unit'] == null) {
                            return 'This field is required.';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          hintText: 'Price Unit',
                          hintStyle: TextStyle(
                            fontSize: 16,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 16,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 30,
                            right: 10,
                          ),
                          errorStyle: TextStyle(color: Colors.red[200]),
                        ),

                        // validator: (value) {
                        //   if (value == null) {
                        //     return 'This field is required.';
                        //   }
                        // },
                        // onSaved: (value) {
                        //   _data['identity_choice'] = value;
                        // },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MultilineDropdownButtonFormField(
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'EX-FACTORY',
                              softWrap: false,
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'EX-FACTORY',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'FOB',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'FOB',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'CNF',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'CNF',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Set',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'Set',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'OTHER',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'OTHER',
                          ),
                        ],
                        value: _bulkPriceType,
                        iconSize: 30,
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                        iconEnabledColor: Theme.of(context).cardColor,
                        iconDisabledColor: Theme.of(context).cardColor,
                        onChanged: (val) {
                          setState(() {
                            _bulkPriceType = val;
                          });
                        },
                        onSaved: (value) {
                          _data['bulk_order_price_type'] = value;
                        },
                        validator: (value) {
                          if (_data['bulk_order_price_type'] == null) {
                            return 'This field is required.';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          hintText: 'Price Type',
                          hintStyle: TextStyle(
                            fontSize: 16,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 16,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 30,
                            right: 10,
                          ),
                          errorStyle: TextStyle(color: Colors.red[200]),
                        ),

                        // validator: (value) {
                        //   if (value == null) {
                        //     return 'This field is required.';
                        //   }
                        // },
                        // onSaved: (value) {
                        //   _data['identity_choice'] = value;
                        // },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Bulk Order Delivery Time',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CommonField(
                        placeholder: 'Minimum Days',
                        controller: _controllers[15],
                        focusNode: _focus[15],
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_focus[16]);
                        },
                        borderColor: Colors.grey,
                        bgColor: Colors.white,
                        fontSize: 16,
                        borderRadius: 5,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == '') {
                            return 'This field is required.';
                          }
                        },
                        onSaved: (value) {
                          _data['bulk_order_from_time_range'] = value;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Text('Days to'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CommonField(
                        placeholder: 'Maximum Days',
                        borderColor: Colors.grey,
                        controller: _controllers[16],
                        focusNode: _focus[16],
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_focus[17]);
                        },
                        bgColor: Colors.white,
                        fontSize: 16,
                        borderRadius: 5,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == '') {
                            return 'This field is required.';
                          }
                        },
                        onSaved: (value) {
                          _data['bulk_order_to_time_range'] = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Port Name',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: '1',
                            groupValue: _portChoice,
                            onChanged: (value) {
                              setState(() {
                                _portChoice = value;
                              });
                            },
                          ),
                          Text('Select from the list'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Radio(
                            value: '0',
                            groupValue: _portChoice,
                            onChanged: (value) {
                              setState(() {
                                _portChoice = value;
                              });
                            },
                          ),
                          Text('Enter Custom Port'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (_portChoice == '1')
                        MultilineDropdownButtonFormField(
                          isExpanded: true,
                          items: [
                            DropdownMenuItem(
                              child: Text(
                                'Haldia Port (Kolkata)',
                                softWrap: false,
                                style: TextStyle(
                                  color: Theme.of(context).cardColor,
                                  fontFamily: Theme.of(context)
                                      .primaryTextTheme
                                      .display1
                                      .fontFamily,
                                  fontSize: 16,
                                ),
                              ),
                              value: 'Haldia Port (Kolkata)',
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'Jawaharlal Nehru Port (Mumbai)',
                                style: TextStyle(
                                  color: Theme.of(context).cardColor,
                                  fontFamily: Theme.of(context)
                                      .primaryTextTheme
                                      .display1
                                      .fontFamily,
                                  fontSize: 16,
                                ),
                              ),
                              value: 'Jawaharlal Nehru Port (Mumbai)',
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'Kamarajar Port (Chennai)',
                                style: TextStyle(
                                  color: Theme.of(context).cardColor,
                                  fontFamily: Theme.of(context)
                                      .primaryTextTheme
                                      .display1
                                      .fontFamily,
                                  fontSize: 16,
                                ),
                              ),
                              value: 'Kamarajar Port (Chennai)',
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'Deendayal Port (Gujarat)',
                                style: TextStyle(
                                  color: Theme.of(context).cardColor,
                                  fontFamily: Theme.of(context)
                                      .primaryTextTheme
                                      .display1
                                      .fontFamily,
                                  fontSize: 16,
                                ),
                              ),
                              value: 'Deendayal Port (Gujarat)',
                            ),
                          ],
                          value: _portName,
                          iconSize: 30,
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Icon(Icons.keyboard_arrow_down),
                          ),
                          iconEnabledColor: Theme.of(context).cardColor,
                          iconDisabledColor: Theme.of(context).cardColor,
                          onChanged: (val) {
                            setState(() {
                              _portName = val;
                            });
                          },
                          onSaved: (value) {
                            _data['bulk_order_port'] = value;
                          },
                          validator: (value) {
                            if (_data['bulk_order_port'] == null) {
                              return 'This field is required.';
                            }
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0,
                              ),
                            ),
                            hintText: 'Choose Port Name',
                            hintStyle: TextStyle(
                              fontSize: 16,
                            ),
                            labelStyle: TextStyle(
                              fontSize: 16,
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 30,
                              right: 10,
                            ),
                            errorStyle: TextStyle(color: Colors.red[200]),
                          ),

                          // validator: (value) {
                          //   if (value == null) {
                          //     return 'This field is required.';
                          //   }
                          // },
                          // onSaved: (value) {
                          //   _data['identity_choice'] = value;
                          // },
                        )
                      else
                        CommonField(
                          placeholder: 'Port Name',
                          controller: _controllers[17],
                          focusNode: _focus[17],
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_focus[18]);
                          },
                          borderColor: Colors.grey,
                          bgColor: Colors.white,
                          fontSize: 16,
                          borderRadius: 5,
                          validator: (value) {
                            if (value == '') {
                              return 'This field is required.';
                            }
                          },
                          onSaved: (value) {
                            _data['bulk_order_port'] = value;
                          },
                        ),
                    ],
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 0.1,
                      color: Colors.grey,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Export Carton Details',
                      style: Theme.of(context).primaryTextTheme.headline,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Carton Details',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CommonField(
                      placeholder: 'Quantity per Carton',
                      controller: _controllers[18],
                      focusNode: _focus[18],
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focus[19]);
                      },
                      borderColor: Colors.grey,
                      bgColor: Colors.white,
                      fontSize: 16,
                      borderRadius: 5,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == '') {
                          return 'This field is required.';
                        }
                      },
                      onSaved: (value) {
                        _data['quantity_per_carton'] = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CommonField(
                      placeholder: 'Carton Weight',
                      controller: _controllers[19],
                      focusNode: _focus[19],
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focus[20]);
                      },
                      borderColor: Colors.grey,
                      bgColor: Colors.white,
                      fontSize: 16,
                      borderRadius: 5,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == '') {
                          return 'This field is required.';
                        }
                      },
                      onSaved: (value) {
                        _data['carton_weight'] = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MultilineDropdownButtonFormField(
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            'Grams',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontFamily: Theme.of(context)
                                  .primaryTextTheme
                                  .display1
                                  .fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          value: 'Grams',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Kilograms',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontFamily: Theme.of(context)
                                  .primaryTextTheme
                                  .display1
                                  .fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          value: 'Kilograms',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Metric Tonnes',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontFamily: Theme.of(context)
                                  .primaryTextTheme
                                  .display1
                                  .fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          value: 'Metric Tonnes',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Pounds',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontFamily: Theme.of(context)
                                  .primaryTextTheme
                                  .display1
                                  .fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          value: 'Pounds',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Tons (US)',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontFamily: Theme.of(context)
                                  .primaryTextTheme
                                  .display1
                                  .fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          value: 'Tons (US)',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Tons (UK)',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontFamily: Theme.of(context)
                                  .primaryTextTheme
                                  .display1
                                  .fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          value: 'Tons (UK)',
                        ),
                      ],
                      validator: (value) {
                        if (_data['carton_weight_unit'] == null) {
                          return 'This field is required.';
                        }
                      },
                      onSaved: (value) {
                        _data['carton_weight_unit'] = value;
                      },
                      value: _cartonWeightUnit,
                      iconSize: 30,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(Icons.keyboard_arrow_down),
                      ),
                      iconEnabledColor: Theme.of(context).cardColor,
                      iconDisabledColor: Theme.of(context).cardColor,
                      onChanged: (val) {
                        setState(() {
                          _cartonWeightUnit = val;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0,
                          ),
                        ),
                        alignLabelWithHint: true,
                        hintText: 'Unit',
                        hintStyle: TextStyle(
                          fontSize: 16,
                        ),
                        labelStyle: TextStyle(
                          fontSize: 16,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 30,
                          right: 10,
                        ),
                        errorStyle: TextStyle(color: Colors.red[200]),
                      ),

                      // validator: (value) {
                      //   if (value == null) {
                      //     return 'This field is required.';
                      //   }
                      // },
                      // onSaved: (value) {
                      //   _data['identity_choice'] = value;
                      // },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Carton Dimensions',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CommonField(
                      placeholder: 'Length',
                      borderColor: Colors.grey,
                      controller: _controllers[20],
                      focusNode: _focus[20],
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focus[21]);
                      },
                      bgColor: Colors.white,
                      fontSize: 16,
                      borderRadius: 5,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == '') {
                          return 'This field is required.';
                        }
                      },
                      onSaved: (value) {
                        _data['carton_dimension_length'] = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CommonField(
                      placeholder: 'Width',
                      borderColor: Colors.grey,
                      controller: _controllers[21],
                      focusNode: _focus[21],
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focus[22]);
                      },
                      bgColor: Colors.white,
                      fontSize: 16,
                      borderRadius: 5,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == '') {
                          return 'This field is required.';
                        }
                      },
                      onSaved: (value) {
                        _data['carton_dimension_breadth'] = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CommonField(
                      placeholder: 'Height',
                      borderColor: Colors.grey,
                      controller: _controllers[22],
                      focusNode: _focus[22],
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).unfocus();
                      },
                      bgColor: Colors.white,
                      fontSize: 16,
                      borderRadius: 5,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == '') {
                          return 'This field is required.';
                        }
                      },
                      onSaved: (value) {
                        _data['carton_dimension_height'] = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MultilineDropdownButtonFormField(
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            'Meters',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontFamily: Theme.of(context)
                                  .primaryTextTheme
                                  .display1
                                  .fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          value: 'Meters',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Centimeters',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontFamily: Theme.of(context)
                                  .primaryTextTheme
                                  .display1
                                  .fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          value: 'Centimeters',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Feet',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontFamily: Theme.of(context)
                                  .primaryTextTheme
                                  .display1
                                  .fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          value: 'Feet',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Inches',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontFamily: Theme.of(context)
                                  .primaryTextTheme
                                  .display1
                                  .fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          value: 'Inches',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Yards',
                            style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontFamily: Theme.of(context)
                                  .primaryTextTheme
                                  .display1
                                  .fontFamily,
                              fontSize: 16,
                            ),
                          ),
                          value: 'Yards',
                        ),
                      ],
                      value: _cartonDimensionUnit,
                      iconSize: 30,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(Icons.keyboard_arrow_down),
                      ),
                      iconEnabledColor: Theme.of(context).cardColor,
                      iconDisabledColor: Theme.of(context).cardColor,
                      onChanged: (val) {
                        setState(() {
                          _cartonDimensionUnit = val;
                        });
                      },
                      validator: (value) {
                        if (_data['carton_dimension_unit'] == null) {
                          return 'This field is required.';
                        }
                      },
                      onSaved: (value) {
                        _data['carton_dimension_unit'] = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0,
                          ),
                        ),
                        alignLabelWithHint: true,
                        hintText: 'Unit',
                        hintStyle: TextStyle(
                          fontSize: 16,
                        ),
                        labelStyle: TextStyle(
                          fontSize: 16,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 30,
                          right: 10,
                        ),
                        errorStyle: TextStyle(color: Colors.red[200]),
                      ),

                      // validator: (value) {
                      //   if (value == null) {
                      //     return 'This field is required.';
                      //   }
                      // },
                      // onSaved: (value) {
                      //   _data['identity_choice'] = value;
                      // },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 0.1,
                      color: Colors.grey,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Payment Method',
                      style: Theme.of(context).primaryTextTheme.headline,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: '1',
                          groupValue: _paymentChoice,
                          onChanged: (value) {
                            setState(() {
                              _paymentChoice = value;
                            });
                          },
                        ),
                        Text('Select from the list'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: '2',
                          groupValue: _paymentChoice,
                          onChanged: (value) {
                            setState(() {
                              _paymentChoice = value;
                            });
                          },
                        ),
                        Text('Enter Other Method'),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (_paymentChoice == '1')
                      MultilineDropdownButtonFormField(
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'LC at Site',
                              softWrap: false,
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'LC at Site',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'LC 30 days',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'LC 30 days',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'LC 90 days',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'LC 90 days',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'LC 120 days',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'LC 120 days',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'TT',
                              style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontFamily: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .fontFamily,
                                fontSize: 16,
                              ),
                            ),
                            value: 'TT',
                          ),
                        ],
                        value: _paymentMethod,
                        iconSize: 30,
                        icon: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                        iconEnabledColor: Theme.of(context).cardColor,
                        iconDisabledColor: Theme.of(context).cardColor,
                        onChanged: (val) {
                          setState(() {
                            _paymentMethod = val;
                          });
                        },
                        onSaved: (value) {
                          _data['payment_method'] = value;
                        },
                        validator: (value) {
                          if (_data['payment_method'] == null) {
                            return 'This field is required.';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          hintText: 'Choose Payment Method',
                          hintStyle: TextStyle(
                            fontSize: 16,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 16,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 30,
                            right: 10,
                          ),
                          errorStyle: TextStyle(color: Colors.red[200]),
                        ),

                        // validator: (value) {
                        //   if (value == null) {
                        //     return 'This field is required.';
                        //   }
                        // },
                        // onSaved: (value) {
                        //   _data['identity_choice'] = value;
                        // },
                      )
                    else if (_paymentChoice == '2')
                      CommonField(
                        placeholder: 'Enter Other Method',
                        controller: _controllers[23],
                        focusNode: _focus[23],
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_focus[24]);
                        },
                        borderColor: Colors.grey,
                        bgColor: Colors.white,
                        fontSize: 16,
                        borderRadius: 5,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == '') {
                            return 'This field is required.';
                          }
                        },
                        onSaved: (value) {
                          _data['payment_method'] = value;
                        },
                      ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 0.1,
                      color: Colors.grey,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'HS Delivery Code',
                      style: Theme.of(context).primaryTextTheme.headline,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CommonField(
                      placeholder: 'ABCXXX',
                      borderColor: Colors.grey,
                      controller: _controllers[24],
                      focusNode: _focus[24],
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focus[1]);
                      },
                      bgColor: Colors.white,
                      fontSize: 16,
                      borderRadius: 5,
                      validator: (value) {
                        if (value == '') {
                          return 'This field is required.';
                        }
                      },
                      onSaved: (value) {
                        _data['hs_code'] = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _techTransfer,
                    onChanged: (value) {
                      setState(() {
                        _techTransfer = value;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      'Are you looking for Technology Transfer or Investment for your product?',
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontFamily: Theme.of(context)
                            .primaryTextTheme
                            .display1
                            .fontFamily,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 0.1,
                      color: Colors.grey,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Product Catalogue',
                      style: Theme.of(context).primaryTextTheme.headline,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CommonButton(
                      bgColor: Color(0xFFE9F0F3),
                      borderColor: Color(0xFFE9F0F3),
                      title: 'Upload File',
                      textColor: Theme.of(context).primaryColor,
                      fontSize: 16,
                      width: double.infinity,
                      borderRadius: 5,
                      onPressed: () async {
                        final filePath = await FilePicker.getFilePath(
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                        );
                        if (filePath == null) {
                          return;
                        }
                        final multipartFile = await http.MultipartFile.fromPath(
                          'catalg',
                          filePath,
                        );
                        final length = multipartFile.length;
                        if (length > 5242880) {
                          await showDialog(
                            context: context,
                            child: AlertDialog(
                              title: Text('File is Too Large'),
                              content: Text(
                                  'Maximum File Size is 5MB. Please choose a smaller file.'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                          );
                          return;
                        }
                        setState(() {
                          _media['catalogues'].add(filePath);
                        });
                      },
                    ),
                    if (_media['catalogues'].length != 0) ...[
                      SizedBox(
                        height: 20,
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisSpacing: 5,
                        crossAxisCount: 3,
                        children: [
                          ..._media['catalogues']
                              .map(
                                (cat) => Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: <Widget>[
                                      InkWell(
                                        child: Icon(
                                          Icons.remove_red_eye,
                                          color: Theme.of(context).primaryColor,
                                          size: 40,
                                        ),
                                        onTap: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PDFScreen(cat),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _media['catalogues'].remove(cat);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList()
                        ],
                      ),
                    ]
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CommonButton(
                          bgColor: Color(0xFFE9F0F3),
                          borderColor: Color(0xFFE9F0F3),
                          title: 'BACK',
                          textColor: Theme.of(context).accentColor,
                          fontSize: 16,
                          // width: double.infinity,
                          borderRadius: 5,
                          width: 150,
                          onPressed: () {
                            setState(() {
                              _currentPart--;
                            });
                          },
                        ),
                        CommonButton(
                          bgColor: Theme.of(context).primaryColor,
                          borderColor: Theme.of(context).primaryColor,
                          title: 'DONE',
                          textColor: Colors.white,
                          fontSize: 16,
                          // width: double.infinity,
                          borderRadius: 5,
                          width: 150,
                          onPressed: () {
                            _submitPart4();
                          },
                        ),
                      ],
                    ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Add Product',
          style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          if (_currentPart == 1) pU1View(),
          if (_currentPart == 2) pU2View(),
          if (_currentPart == 3) pU3View(),
          if (_currentPart == 4) pU4View(),
          Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(minHeight: 60),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                color: Colors.white,
                alignment: Alignment.center,
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${widget.deptName}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline
                            .copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_right),
                    Expanded(
                      child: Text(
                        '${widget.catName}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline
                            .copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_right),
                    Expanded(
                      child: Text(
                        '${widget.subcatName}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline
                            .copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    height: 5,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                  Container(
                    height: 5,
                    width: MediaQuery.of(context).size.width *
                        (_currentPart == 1
                            ? 0.25
                            : _currentPart == 2
                                ? 0.5
                                : _currentPart == 3 ? 0.75 : 1),
                    color: Theme.of(context).accentColor,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
