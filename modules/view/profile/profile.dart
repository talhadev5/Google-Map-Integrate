import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:tophotels/modules/viewmodel/profilelogic.dart';
import 'package:tophotels/modules/widgets/custombutton.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final controller = Get.put(Profilelogic());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Profilelogic>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Image.asset(
                  'assets/svg/bacground_image.png',
                  height: Get.height * .175,
                  width: Get.width,
                  fit: BoxFit.cover,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const SizedBox(
                            child: Row(
                              children: [
                                Icon(Icons.navigate_before),
                                Text(
                                  'Back to account',
                                  style: TextStyle(color: AppColors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(CupertinoIcons.share))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/svg/profile_pic.png'),
                          ),
                          SizedBox(
                            width: Get.width * .04,
                          ),
                          const Text(
                            'Talha Kaya',
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: Get.width * .04,
                          ),
                          const Text(
                            '@talha',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width * .17,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[00],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: AppColors.grey.withOpacity(0.3)),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Center(
                                child: Text(
                              '254 friends',
                              style: TextStyle(
                                color: AppColors.grey,
                              ),
                            )),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[00],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: AppColors.grey.withOpacity(0.3)),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Center(
                                child: Text(
                              '754 Chiip send',
                              style: TextStyle(
                                color: AppColors.grey,
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CustomButton(
                        title: 'Edit Profile',
                        backgroundColor: AppColors.primaryBlue,
                        onTap: () {},
                        textColor: AppColors.black,
                        borderSideColor: Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .02,
                    ),
                    Divider(
                      color: AppColors.grey.withOpacity(0.3),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        height: 35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.geryColorLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            // Purchases Button
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.selectedOption = 'Purchases';
                                    controller.update();
                                  },
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: controller.selectedOption ==
                                              'Purchases'
                                          ? AppColors.white
                                          : AppColors.geryColorLight,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Purchases',
                                        style: TextStyle(
                                          color: controller.selectedOption ==
                                                  'Purchases'
                                              ? AppColors.black
                                              : AppColors.grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Activity Button
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.selectedOption = 'Activity';
                                    controller.update();
                                  },
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: controller.selectedOption ==
                                              'Activity'
                                          ? AppColors.white
                                          : AppColors.geryColorLight,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Activity',
                                        style: TextStyle(
                                          color: controller.selectedOption ==
                                                  'Activity'
                                              ? AppColors.black
                                              : AppColors.grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .01,
                    ),
                    controller.selectedOption == 'Purchases'
                        ? Column(
                            children: [
                              ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.cardata.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final data = controller.cardata[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 2),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      tileColor: AppColors.white,
                                      leading:
                                          Image.asset(data['image'].toString()),
                                      title: Text(
                                        data['title'].toString(),
                                        style: const TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      subtitle: const Text(
                                        '02/02/2023',
                                        style: TextStyle(
                                            color: AppColors.grey,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      trailing: Text(
                                        data['tralling'].toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: AppColors.green,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  tileColor: AppColors.white,
                                  leading:
                                      Image.asset('assets/svg/image 24.png'),
                                  title: const Text(
                                    'Sent 1x Golden Chiips to Talha',
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: const Text(
                                    '02/02/2023',
                                    style: TextStyle(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: SvgPicture.asset(
                                      'assets/svg/Gold Chiip.svg'),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * .004,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  tileColor: AppColors.white,
                                  leading:
                                      Image.asset('assets/svg/image 24-1.png'),
                                  title: const Text(
                                    'Sent 1x Diamond Chiips to Billy',
                                    style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: const Text(
                                    '02/02/2023',
                                    style: TextStyle(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: SvgPicture.asset(
                                      'assets/svg/Diamond Chiip.svg'),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
