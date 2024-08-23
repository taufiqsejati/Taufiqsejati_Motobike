import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taufiqsejati_motobike/models/bike.dart';
import 'package:taufiqsejati_motobike/sources/bike_source.dart';

class BrowseCategoryController extends GetxController {
  final _list = <Bike>[].obs;
  List<Bike> get list => _list;
  set list(List<Bike> n) => _list.value = n;

  final _status = ''.obs;
  String get status => _status.value;
  set status(String n) => _status.value = n;

  fetchCategory(String categoryId) async {
    status = 'loading';

    final bikes = await BikeSource.fetchCategoryBikes(categoryId);
    if (bikes == null) {
      status = 'something wrong';
      debugPrint('failed newest : ${list.length.toString()}');
      return;
    }

    status = 'success';
    list = bikes;
    debugPrint('sukses newest : ${list.length.toString()}');
  }
}
