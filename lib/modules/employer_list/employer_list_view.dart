import 'package:employer_details/api/models/employee_list_model.dart';
import 'package:employer_details/modules/employer_details/employer_details_view.dart';
import 'package:employer_details/modules/employer_list/widgets/employer_list_item.dart';
import 'package:employer_details/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'employer_list_controller.dart';

class EmployerListPage extends StatelessWidget {
  final controller = Get.put(EmployerListcontroller());

  var box = Hive.box<EmployerModel>(Utils.employerListBox);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employer List'),
      ),
      body: Obx(() {
        switch (controller.state.value) {
          case EmployerListState.LOADING:
            return const Center(
              child: CircularProgressIndicator(),
            );
            break;
          case EmployerListState.LOADED:
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Card(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          hintText: 'Search By Name or Email',
                          labelText: 'Search By Name or Email',
                          border: InputBorder.none),
                      controller: controller.searchController,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GetBuilder<EmployerListcontroller>(
                    builder: (controller) {
                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: controller.employerFilterList.length,
                        itemBuilder: (context, index) {
                          EmployerModel employerModel =
                          controller.employerFilterList[index];
                          return ListItem(employerModel: employerModel);
                        }),
                  );
                }),
              ],
            );
            break;
          case EmployerListState.EMPTY:
            return const Center(
              child: const Text('No Employers Found'),
            );
            break;
          default:
            return Container();
        }
      }),
    );
  }
}
