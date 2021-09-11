
import 'dart:js';
import 'package:bidding_app/presentation/pages/profilePage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';

void main(){
  testWidgets('Profile Page reads box Storage',(WidgetTester tester) async{
    await tester.pumpWidget(ProfilePage());
  });
  final box = GetStorage();
  box.write('name', "yishak");
  box.write('email', "yis@gmail.com");

  final nameFinder = find.text("yishak");
  final emailfinder = find.text("yis@gmail.com");

  expect(nameFinder, findsOneWidget);
  expect(emailfinder, findsOneWidget);
}