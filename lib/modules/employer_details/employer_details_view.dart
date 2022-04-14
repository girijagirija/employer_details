import 'dart:io';

import 'package:employer_details/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'employer_details_controller.dart';

class EmployerDetailsPage extends StatelessWidget {
  final controller = Get.put(EmployerDetailscontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: controller.model.profileImage == null
                    ? CircleAvatar(
                        radius: 30,
                        child: Center(
                          child: Text(
                            '${controller.model.name![0]}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    : Container(
                        height: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    controller.model.profileImage!))),
                      ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                '${controller.model.name}',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 20,
              ),
              ///Address INfo
              const Text('Address Info:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 5,
              ),
              Text(
                  '${controller.model.address!.suite},${controller.model.address!.street},'),
              const SizedBox(
                height: 5,
              ),
              Text(
                  '${controller.model.address!.city},${controller.model.address!.zipcode}.'),
              const SizedBox(
                height: 5,
              ),
              if (controller.model.email!.isNotEmpty)
                InkWell(
                  onTap: () async {
                   await Utils.launchURL('mailto:${controller.model.email}');
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Mail :${controller.model.email}',
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.mail,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              if (controller.model.phone!.isNotEmpty)
                const SizedBox(
                  height: 5,
                ),
              if (controller.model.phone!.isNotEmpty)
                InkWell(
                  onTap: () async {
                    await Utils.launchURL('call:${controller.model.phone}');
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Call Us: ${controller.model.phone}',
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(
                        Icons.call,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(onPressed: () async{
                String mapLuanchUrl = '';
                if (Platform.isAndroid) {
                  mapLuanchUrl =
                      "https://www.google.com/maps/search/?api=1&query=" + controller.model.address!.geo!.lat.toString() + "," + controller.model.address!.geo!.lng.toString();
                  await Utils.launchURL(mapLuanchUrl);
                }
              }, child: Text('View Directions')),
              ///Company Info
              if(controller.model.company != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('Company Info:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('${controller.model.company!.name}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("${controller.model.company!.catchPhrase}",
                        style: const TextStyle(fontSize: 12)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('Description: ${controller.model.company!.bs}'),
                    const SizedBox(
                      height: 5,
                    ),

                  ],
                ),
              InkWell(
                onTap: ()async {
                  await Utils.launchURL('${controller.model.website}');
                },
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Website:${controller.model.website}',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.open_in_browser,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
