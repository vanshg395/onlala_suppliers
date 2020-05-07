import 'package:flutter/material.dart';

import '../widgets/common_button.dart';
import '../widgets/profile_field.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isWarehouseAddressSame = false;

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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).canvasColor,
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: double.infinity,
                    color: Colors.teal,
                    child: Image.asset(
                      'assets/img/homedevice.png',
                      fit: BoxFit.cover,
                    ),
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
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: double.infinity,
                      ),
                      Positioned(
                        bottom:
                            (MediaQuery.of(context).size.height * 0.2 - 75) /
                                    2 -
                                20,
                        left: MediaQuery.of(context).size.width / 2 - 100,
                        child: CommonButton(
                          bgColor: Color(0xFFDFE9ED),
                          borderColor: Color(0xFFDFE9ED),
                          title: 'CHANGE IMAGE',
                          textColor: Theme.of(context).primaryColor,
                          fontSize: 16,
                          borderRadius: 5,
                          width: 200,
                          onPressed: () {},
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
                          label: 'Full Name',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ProfileField(
                          label: 'Email',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ProfileField(
                          label: 'Company',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ProfileField(
                          label: 'Phone Number',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ProfileField(
                          label: 'Current Address',
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
                        ProfileField(
                          label: 'Landmark',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ProfileField(
                          label: 'Country',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ProfileField(
                          label: 'State',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ProfileField(
                          label: 'City',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ProfileField(
                          label: 'Postal Address',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ProfileField(
                          label: 'Postal Address 2',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ProfileField(
                          label: 'Postal Address 3',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ProfileField(
                          label: 'Postal Code',
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
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Same as Postal Address',
                              style:
                                  Theme.of(context).primaryTextTheme.headline,
                            ),
                          ],
                        ),
                        if (!_isWarehouseAddressSame) ...[
                          SizedBox(
                            height: 15,
                          ),
                          ProfileField(
                            label: 'Landmark',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ProfileField(
                            label: 'Country',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ProfileField(
                            label: 'State',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ProfileField(
                            label: 'City',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ProfileField(
                            label: 'Postal Address',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ProfileField(
                            label: 'Postal Address 2',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ProfileField(
                            label: 'Postal Address 3',
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          ProfileField(
                            label: 'Postal Code',
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
                      children: <Widget>[],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CommonButton(
                      bgColor: Theme.of(context).primaryColor,
                      borderColor: Theme.of(context).primaryColor,
                      title: 'UPDATE INFORMATION',
                      fontSize: 16,
                      width: double.infinity,
                      borderRadius: 5,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
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
                    border: Border.all(color: Colors.white, width: 5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // body: CustomScrollView(
      //   slivers: <Widget>[
      //     SliverAppBar(
      //       leading: IconButton(
      //         icon: Icon(
      //           Icons.chevron_left,
      //           size: 30,
      //         ),
      //         onPressed: () => Navigator.of(context).pop(),
      //       ),
      //       // backgroundColor: Colors.transparent,
      //       // elevation: 0,
      //       expandedHeight: MediaQuery.of(context).size.height * 0.25,
      //       pinned: true,
      //       flexibleSpace: FlexibleSpaceBar(
      //         title: Text(
      //           'Edit Profile',
      //           style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
      //                 color: Colors.white,
      //                 letterSpacing: 2,
      //                 fontWeight: FontWeight.w500,
      //               ),
      //         ),
      //         background: Container(
      //           height: MediaQuery.of(context).size.height * 0.25,
      //           width: double.infinity,
      //           // color: Colors.teal,
      //           child: Image.asset(
      //             'assets/img/homedevice.png',
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       ),
      //     ),
      //     SliverList(
      //       delegate: SliverChildListDelegate([
      //         Stack(
      //           children: <Widget>[
      //             Container(
      //               margin: EdgeInsets.symmetric(horizontal: 20),
      //               decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 borderRadius: BorderRadius.only(
      //                   bottomLeft: Radius.circular(10),
      //                   bottomRight: Radius.circular(10),
      //                 ),
      //                 boxShadow: [
      //                   BoxShadow(
      //                     blurRadius: 2,
      //                     spreadRadius: 0.1,
      //                     color: Colors.grey,
      //                     offset: Offset(0, 1),
      //                   ),
      //                 ],
      //               ),
      //               height: MediaQuery.of(context).size.height * 0.2,
      //               width: double.infinity,
      //             ),
      //             Positioned(
      //               bottom:
      //                   (MediaQuery.of(context).size.height * 0.2 - 75) / 2 -
      //                       20,
      //               left: MediaQuery.of(context).size.width / 2 - 100,
      //               child: CommonButton(
      //                 bgColor: Color(0xFFDFE9ED),
      //                 borderColor: Color(0xFFDFE9ED),
      //                 title: 'CHANGE IMAGE',
      //                 textColor: Theme.of(context).primaryColor,
      //                 fontSize: 16,
      //                 borderRadius: 5,
      //                 width: 200,
      //                 onPressed: () {},
      //               ),
      //             ),
      //           ],
      //         ),
      //         SizedBox(
      //           height: 40,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 20.0),
      //           child: Text(
      //             'Personal Information',
      //             style: TextStyle(
      //               color: Colors.grey,
      //               fontSize: 20,
      //               fontWeight: FontWeight.w700,
      //               letterSpacing: 1,
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Container(
      //           margin: EdgeInsets.symmetric(horizontal: 20),
      //           padding: EdgeInsets.symmetric(
      //             horizontal: 20,
      //             vertical: 30,
      //           ),
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(10),
      //             boxShadow: [
      //               BoxShadow(
      //                 blurRadius: 2,
      //                 spreadRadius: 0.1,
      //                 color: Colors.grey,
      //                 offset: Offset(0, 1),
      //               ),
      //             ],
      //           ),
      //           width: double.infinity,
      //           child: Column(
      //             children: <Widget>[
      //               ProfileField(
      //                 label: 'Full Name',
      //               ),
      //               SizedBox(
      //                 height: 15,
      //               ),
      //               ProfileField(
      //                 label: 'Email',
      //               ),
      //               SizedBox(
      //                 height: 15,
      //               ),
      //               ProfileField(
      //                 label: 'Company',
      //               ),
      //               SizedBox(
      //                 height: 15,
      //               ),
      //               ProfileField(
      //                 label: 'Phone Number',
      //               ),
      //               SizedBox(
      //                 height: 15,
      //               ),
      //               ProfileField(
      //                 label: 'Current Address',
      //               ),
      //             ],
      //           ),
      //         ),
      //         SizedBox(
      //           height: 40,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 20.0),
      //           child: Text(
      //             'Postal Address',
      //             style: TextStyle(
      //               color: Colors.grey,
      //               fontSize: 20,
      //               fontWeight: FontWeight.w700,
      //               letterSpacing: 1,
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Container(
      //           margin: EdgeInsets.symmetric(horizontal: 20),
      //           padding: EdgeInsets.symmetric(
      //             horizontal: 20,
      //             vertical: 30,
      //           ),
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(10),
      //             boxShadow: [
      //               BoxShadow(
      //                 blurRadius: 2,
      //                 spreadRadius: 0.1,
      //                 color: Colors.grey,
      //                 offset: Offset(0, 1),
      //               ),
      //             ],
      //           ),
      //           width: double.infinity,
      //           child: Column(
      //             children: <Widget>[
      //               ProfileField(
      //                 label: 'Landmark',
      //               ),
      //               SizedBox(
      //                 height: 15,
      //               ),
      //               ProfileField(
      //                 label: 'Country',
      //               ),
      //               SizedBox(
      //                 height: 15,
      //               ),
      //               ProfileField(
      //                 label: 'State',
      //               ),
      //               SizedBox(
      //                 height: 15,
      //               ),
      //               ProfileField(
      //                 label: 'City',
      //               ),
      //               SizedBox(
      //                 height: 15,
      //               ),
      //               ProfileField(
      //                 label: 'Postal Address',
      //               ),
      //               SizedBox(
      //                 height: 15,
      //               ),
      //               ProfileField(
      //                 label: 'Postal Address 2',
      //               ),
      //               SizedBox(
      //                 height: 15,
      //               ),
      //               ProfileField(
      //                 label: 'Postal Address 3',
      //               ),
      //               SizedBox(
      //                 height: 15,
      //               ),
      //               ProfileField(
      //                 label: 'Postal Code',
      //               ),
      //             ],
      //           ),
      //         ),
      //         SizedBox(
      //           height: 40,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 20.0),
      //           child: Text(
      //             'Warehouse Address',
      //             style: TextStyle(
      //               color: Colors.grey,
      //               fontSize: 20,
      //               fontWeight: FontWeight.w700,
      //               letterSpacing: 1,
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Container(
      //           margin: EdgeInsets.symmetric(horizontal: 20),
      //           padding: EdgeInsets.symmetric(
      //             horizontal: 20,
      //             vertical: 30,
      //           ),
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(10),
      //             boxShadow: [
      //               BoxShadow(
      //                 blurRadius: 2,
      //                 spreadRadius: 0.1,
      //                 color: Colors.grey,
      //                 offset: Offset(0, 1),
      //               ),
      //             ],
      //           ),
      //           width: double.infinity,
      //           child: Column(
      //             children: <Widget>[
      //               Row(
      //                 children: <Widget>[
      //                   Checkbox(
      //                     materialTapTargetSize:
      //                         MaterialTapTargetSize.shrinkWrap,
      //                     value: _isWarehouseAddressSame,
      //                     onChanged: (value) {
      //                       setState(() {
      //                         _isWarehouseAddressSame = value;
      //                       });
      //                     },
      //                   ),
      //                   SizedBox(
      //                     width: 10,
      //                   ),
      //                   Text(
      //                     'Same as Postal Address',
      //                     style: Theme.of(context).primaryTextTheme.headline,
      //                   ),
      //                 ],
      //               ),
      //               if (!_isWarehouseAddressSame) ...[
      //                 SizedBox(
      //                   height: 15,
      //                 ),
      //                 ProfileField(
      //                   label: 'Landmark',
      //                 ),
      //                 SizedBox(
      //                   height: 15,
      //                 ),
      //                 ProfileField(
      //                   label: 'Country',
      //                 ),
      //                 SizedBox(
      //                   height: 15,
      //                 ),
      //                 ProfileField(
      //                   label: 'State',
      //                 ),
      //                 SizedBox(
      //                   height: 15,
      //                 ),
      //                 ProfileField(
      //                   label: 'City',
      //                 ),
      //                 SizedBox(
      //                   height: 15,
      //                 ),
      //                 ProfileField(
      //                   label: 'Postal Address',
      //                 ),
      //                 SizedBox(
      //                   height: 15,
      //                 ),
      //                 ProfileField(
      //                   label: 'Postal Address 2',
      //                 ),
      //                 SizedBox(
      //                   height: 15,
      //                 ),
      //                 ProfileField(
      //                   label: 'Postal Address 3',
      //                 ),
      //                 SizedBox(
      //                   height: 15,
      //                 ),
      //                 ProfileField(
      //                   label: 'Postal Code',
      //                 ),
      //               ],
      //             ],
      //           ),
      //         ),
      //         SizedBox(
      //           height: 40,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 20.0),
      //           child: Text(
      //             'Documents',
      //             style: TextStyle(
      //               color: Colors.grey,
      //               fontSize: 20,
      //               fontWeight: FontWeight.w700,
      //               letterSpacing: 1,
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Container(
      //           margin: EdgeInsets.symmetric(horizontal: 20),
      //           padding: EdgeInsets.symmetric(
      //             horizontal: 20,
      //             vertical: 30,
      //           ),
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(10),
      //             boxShadow: [
      //               BoxShadow(
      //                 blurRadius: 2,
      //                 spreadRadius: 0.1,
      //                 color: Colors.grey,
      //                 offset: Offset(0, 1),
      //               ),
      //             ],
      //           ),
      //           width: double.infinity,
      //           child: Column(
      //             children: <Widget>[],
      //           ),
      //         ),
      //         SizedBox(
      //           height: 50,
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
      //           child: CommonButton(
      //             bgColor: Theme.of(context).primaryColor,
      //             borderColor: Theme.of(context).primaryColor,
      //             title: 'UPDATE INFORMATION',
      //             fontSize: 16,
      //             width: double.infinity,
      //             borderRadius: 5,
      //             onPressed: () {},
      //           ),
      //         ),
      //         SizedBox(
      //           height: 30,
      //         ),
      //       ]),
      //     )
      //   ],
      // ),
    );
  }
}
