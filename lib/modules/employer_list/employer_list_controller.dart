import 'package:employer_details/api/http_request.dart';
import 'package:employer_details/api/models/employee_list_model.dart';
import 'package:employer_details/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class EmployerListcontroller extends GetxController {
  TextEditingController searchController = TextEditingController();



  @override
  void onInit() {

    super.onInit();
  }
}
