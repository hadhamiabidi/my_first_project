import 'package:get/get.dart';

import '../models/claim_model.dart';

class ClaimsController extends GetxController {
  final List<Claim> claims = [
    Claim(
      title: 'Claim 1',
      description: 'Description for Claim 1',
      date: '2022-01-01',
    ),
    Claim(
      title: 'Claim 2',
      description: 'Description for Claim 2',
      date: '2022-02-01',
    ),
    Claim(
      title: 'Claim 3',
      description: 'Description for Claim 3',
      date: '2022-03-01',
    ),
  ].obs;

}
