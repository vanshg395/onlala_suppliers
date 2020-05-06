import 'package:flutter/material.dart';

import '../widgets/address_card.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title: Text(
          'Address',
          style: Theme.of(context).primaryTextTheme.subtitle.copyWith(
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              AddressCard(
                title: 'India Office',
                address:
                    'Corevyan Private Limited\n#108, First Floor, JMD Pacifio Square\nSector15 part-l, Opposite Galaxy Hotel,\mGurugram-122018 (HR),.\nIndia,+91-124-4981457, +9-9999948492\nCIN U74999HR2017PTC071753',
              ),
              AddressCard(
                title: 'Nigeria Office',
                address:
                    'Corevyan Private Limited\n#108, First Floor, JMD Pacifio Square\nSector15 part-l, Opposite Galaxy Hotel,\mGurugram-122018 (HR),.\nIndia,+91-124-4981457, +9-9999948492\nCIN U74999HR2017PTC071753',
              ),
              AddressCard(
                title: 'South Africa Office',
                address:
                    'Corevyan Private Limited\n#108, First Floor, JMD Pacifio Square\nSector15 part-l, Opposite Galaxy Hotel,\mGurugram-122018 (HR),.\nIndia,+91-124-4981457, +9-9999948492\nCIN U74999HR2017PTC071753',
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
}
