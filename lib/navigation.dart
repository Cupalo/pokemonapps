import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemonapps/controllers.dart/navigation_controller.dart';
import 'package:pokemonapps/ui/page/home.dart';
import 'package:pokemonapps/ui/page/validator_name.dart';

class Navigation extends StatelessWidget {
  Navigation({Key? key}) : super(key: key);
  final NavigationController navigationController =
      Get.put(NavigationController());

  final List<Widget> listItems = [
    Home(),
    const ValidatorName(),
  ];

  @override
  Widget build(BuildContext context) {
    DateTime preBackpress = DateTime.now();
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(preBackpress);
          final cantExit = timegap >= const Duration(seconds: 2);
          preBackpress = DateTime.now();
          if (cantExit) {
            const snack = GetSnackBar(
              message: 'Press Back button again to Exit',
              duration: Duration(seconds: 2),
              backgroundColor: Colors.black,
            );
            Get.showSnackbar(snack);
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          body: listItems[navigationController.currentIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.red,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.android),
                label: 'Pokemon',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.text_fields),
                label: 'Validator',
              ),
            ],
            currentIndex: navigationController.currentIndex.value,
            onTap: (value) {
              navigationController.changeIndex(value);
            },
          ),
        ),
      );
    });
  }
}
