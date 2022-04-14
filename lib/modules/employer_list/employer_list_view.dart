import 'package:employer_details/api/models/employee_list_model.dart';
import 'package:employer_details/modules/employer_details/employer_details_view.dart';
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
      body: ValueListenableBuilder<Box<EmployerModel>>(
        valueListenable: box.listenable(),
        builder: (context, box, child) {
          var employerList = box.values.toList();
          var employerFilterList = box.values.toList();
          return employerFilterList.isEmpty
              ? const Center(
                  child: Text('No Employers Found'),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Card(
                        child: TextFormField(
                          decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                              hintText: 'Search By Name or Email',
                              border: InputBorder.none),
                          controller: controller.searchController,
                          onChanged: (val) {
                            if (val.isNotEmpty) {
                              employerFilterList =
                                  employerList.where((element) {
                                return element.name!
                                        .toLowerCase()
                                        .contains(val.toLowerCase()) ||
                                    element.email!.contains(val);
                              }).toList();
                            } else {
                              employerFilterList = employerList;
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: employerFilterList.length,
                          itemBuilder: (context, index) {
                            EmployerModel employerModel =
                                employerFilterList[index];
                            return ListTile(
                              onTap: () {
                                Get.to(() => EmployerDetailsPage(),
                                    arguments: {'emp_model': employerModel});
                              },
                              visualDensity: const VisualDensity(
                                  horizontal: -4, vertical: 0),
                              leading: employerModel.profileImage == null
                                  ? CircleAvatar(
                                      radius: 25,
                                      child: Center(
                                        child: Text(employerModel.name![0]),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.network(
                                          '${employerModel.profileImage}',
                                          height: 50),
                                    ),
                              title: Text('${employerModel.name}'),
                              subtitle: Text(employerModel.company == null
                                  ? '${employerModel.email!}'
                                  : '${employerModel.company!.name}'),
                              trailing: const Icon(Icons.chevron_right),
                            );
                          }),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
