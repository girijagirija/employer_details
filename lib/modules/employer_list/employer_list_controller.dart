import 'package:employer_details/api/http_request.dart';
import 'package:employer_details/api/models/employee_list_model.dart';
import 'package:employer_details/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

enum EmployerListState { LOADING, LOADED, EMPTY }

class EmployerListcontroller extends GetxController {
  TextEditingController searchController = TextEditingController();

  List<EmployerModel> employerFilterList = [];
  List<EmployerModel> employerList = [];
  var state = EmployerListState.LOADING.obs;

  @override
  void onInit() {
    searchController.addListener(() {
      if (searchController.text.isNotEmpty) {
        print('search -${searchController.text}');
        employerFilterList = employerList.where((element) {
          return element.name!
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ||
              element.email!.contains(searchController.text.toLowerCase());
        }).toList();
      } else {
        employerFilterList = employerList;
      }
      update();
    });
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  fetchList() {
    state.value = EmployerListState.LOADING;
    var box = Hive.box<EmployerModel>(Utils.employerListBox);
    employerFilterList = box.values.toList();
    employerList = box.values.toList();
    if (employerFilterList.isEmpty) {
      state.value = EmployerListState.EMPTY;
    } else {
      state.value = EmployerListState.LOADED;
    }
  }

  @override
  void onReady() {
    fetchList();
    super.onReady();
  }
}
