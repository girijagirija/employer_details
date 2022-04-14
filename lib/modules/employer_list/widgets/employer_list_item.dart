import 'package:employer_details/api/models/employee_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../employer_details/employer_details_view.dart';

class ListItem extends StatelessWidget {
  EmployerModel employerModel;
   ListItem({Key? key, required this.employerModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(() => EmployerDetailsPage(),
            arguments: {'emp_model': employerModel});
      },
      visualDensity: const VisualDensity(horizontal: -4, vertical: 0),
      leading: employerModel.profileImage == null
          ? CircleAvatar(
              radius: 25,
              child: Center(
                child: Text(employerModel.name![0]),
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network('${employerModel.profileImage}', height: 50),
            ),
      title: Text('${employerModel.name}'),
      subtitle: Text(employerModel.company == null
          ? '${employerModel.email!}'
          : '${employerModel.company!.name}'),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
