

import 'package:bidding_app/presentation/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test("Utils should give current hour",(){

    Utils.toDate(DateTime.now());
    expect(Utils.toTime(DateTime.now()), "21:10") ; 
  });
}