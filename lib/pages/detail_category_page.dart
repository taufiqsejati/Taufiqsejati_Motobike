import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taufiqsejati_motobike/controllers/browse_category_controller.dart';
import 'package:taufiqsejati_motobike/models/bike.dart';
import 'package:taufiqsejati_motobike/widgets/failed_ui.dart';

class DetailCategoryPage extends StatefulWidget {
  const DetailCategoryPage({super.key, required this.categoryId});
  final String categoryId;

  @override
  State<DetailCategoryPage> createState() => _DetailCategoryPageState();
}

class _DetailCategoryPageState extends State<DetailCategoryPage> {
  final browseCategoryController = Get.put(BrowseCategoryController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      browseCategoryController.fetchCategory(widget.categoryId);
    });
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<BrowseCategoryController>(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildItemNewest(Bike bike, EdgeInsetsGeometry margin) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/detail', arguments: bike.id);
        },
        child: Container(
          height: 98,
          margin: margin,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              ExtendedImage.network(
                bike.image,
                width: 90,
                height: 70,
                fit: BoxFit.contain,
              ),
              const Gap(7),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      bike.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff070623)),
                    ),
                    const Gap(4),
                    Text(
                      bike.category,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff838384)),
                    )
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    NumberFormat.currency(
                            decimalDigits: 0, locale: 'en_US', symbol: '\$')
                        .format(bike.price),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff6747E9)),
                  ),
                  const Text(
                    '/day',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff838384)),
                  ),
                  const Gap(7)
                ],
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Gap(MediaQuery.of(context).padding.top),
          buildHeader(),
          const Gap(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                String status = browseCategoryController.status;
                if (status == "") return const SizedBox();
                if (status == "loading") {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (status != "success") {
                  return const Center(
                    child: FailedUI(message: "problem"),
                  );
                }
                List<Bike> list = browseCategoryController.list;
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      Bike bike = list[index];
                      final margin = EdgeInsets.only(
                          top: index == 0 ? 10 : 9,
                          bottom: index == list.length - 1 ? 20 : 9);
                      return buildItemNewest(bike, margin);
                      // return Text('sample');
                    });
              })
            ],
          )
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 46,
              width: 46,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                'assets/ic_arrow_back.png',
                height: 24,
                width: 24,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Categories ${widget.categoryId}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff070623),
              ),
            ),
          ),
          const SizedBox(
            height: 46,
            width: 46,
          )
          // Container(
          //   height: 46,
          //   width: 46,
          //   decoration: const BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Colors.white,
          //   ),
          //   alignment: Alignment.center,
          //   child: Image.asset(
          //     'assets/ic_favorite.png',
          //     height: 24,
          //     width: 24,
          //   ),
          // ),
        ],
      ),
    );
  }
}
