import 'package:employer_details/modules/employer_list/employer_list_view.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../api/http_request.dart';
import '../../api/models/employee_list_model.dart';
import '../../utils.dart';

class Splashcontroller extends GetxController {
  List<EmployerModel?> employeeWebList = [];

  @override
  void onInit() async {
    addEmployerInDb();
    super.onInit();
  }

  addEmployerInDb() async {
    var box = Hive.box<EmployerModel>(Utils.employerListBox);
    if(box.values.toList().isEmpty){
      employeeWebList = await Repository.getEmployerDetails();
      for (var employer in employeeWebList) {
        box.add(employer!);
      }
    }
    print('box -${box.values.toList().length}');
    await Future.delayed(const Duration(seconds: 2));
    Get.offAll(() => EmployerListPage());
  }

}
