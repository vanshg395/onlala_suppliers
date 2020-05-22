import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import '../widgets/common_button.dart';
import '../widgets/profile_field.dart';
import '../providers/auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  bool _isWarehouseAddressSame = false;
  bool _isLoading = false;
  bool _isLoading2 = false;
  bool _isLoading3 = false;
  List<bool> _isLoadings = [
    false,
    false,
    false,
    false,
  ];
  Map<String, String> _data = {};

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<Auth>(context, listen: false).getManufData();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> uploadDoc(int i, String fileType) async {
    setState(() {
      _isLoadings[i] = true;
    });
    try {
      final filePath = await FilePicker.getFilePath(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
      );
      if (filePath == null) {
        setState(() {
          _isLoadings[i] = false;
        });
        return;
      }
      final url = baseUrl + 'business/manufacturer/document/upload/';
      final multipartRequest =
          new http.MultipartRequest('POST', Uri.parse(url));
      multipartRequest.headers.addAll(
        {
          'Authorization': Provider.of<Auth>(context, listen: false).token,
        },
      );
      multipartRequest.fields.addAll({
        'file_type': fileType,
        'manufacturer': Provider.of<Auth>(context, listen: false).userDetails[0]
            ['id'],
      });
      final multipartFile = await http.MultipartFile.fromPath(
        'document',
        filePath,
      );
      final length = multipartFile.length;
      if (length > 5242880) {
        await showDialog(
          context: context,
          child: AlertDialog(
            title: Text('File is Too Large'),
            content:
                Text('Maximum File Size is 5MB. Please choose a smaller file.'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        setState(() {
          _isLoadings[i] = false;
        });
        return;
      }
      multipartRequest.files.add(multipartFile);
      final response = await multipartRequest.send();
      print(response.statusCode);
      if (response.statusCode == 201) {
        getData();
      }
    } catch (e) {
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
    setState(() {
      _isLoadings[i] = true;
    });
  }

  Future<void> _uploadImage() async {
    try {
      setState(() {
        _isLoading2 = true;
      });
      try {
        final filePathTemp = await FilePicker.getFilePath(
          type: FileType.image,
          // allowedExtensions: ['jpg', 'png', 'jpeg'],
        );
        if (filePathTemp == null) {
          setState(() {
            _isLoading2 = false;
          });
          return;
        }
        File croppedFile = await ImageCropper.cropImage(
          sourcePath: filePathTemp,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).primaryColor,
            activeControlsWidgetColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
            showCancelConfirmationDialog: true,
          ),
        );
        final filePath = croppedFile.path;
        final url = baseUrl + 'user/profile/change/manufacturer/';
        final multipartRequest =
            new http.MultipartRequest('POST', Uri.parse(url));
        multipartRequest.headers.addAll(
          {
            'Authorization': Provider.of<Auth>(context, listen: false).token,
          },
        );
        final multipartFile = await http.MultipartFile.fromPath(
          'picture',
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
          setState(() {
            _isLoading2 = false;
          });
          return;
        }
        multipartRequest.files.add(multipartFile);
        final response = await multipartRequest.send();
        print(response.statusCode);
        if (response.statusCode == 202) {
          getData();
        }
      } catch (e) {}
      setState(() {
        _isLoading2 = false;
      });
    } catch (e) {
      print(e);
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
  }

  Future<void> _submit() async {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      return;
    }
    setState(() {
      _isLoading3 = true;
    });
    try {
      final url = baseUrl + 'user/profile/change/manufacturer/';
      final multipartRequest =
          new http.MultipartRequest('POST', Uri.parse(url));
      multipartRequest.headers.addAll(
        {
          'Authorization': Provider.of<Auth>(context, listen: false).token,
        },
      );
      print('<<<<<<<<<object>>>>>>>>>');
      multipartRequest.fields.addAll(_data);
      print('<<<<<<<<<object>>>>>>>>>>>>>>.');
      final response = await multipartRequest.send();
      print('<<<<<<<<<object>>>>>>>>>>>>>>.');
      print(response.statusCode);
      if (response.statusCode == 202) {
        await showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Success'),
            content: Text('Profile has been updated.'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
        getData();
      }
    } catch (e) {
      print(e);
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
    setState(() {
      _isLoading3 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Edit Profile',
          style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Theme.of(context).primaryColor,
                ),
              ),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              color: Theme.of(context).canvasColor,
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: double.infinity,
                            color: Colors.white,
                            // child: Image.asset(
                            //   'assets/img/homedevice.png',
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      spreadRadius: 0.1,
                                      color: Colors.grey,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: double.infinity,
                              ),
                              Positioned(
                                bottom:
                                    (MediaQuery.of(context).size.height * 0.2 -
                                                75) /
                                            2 -
                                        20,
                                left:
                                    MediaQuery.of(context).size.width / 2 - 100,
                                child: _isLoading2
                                    ? Container(
                                        width: 200,
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                            Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      )
                                    : CommonButton(
                                        bgColor: Color(0xFFDFE9ED),
                                        borderColor: Color(0xFFDFE9ED),
                                        title: 'CHANGE IMAGE',
                                        textColor:
                                            Theme.of(context).primaryColor,
                                        fontSize: 16,
                                        borderRadius: 5,
                                        width: 200,
                                        height: 40,
                                        onPressed: _uploadImage,
                                      ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Personal Information',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 30,
                            ),
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
                              children: <Widget>[
                                ProfileField(
                                  label: 'First Name',
                                  initialData:
                                      Provider.of<Auth>(context, listen: false)
                                                  .userDetails[0]['user']
                                              ['first_name'] ??
                                          '',
                                  validator: (value) {
                                    if (value == '') {
                                      return 'This field. is required.';
                                    }
                                  },
                                  onSaved: (value) {
                                    _data['first_name'] = value;
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ProfileField(
                                  label: 'Last Name',
                                  initialData:
                                      Provider.of<Auth>(context, listen: false)
                                                  .userDetails[0]['user']
                                              ['last_name'] ??
                                          '',
                                  validator: (value) {
                                    if (value == '') {
                                      return 'This field. is required.';
                                    }
                                  },
                                  onSaved: (value) {
                                    _data['last_name'] = value;
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ProfileField(
                                  label: 'Email',
                                  enabled: false,
                                  initialData:
                                      Provider.of<Auth>(context, listen: false)
                                                  .userDetails[0]['user']
                                              ['email'] ??
                                          '',
                                  validator: (value) {
                                    if (value == '') {
                                      return 'This field. is required.';
                                    }
                                    if (!RegExp(
                                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email.';
                                    }
                                  },
                                  onSaved: (value) {
                                    _data['user_new_email'] = value;
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ProfileField(
                                  label: 'Company',
                                  initialData:
                                      Provider.of<Auth>(context, listen: false)
                                              .userDetails[0]['company'] ??
                                          '',
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ProfileField(
                                  label: 'Phone Number',
                                  initialData:
                                      Provider.of<Auth>(context, listen: false)
                                              .userDetails[0]['mobile'] ??
                                          '',
                                  validator: (value) {
                                    if (value == '') {
                                      return 'This field. is required.';
                                    }
                                  },
                                  onSaved: (value) {
                                    _data['mobile'] = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Postal Address',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 30,
                            ),
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
                              children: <Widget>[
                                // ProfileField(
                                //   label: 'Landmark',
                                // ),
                                // SizedBox(
                                //   height: 15,
                                // ),
                                ProfileField(
                                  label: 'Country',
                                  initialData: Provider.of<Auth>(context,
                                                  listen: false)
                                              .userDetails[0]['postal_details']
                                              .length !=
                                          0
                                      ? Provider.of<Auth>(context,
                                                  listen: false)
                                              .userDetails[0]['postal_details']
                                          [0]['postal_country']
                                      : '',
                                  validator: (value) {
                                    if (value == '') {
                                      return 'This field. is required.';
                                    }
                                  },
                                  onSaved: (value) {
                                    _data['postal_country'] = value;
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ProfileField(
                                  label: 'State',
                                  initialData: Provider.of<Auth>(context,
                                                  listen: false)
                                              .userDetails[0]['postal_details']
                                              .length !=
                                          0
                                      ? Provider.of<Auth>(context,
                                                  listen: false)
                                              .userDetails[0]['postal_details']
                                          [0]['postal_state']
                                      : '',
                                  validator: (value) {
                                    if (value == '') {
                                      return 'This field. is required.';
                                    }
                                  },
                                  onSaved: (value) {
                                    print(value);
                                    _data['postal_state'] = value;
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ProfileField(
                                  label: 'City',
                                  initialData: Provider.of<Auth>(context,
                                                  listen: false)
                                              .userDetails[0]['postal_details']
                                              .length !=
                                          0
                                      ? Provider.of<Auth>(context,
                                                  listen: false)
                                              .userDetails[0]['postal_details']
                                          [0]['postal_city']
                                      : '',
                                  validator: (value) {
                                    if (value == '') {
                                      return 'This field. is required.';
                                    }
                                  },
                                  onSaved: (value) {
                                    _data['postal_city'] = value;
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ProfileField(
                                  label: 'Postal Address',
                                  initialData: Provider.of<Auth>(context,
                                                  listen: false)
                                              .userDetails[0]['postal_details']
                                              .length !=
                                          0
                                      ? Provider.of<Auth>(context,
                                                  listen: false)
                                              .userDetails[0]['postal_details']
                                          [0]['postal_address1']
                                      : '',
                                  validator: (value) {
                                    if (value == '') {
                                      return 'This field. is required.';
                                    }
                                  },
                                  onSaved: (value) {
                                    _data['postal_address1'] = value;
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ProfileField(
                                  label: 'Postal Code',
                                  initialData: Provider.of<Auth>(context,
                                                  listen: false)
                                              .userDetails[0]['postal_details']
                                              .length !=
                                          0
                                      ? Provider.of<Auth>(context,
                                                  listen: false)
                                              .userDetails[0]['postal_details']
                                          [0]['postal_code']
                                      : '',
                                  validator: (value) {
                                    if (value == '') {
                                      return 'This field. is required.';
                                    }
                                  },
                                  onSaved: (value) {
                                    _data['postal_code'] = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Warehouse Address',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 30,
                            ),
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
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      value: _isWarehouseAddressSame,
                                      onChanged: (value) {
                                        setState(() {
                                          _isWarehouseAddressSame = value;
                                        });
                                        if (_isWarehouseAddressSame) {
                                          _data['warehouse_country'] =
                                              _data['postal_country'];
                                          _data['warehouse_state'] =
                                              _data['postal_state'];
                                          _data['warehouse_city'] =
                                              _data['postal_city'];
                                          _data['warehouse_address1'] =
                                              _data['postal_address1'];
                                          _data['warehouse_code'] =
                                              _data['postal_code'];
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Same as Postal Address',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline,
                                    ),
                                  ],
                                ),
                                if (!_isWarehouseAddressSame) ...[
                                  // ProfileField(
                                  //   label: 'Landmark',
                                  // ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  ProfileField(
                                    label: 'Country',
                                    initialData: Provider.of<Auth>(context,
                                                    listen: false)
                                                .userDetails[0]
                                                    ['warehouse_details']
                                                .length !=
                                            0
                                        ? Provider.of<Auth>(context,
                                                        listen: false)
                                                    .userDetails[0]
                                                ['warehouse_details'][0]
                                            ['warehouse_country']
                                        : '',
                                    validator: (value) {
                                      if (value == '') {
                                        return 'This field. is required.';
                                      }
                                    },
                                    onSaved: (value) {
                                      _data['warehouse_country'] = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ProfileField(
                                    label: 'State',
                                    initialData: Provider.of<Auth>(context,
                                                    listen: false)
                                                .userDetails[0]
                                                    ['warehouse_details']
                                                .length !=
                                            0
                                        ? Provider.of<Auth>(context,
                                                        listen: false)
                                                    .userDetails[0]
                                                ['warehouse_details'][0]
                                            ['warehouse_state']
                                        : '',
                                    validator: (value) {
                                      if (value == '') {
                                        return 'This field. is required.';
                                      }
                                    },
                                    onSaved: (value) {
                                      _data['warehouse_state'] = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ProfileField(
                                    label: 'City',
                                    initialData: Provider.of<Auth>(context,
                                                    listen: false)
                                                .userDetails[0]
                                                    ['warehouse_details']
                                                .length !=
                                            0
                                        ? Provider.of<Auth>(context,
                                                        listen: false)
                                                    .userDetails[0]
                                                ['warehouse_details'][0]
                                            ['warehouse_city']
                                        : '',
                                    validator: (value) {
                                      if (value == '') {
                                        return 'This field. is required.';
                                      }
                                    },
                                    onSaved: (value) {
                                      _data['warehouse_city'] = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ProfileField(
                                    label: 'Postal Address',
                                    initialData: Provider.of<Auth>(context,
                                                    listen: false)
                                                .userDetails[0]
                                                    ['warehouse_details']
                                                .length !=
                                            0
                                        ? Provider.of<Auth>(context,
                                                        listen: false)
                                                    .userDetails[0]
                                                ['warehouse_details'][0]
                                            ['warehouse_address1']
                                        : '',
                                    validator: (value) {
                                      if (value == '') {
                                        return 'This field. is required.';
                                      }
                                    },
                                    onSaved: (value) {
                                      _data['warehouse_address1'] = value;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ProfileField(
                                    label: 'Postal Code',
                                    initialData: Provider.of<Auth>(context,
                                                    listen: false)
                                                .userDetails[0]
                                                    ['warehouse_details']
                                                .length !=
                                            0
                                        ? Provider.of<Auth>(context,
                                                        listen: false)
                                                    .userDetails[0]
                                                ['warehouse_details'][0]
                                            ['warehouse_code']
                                        : '',
                                    validator: (value) {
                                      if (value == '') {
                                        return 'This field. is required.';
                                      }
                                    },
                                    onSaved: (value) {
                                      _data['warehouse_code'] = value;
                                    },
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Documents',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 30,
                            ),
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
                                  'IEC Certificate',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (Provider.of<Auth>(context, listen: false)
                                        .docs
                                        .where((doc) =>
                                            doc['file_type'] ==
                                            'IEC_Certificate')
                                        .toList()
                                        .length ==
                                    0)
                                  _isLoadings[0]
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                              Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        )
                                      : CommonButton(
                                          bgColor: Color(0xFFE9F0F3),
                                          borderColor: Color(0xFFE9F0F3),
                                          title: 'Upload File',
                                          textColor:
                                              Theme.of(context).primaryColor,
                                          fontSize: 16,
                                          width: double.infinity,
                                          borderRadius: 5,
                                          onPressed: () =>
                                              uploadDoc(0, 'IEC_Certificate'),
                                        )
                                else
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        Provider.of<Auth>(context,
                                                    listen: false)
                                                .docs
                                                .where((doc) =>
                                                    doc['file_type'] ==
                                                    'IEC_Certificate')
                                                .toList()[0]['review']
                                            ? 'Document Approved'
                                            : 'Approval Pending',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle
                                            .copyWith(
                                              color: Provider.of<Auth>(context,
                                                          listen: false)
                                                      .docs
                                                      .where((doc) =>
                                                          doc['file_type'] ==
                                                          'IEC_Certificate')
                                                      .toList()[0]['review']
                                                  ? Colors.green
                                                  : Colors.amber,
                                            ),
                                      ),
                                      InkWell(
                                        child: Icon(
                                          Icons.cloud_download,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onTap: () async {
                                          if (await canLaunch(Provider.of<Auth>(
                                                  context,
                                                  listen: false)
                                              .docs
                                              .where((doc) =>
                                                  doc['file_type'] ==
                                                  'IEC_Certificate')
                                              .toList()[0]['document'])) {
                                            await launch(Provider.of<Auth>(
                                                    context,
                                                    listen: false)
                                                .docs
                                                .where((doc) =>
                                                    doc['file_type'] ==
                                                    'IEC_Certificate')
                                                .toList()[0]['document']);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Company Registration Certificate',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (Provider.of<Auth>(context, listen: false)
                                        .docs
                                        .where((doc) =>
                                            doc['file_type'] ==
                                            'Company Registration Certificate')
                                        .toList()
                                        .length ==
                                    0)
                                  _isLoadings[1]
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                              Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        )
                                      : CommonButton(
                                          bgColor: Color(0xFFE9F0F3),
                                          borderColor: Color(0xFFE9F0F3),
                                          title: 'Upload File',
                                          textColor:
                                              Theme.of(context).primaryColor,
                                          fontSize: 16,
                                          width: double.infinity,
                                          borderRadius: 5,
                                          onPressed: () => uploadDoc(1,
                                              'Company Registration Certificate'),
                                        )
                                else
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        Provider.of<Auth>(context,
                                                    listen: false)
                                                .docs
                                                .where((doc) =>
                                                    doc['file_type'] ==
                                                    'Company Registration Certificate')
                                                .toList()[0]['review']
                                            ? 'Document Approved'
                                            : 'Approval Pending',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle
                                            .copyWith(
                                              color: Provider.of<Auth>(context,
                                                          listen: false)
                                                      .docs
                                                      .where((doc) =>
                                                          doc['file_type'] ==
                                                          'Company Registration Certificate')
                                                      .toList()[0]['review']
                                                  ? Colors.green
                                                  : Colors.amber,
                                            ),
                                      ),
                                      InkWell(
                                        child: Icon(
                                          Icons.cloud_download,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onTap: () async {
                                          if (await canLaunch(Provider.of<Auth>(
                                                  context,
                                                  listen: false)
                                              .docs
                                              .where((doc) =>
                                                  doc['file_type'] ==
                                                  'Company Registration Certificate')
                                              .toList()[0]['document'])) {
                                            await launch(Provider.of<Auth>(
                                                    context,
                                                    listen: false)
                                                .docs
                                                .where((doc) =>
                                                    doc['file_type'] ==
                                                    'Company Registration Certificate')
                                                .toList()[0]['document']);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'GST Certificate',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (Provider.of<Auth>(context, listen: false)
                                        .docs
                                        .where((doc) =>
                                            doc['file_type'] ==
                                            'GST Certificate')
                                        .toList()
                                        .length ==
                                    0)
                                  _isLoadings[2]
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                              Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        )
                                      : CommonButton(
                                          bgColor: Color(0xFFE9F0F3),
                                          borderColor: Color(0xFFE9F0F3),
                                          title: 'Upload File',
                                          textColor:
                                              Theme.of(context).primaryColor,
                                          fontSize: 16,
                                          width: double.infinity,
                                          borderRadius: 5,
                                          onPressed: () =>
                                              uploadDoc(2, 'GST Certificate'),
                                        )
                                else
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        Provider.of<Auth>(context,
                                                    listen: false)
                                                .docs
                                                .where((doc) =>
                                                    doc['file_type'] ==
                                                    'GST Certificate')
                                                .toList()[0]['review']
                                            ? 'Document Approved'
                                            : 'Approval Pending',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle
                                            .copyWith(
                                              color: Provider.of<Auth>(context,
                                                          listen: false)
                                                      .docs
                                                      .where((doc) =>
                                                          doc['file_type'] ==
                                                          'GST Certificate')
                                                      .toList()[0]['review']
                                                  ? Colors.green
                                                  : Colors.amber,
                                            ),
                                      ),
                                      InkWell(
                                        child: Icon(
                                          Icons.cloud_download,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onTap: () async {
                                          if (await canLaunch(Provider.of<Auth>(
                                                  context,
                                                  listen: false)
                                              .docs
                                              .where((doc) =>
                                                  doc['file_type'] ==
                                                  'GST Certificate')
                                              .toList()[0]['document'])) {
                                            await launch(Provider.of<Auth>(
                                                    context,
                                                    listen: false)
                                                .docs
                                                .where((doc) =>
                                                    doc['file_type'] ==
                                                    'GST Certificate')
                                                .toList()[0]['document']);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Shop & Establishment Licence',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (Provider.of<Auth>(context, listen: false)
                                        .docs
                                        .where((doc) =>
                                            doc['file_type'] ==
                                            'Shop And Establishment Certificate')
                                        .toList()
                                        .length ==
                                    0)
                                  _isLoadings[3]
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                              Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        )
                                      : CommonButton(
                                          bgColor: Color(0xFFE9F0F3),
                                          borderColor: Color(0xFFE9F0F3),
                                          title: 'Upload File',
                                          textColor:
                                              Theme.of(context).primaryColor,
                                          fontSize: 16,
                                          width: double.infinity,
                                          borderRadius: 5,
                                          onPressed: () => uploadDoc(3,
                                              'Shop And Establishment Certificate'),
                                        )
                                else
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        Provider.of<Auth>(context,
                                                    listen: false)
                                                .docs
                                                .where((doc) =>
                                                    doc['file_type'] ==
                                                    'Shop And Establishment Certificate')
                                                .toList()[0]['review']
                                            ? 'Document Approved'
                                            : 'Approval Pending',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle
                                            .copyWith(
                                              color: Provider.of<Auth>(context,
                                                          listen: false)
                                                      .docs
                                                      .where((doc) =>
                                                          doc['file_type'] ==
                                                          'Shop And Establishment Certificate')
                                                      .toList()[0]['review']
                                                  ? Colors.green
                                                  : Colors.amber,
                                            ),
                                      ),
                                      InkWell(
                                        child: Icon(
                                          Icons.cloud_download,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onTap: () async {
                                          if (await canLaunch(Provider.of<Auth>(
                                                  context,
                                                  listen: false)
                                              .docs
                                              .where((doc) =>
                                                  doc['file_type'] ==
                                                  'Shop And Establishment Certificate')
                                              .toList()[0]['document'])) {
                                            await launch(Provider.of<Auth>(
                                                    context,
                                                    listen: false)
                                                .docs
                                                .where((doc) =>
                                                    doc['file_type'] ==
                                                    'Shop And Establishment Certificate')
                                                .toList()[0]['document']);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: _isLoading3
                                ? Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                        Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  )
                                : CommonButton(
                                    bgColor: Theme.of(context).primaryColor,
                                    borderColor: Theme.of(context).primaryColor,
                                    title: 'UPDATE INFORMATION',
                                    fontSize: 16,
                                    width: double.infinity,
                                    borderRadius: 5,
                                    onPressed: _submit,
                                  ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: MediaQuery.of(context).size.width / 2 - 75,
                      top: MediaQuery.of(context).size.height * 0.25 - 75,
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFE1F0F7),
                          border: Border.all(
                              color: Theme.of(context).canvasColor, width: 3),
                          image: Provider.of<Auth>(context, listen: false)
                                          .userDetails[0]['image_url'][0]
                                      ['profile_image'] ==
                                  null
                              ? null
                              : DecorationImage(
                                  image: NetworkImage(
                                    Provider.of<Auth>(context, listen: false)
                                            .userDetails[0]['image_url'][0]
                                        ['profile_image'],
                                  ),
                                  fit: BoxFit.cover,
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
}
