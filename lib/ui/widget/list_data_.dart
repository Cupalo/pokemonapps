import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pokemonapps/controllers.dart/data_controller.dart';
import 'package:pokemonapps/default/helper.dart';
import 'package:pokemonapps/models/items.dart';
import 'package:pokemonapps/ui/page/detail.dart';
import 'package:pokemonapps/ui/widget/circle_background.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../default/theme.dart';

class ListData extends StatelessWidget {
  ListData({
    Key? key,
  }) : super(key: key);

  final DataController dataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Data?>(
      future: dataController.getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          dataController.listPokemon.value = snapshot.data;
          var listColor = Helper().getListColor(
            length: snapshot.data?.results?.length,
          );
          dataController.listColor.value = listColor;
          return GridView.builder(
            padding: BaseTheme.marginHorizontalSmall,
            itemCount: snapshot.data!.results?.length ?? 0,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              var item = snapshot.data!.results![index];
              var image = Helper().getImage(index + 1);
              return InkWell(
                onTap: () {
                  var id = index + 1;
                  dataController.selectedId.value = id;
                  Get.to(() => DetailPage(id: id));
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: listColor[index],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: Get.width * 0.02,
                        left: Get.width * 0.02,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.shade700.withOpacity(0.4),
                          ),
                          child: Text(
                            (item.name ?? '-').capitalized,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.width * 0.05,
                              letterSpacing: 1.5,
                              shadows: const [
                                Shadow(
                                  color: Colors.black,
                                  offset: Offset(0.5, 0.5),
                                ),
                              ],
                            ),
                          ).py8().px12(),
                        ),
                      ),
                      CircleBackground(
                        height: Get.width * 0.4,
                        width: Get.width * 0.4,
                      ).positioned(
                        right: -8,
                        bottom: -20,
                      ),
                      StreamBuilder<bool>(
                        initialData: true,
                        stream: Stream.periodic(
                          const Duration(seconds: 1),
                          (computationCount) {
                            return (computationCount % 2 == 0 ||
                                computationCount == 0);
                          },
                        ),
                        builder: (context, snapshot) {
                          return AnimatedPositioned(
                            duration: const Duration(seconds: 1),
                            bottom: snapshot.data ?? true ? 3 : 0,
                            left: 0,
                            right: 0,
                            child: SvgPicture.network(
                              image,
                              height: Get.width * 0.3,
                              width: Get.width * 0.3,
                              alignment: Alignment.bottomRight,
                            ).p8(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return SizedBox(
            height: Get.height * 0.8,
            width: Get.width,
            child: Center(
              child: BaseTheme.loading(),
            ),
          );
        }
      },
    );
  }
}
