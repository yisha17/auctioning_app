import 'package:bidding_app/presentation/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';



void main(){
  testWidgets("Flutter Widget Test",  (WidgetTester tester) async {
    await tester.pumpWidget(LoginPage());
    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, 'Flutter Devs');
  expect(find.text('Flutter Devs'), findsOneWidget);
  print('Flutter Devs');
  var button = find.text('Sign in');
  expect(button,findsOneWidget);
  });
}