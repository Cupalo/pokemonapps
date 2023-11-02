import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pokemonapps/controllers.dart/validator_controller.dart';
import 'package:pokemonapps/default/theme.dart';
import 'package:pokemonapps/ui/widget/text_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class ValidatorName extends StatelessWidget {
  ValidatorName({super.key});

  final controller = Get.put(ValidatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseTheme.appBar(
        'Validator Name',
        textColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your valid name',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(controller.regexWordAllow)
              ],
              onChanged: (value) {
                controller.name.value = value;
              },
              validator: (value) {
                return controller.getErrorMessage(value ?? '');
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ).px32().pOnly(top: 140, bottom: 20),
            FilledButton(
              onPressed: () {
                (controller.validName(controller.name.value))
                    ? dialogValid()
                    : dialogInvalid();
              },
              child: const TextValue(text: 'Submit'),
            ),
            Obx(() {
              return Column(
                children: [
                  TextValue(
                    text:
                        'validName("${controller.name.value}") => ${controller.validName(controller.name.value)}',
                    textAlign: TextAlign.center,
                  ),
                  TextValue(
                    text:
                        '// ${controller.getErrorMessage(controller.name.value) ?? 'Valid Name'}',
                    textAlign: TextAlign.center,
                  ),
                ],
              ).w(double.infinity).px32().py20();
            }),
          ],
        ),
      ),
    );
  }

  dialogValid() {
    Get.defaultDialog(
      title: 'Good Job',
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextValue(text: 'Name is Valid').px4(),
          const Icon(Icons.check_circle, color: Colors.green).px4(),
        ],
      ),
      textConfirm: 'Ok',
      onConfirm: () => Get.back(),
    );
  }

  dialogInvalid() {
    Get.defaultDialog(
      title: 'Ops Sorry',
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextValue(text: 'Name is Invalid').px4(),
          const Icon(Icons.cancel, color: Colors.red).px4(),
        ],
      ),
      textCancel: 'Ok',
      onCancel: () => Get.back(),
    );
  }
}
