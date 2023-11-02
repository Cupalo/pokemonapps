import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemonapps/controllers.dart/data_controller.dart';
import 'package:pokemonapps/default/helper.dart';
import 'package:pokemonapps/default/theme.dart';
import 'package:pokemonapps/ui/widget/list_data_.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseTheme.appBar(
        Helper.titleApps,
        textColor: Colors.red,
      ),
      body: SafeArea(
        child: ListData(),
      ),
    );
  }
}
