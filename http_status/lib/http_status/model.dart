import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http_status/services/http.dart';

class StatusDto {
  late int code;
  late String title;
  late String image;

  StatusDto({this.code = 0, this.title = '', this.image = ''});

  StatusDto.fromJson(Map<String, dynamic> json) {
    code = json['status_code'];
    title = json['title'];
    image = json['image']['jpg'];
  }
}

class HttpStatus extends ChangeNotifier {
  int getCount() => _status.length;
  String getCode(int index) => _status[index];

  int getRandomCode() {
    final index = Random().nextInt(_status.length);
    final code = getCode(index);
    return int.tryParse(code) ?? getRandomCode();
  }

  Future<StatusDto> getStatus(int codigo) async {
    String s = await Http.get(codigo);
    return StatusDto.fromJson(json.decode(s));
  }

  static const _status = [
    'Informational',
    '100',
    '101',
    '102',
    'Success',
    '200',
    '201',
    '202',
    '203',
    '204',
    '205',
    '206',
    '207',
    '208',
    '226',
    'Redirection',
    '300',
    '301',
    '302',
    '303',
    '304',
    '305',
    '306',
    '307',
    '308',
    'Client Error',
    '400',
    '401',
    '402',
    '403',
    '404',
    '405',
    '406',
    '407',
    '408',
    '409',
    '410',
    '411',
    '412',
    '413',
    '414',
    '415',
    '416',
    '417',
    '418',
    '420',
    '422',
    '423',
    '424',
    '425',
    '426',
    '428',
    '429',
    '431',
    '444',
    '449',
    '450',
    '451',
    '499',
    'Server Error',
    '500',
    '501',
    '502',
    '503',
    '504',
    '505',
    '506',
    '507',
    '508',
    '509',
    '510',
    '511',
    '598',
    '599',
    'Miscellaneous',
    '999',
  ];
}
