import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('terms_and_conditions'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            
            children: [
              Text(
                'Terms and Conditions',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                'Last updated: 2021-09-30',
                style: TextStyle(fontSize: 20, ),
              ),
              Text(
                'Please read this Terms and Conditions carefully before using the http://www.sacrap.com website operated by Sacrap.',
                style: TextStyle(fontSize: 20, ),
              ),
              Text(
                'Your access to and use of the Service is conditioned on your acceptance of and compliance with these Terms. These Terms apply to all visitors, users and others who access or use the Service.',
                style: TextStyle(fontSize: 20, ),
              ),
              Text(
                'By accessing or using the Service you agree to be bound by these Terms. If you disagree with any part of the terms then you may not access the Service.',
                style: TextStyle(fontSize: 20, ),
              ),
              Text(
                'Purchases',
                style: TextStyle(fontSize: 20, ),
              ),
              Text(
                'If you wish to purchase any product or service made available through the Service ("Purchase"), you may be asked to supply certain information relevant to your Purchase including, without limitation, your ...',
                style: TextStyle(fontSize: 20, ),
              ),
              Text(
                'Subscriptions',
                style: TextStyle(fontSize: 20, ),
              ),
              Text(
                'Some parts of the Service are billed on a subscription basis ("Subscription(s)"). You will be billed in advance on a recurring ...',
                style: TextStyle(fontSize: 20, ),
              ),
              Text(
                'Content',
                style: TextStyle(fontSize: 20, ),
              ),
              Text(
                'Our Service allows you to post, link, store, share and otherwise make available certain information, text, graphics, videos, or other material ("Content"). You are responsible for the ...',
                style: TextStyle(fontSize: 20, ),
              ),
              Text(
                'Links To Other Web Sites',
                style: TextStyle(fontSize: 20, ),
              ),
            ]),
        )));
  }
}