import 'package:flutter/material.dart';

class FAQView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              'Ordering and payment for Samples',
              style: Theme.of(context).primaryTextTheme.headline.copyWith(
                    fontSize: 22,
                  ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'How can I order for sample?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'You can find product knowledge easily using our online platform. When you find a product you need, you can order samples, login and upload all your documents go through the sampling ordering process. After the sample order is ready, you will receive order summary to your email. Order summary of samples will also be stored to your account. For bulk ordering you can contact on us by product base chat. \n\nYou can also easily make samples reorders afterwards by clicking the “reorder” button on any of your previously made orders. After clicking the “reorder” button the cart will open and you can change quantities or products for samples. For bulk we deal in offline. ',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Why should I buy online samples?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Speeding up the process. By ordering online you will you will get prices faster and you will be able to go through order confirmation and payment process much faster. This could save days of your time.\n\nTraceability: You will have easy access to all of  product information exactly and use on your product with sample.\n\nReordering:  you can make a re-order anytime based on your previous orders by only couple of clicks and put the request for customization. This will save time and effort as you don’t need to go through all the documents and emails from the past.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'What information should I input when ordering?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Our online ordering system will ask for all the important information you should submit. If you have a all Export Documents and Company information number, please remember to submit it. This will make sure the shipment is not delayed because of the lack of documents. In our website/app we have complete information.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'What payment methods can I use?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'You can use all the major by local banks. You can pay our local office in local Currency. We have local Showrooms in every country.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'What should I do if the payment is not accepted?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Please try again in a little while. If the payment is still not accepted, please verify your account balance. If everything is as it should, but you still can\'t make the payment, please contact by chat or info@onla.la to us about the problem. We can manage the order manually.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'How can I change delivery address?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Sign in to your account and go to “my account”. On “my account” you can change all your contact information. It will automatical take your address on app but if you want to change the address manually, please change.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'What are the delivery charges?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Delivery charges are dependent on the shipment requirements. If the products on your order are due to special requirements , extra fee will be added to the shipment charges. You can see the shipping fees on the checkout process before the payment is made.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'What are the terms and conditions?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'You can see the terms and conditions here.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'How can I get offer of bulk amounts?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'When you are logged in and you add products to shopping cart, you have the ability to send offer request to us using the shopping cart. You just need to add the products and quantities you are interested in and click “offer request”. We will send you an offer. Please note that this feature should only be used for bulk quantity price requests. You will receive the call from executive.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Can I pay with invoice?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'If you have already established customer relationship with  you will be granted ability to pay using invoice. If you have ordered several times from www. onla.la  but you don\'t see the invoice as a paying option on the checkout, please contact onlala@onla.la and we will check why the invoice is not activated on your account.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Can I cancel my sample order?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'If you want to cancel your order, please do so as soon as possible. If we have already processed your order, you need to contact us and return the product. Please contact onlala@onla.la',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Do I have to order offline?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'You can also send your order to onlala@onla.la You can also order using   by calling. Online ordering is preferred in most cases because by ordering online, you will save time, you will have easier payment process and all the information about the order will be accessible for you anytime. Also if you want to make same order later, you can use “reorder” feature.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Do you have the samples product in stock?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'All the products which are shown on our site are available. Order lead time depends on the  samples products and subject of availability.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'How to contact customer service?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'If you have question regarding our online store (ordering, account questions, technical questions), please contact onlala@onla.la \n\n On pricing and shipping related issues you can contact customer support at onlala@onla.la or  our executive call you.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Can we order bulk online?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Yes, you can send inquiry  order online bulk  but we have also track offline by our local office. You will get complete information online and offline mode.',
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Your account',
              style: Theme.of(context).primaryTextTheme.headline.copyWith(
                    fontSize: 22,
                  ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'How do create an account?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Go to this page onlala@onla.la and click “create a new account”, then just fill in all the needed information and click “create”.  After submitting the form, your account will be confirmed and you will be notified.   You need to submit all the documents which is required for export import. We have given more  option to upload the documents.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'How can I retrieve my password?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'You can retrieve your password by clicking “forgot password?”. Instruction on password retrieval will be send to your email.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'How do I change my personal details or email address?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'You can easily change all your information on your account.  Go to login page (www.onla.la) and log in, then click “my account” and “edit”. Here you can change all your contact information.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Security',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Our web store is secured with SSL certificate. This means the information you input is encrypted and it will not be available for third parties.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Security',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Our web store is secured with SSL certificate. This means the information you input is encrypted and it will not be available for third parties.',
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Delivery',
              style: Theme.of(context).primaryTextTheme.headline.copyWith(
                    fontSize: 22,
                  ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Can I track my order?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'We will send you the tracking code of the shipment when the parcel has been sent.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Shipping time?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Shipping time will be confirmed on the order confirmation document.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Shipping cost?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Shipping costs are dependent on your location and products on your order. Some products need to be shipped in dry ice. These dry ice shipments have a slightly higher shipping fee. Our online store shows the shipping fee and shipping cost automatically on the checkout.',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Changing the shipping address?',
              style: Theme.of(context).primaryTextTheme.headline,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'You can easily change your shipping address on your account. You just need to login and click “my account” and “edit”.  You can also change the shipping address during the checkout process if you need. Just click “edit” below “shipping address”.',
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
