import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taufiqsejati_motobike/controllers/browse_featured_controller.dart';

class BrowseFragment extends StatefulWidget {
  const BrowseFragment({super.key});

  @override
  State<BrowseFragment> createState() => _BrowseFragmentState();
}

class _BrowseFragmentState extends State<BrowseFragment> {
  final browseFeaturedController = Get.put(BrowseFeaturedController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      browseFeaturedController.fetchFeatured();
    });
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<BrowseFeaturedController>(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        Gap(30 + MediaQuery.of(context).padding.top),
        buildHeader(),
        const Gap(20),
        buildCategory()
      ],
    );
  }

  Widget buildCategory() {
    final categories = [
      ['City', 'assets/ic_city.png'],
      ['Downhill', 'assets/ic_downhill.png'],
      ['Beach', 'assets/ic_beach.png']
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Categories',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff070623)),
          ),
        ),
        const Gap(10),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Row(
              children: categories.map(
                (e) {
                  return Container(
                    height: 52,
                    margin: const EdgeInsets.only(right: 24),
                    padding: const EdgeInsets.fromLTRB(16, 14, 30, 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    child: Row(
                      children: [
                        Image.asset(
                          e[1],
                          width: 24,
                          height: 24,
                        ),
                        const Gap(10),
                        Text(
                          e[0],
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff070623)),
                        )
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        )
      ],
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/logo_text.png',
            height: 38,
            fit: BoxFit.fitHeight,
          ),
          Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/ic_notification.png',
              height: 24,
              width: 24,
            ),
          )
        ],
      ),
    );
  }
}
