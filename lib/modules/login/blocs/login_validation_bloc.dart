import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

mixin LoginValidationBloc {
  // Streams for each input field
  var userMobileNum = BehaviorSubject<String>();
  var userOTP = BehaviorSubject<String>();

  Stream<String> mobileNum(BuildContext pageContext) =>
      userMobileNum.stream.transform(validateMobNum(pageContext));
  Stream<String> otp(BuildContext pageContext) =>
      userOTP.stream.transform(validateOTP(pageContext));

  StreamTransformer<String, String> validateMobNum(BuildContext pageContext) =>
      StreamTransformer<String, String>.fromHandlers(
          handleData: (mobile, sink) {
        if (mobile.isEmpty) {
          sink.addError("Mobile number should not be empty.");
        } else if (!RegExp(r'^\d{10}$').hasMatch(mobile)) {
          sink.addError("Enter a valid mobile number.");
        } else {
          sink.add(mobile);
        }
      });

  StreamTransformer<String, String> validateOTP(BuildContext pageContext) =>
      StreamTransformer<String, String>.fromHandlers(handleData: (otp, sink) {
        if (otp.isEmpty) {
          sink.addError("OTP should not be empty.");
        } else if (!RegExp(r'^\d{4}$').hasMatch(otp)) {
          sink.addError("Enter a four digit OTP.");
        } else {
          sink.add(otp);
        }
      });

  //Validating Buttons
  Stream<bool> validateLoginDetails(BuildContext context) =>
      Rx.combineLatest2(mobileNum(context), otp(context), (a, b) => true);

  Function(String) get changeMobileNum => userMobileNum.sink.add;
  Function(String) get changeUserOTP => userOTP.sink.add;
}
