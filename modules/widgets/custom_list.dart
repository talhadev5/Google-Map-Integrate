import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:tophotels/modules/view/filter.dart';
import 'package:tophotels/modules/widgets/custom_listitems.dart';

class CustomListViewWidget extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {
      'image': 'assets/svg/camilton.jpg',
      'title': 'Camilton Bar & Food',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'High',
    },
    {
      'image': 'assets/svg/serentity.jpg',
      'title': 'Serenity Bar',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'High',
    },
    {
      'image': 'assets/svg/mucks.jpg',
      'title': 'Mucks Cocktail Bar',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'High',
    },
    {
      'image': 'assets/svg/harry.jpg',
      'title': 'Harry & Co',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'Normal',
    },
    {
      'image': 'assets/svg/level.jpg',
      'title': 'Level27',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'Normal',
    },
    {
      'image': 'assets/svg/jimmy.jpg',
      'title': 'Jimmys Beer',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'Normal',
    },
    {
      'image': 'assets/svg/american.jpg',
      'title': 'American Roots Pub',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'Normal',
    },
    {
      'image': 'assets/svg/devils.jpg',
      'title': 'Devils Drinks',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'Normal',
    },
    {
      'image': 'assets/svg/beerbar.jpg',
      'title': 'Beer Bar',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'Normal',
    },
  ];
  final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
  final ValueNotifier<double> _distanceNotifier = ValueNotifier(0);

  CustomListViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * .05,
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      // Add custom label with icon and text
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/svg/mappin.and.ellipse 1.png',
                          ), // Replace with desired icon
                          const SizedBox(
                              width: 4), // Space between icon and text
                          const Text(
                            'Current location',
                            style: TextStyle(
                                color: Colors.grey), // Label text style
                          ),
                        ],
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'West House 5th, 3562 New York', // Hint text
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      // contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      suffixIcon: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled:
                                  true, // Allows full-screen height
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16)),
                              ),
                              builder: (context) => FilterOptions(
                                valueNotifier: _valueNotifier,
                                distanceNotifier: _distanceNotifier,
                              ),
                            );
                          },
                          icon: SvgPicture.asset('assets/svg/filter_icon.svg')),
                    ),
                  ),
                  const Divider(),
                  const Text(
                    '42 bars found near the address',
                    style: TextStyle(color: AppColors.grey),
                  ),
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 10, bottom: 30),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            CustomListItem(
                              imageUrl: data[index]['image'],
                              title: data[index]['title'],
                              isVerified: data[index]['isVerified'],
                              rating: data[index]['rating'],
                              status: data[index]['status'],
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
