import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taufiqsejati_motobike/fragment/browse_fragment.dart';
import 'package:taufiqsejati_motobike/fragment/orders_fragment.dart';
import 'package:taufiqsejati_motobike/fragment/settings_fragmanet.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final fragments = [
    const BrowseFragment(),
    const OrdersFragment(),
    const SettingsFragment()
  ];
  final fragmentIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Obx(() => fragments[fragmentIndex.value]),
      bottomNavigationBar: Obx(() {
        return Container(
          height: 78,
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: const Color(0xff070623),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              buildItemNav(
                label: 'Browse',
                icon: 'assets/ic_browse.png',
                iconOn: 'assets/ic_browse_on.png',
                onTap: () {
                  fragmentIndex.value = 0;
                },
                isActive: fragmentIndex.value == 0,
              ),
              buildItemNav(
                label: 'Orders',
                icon: 'assets/ic_orders.png',
                iconOn: 'assets/ic_orders_on.png',
                onTap: () {
                  fragmentIndex.value = 1;
                },
                isActive: fragmentIndex.value == 1,
              ),
              buildItemCircle(),
              buildItemNav(
                  label: 'Chats',
                  icon: 'assets/ic_chats.png',
                  iconOn: 'assets/ic_chats_on.png',
                  onTap: () {
                    // fragmentIndex.value = 2;
                  },
                  // isActive: fragmentIndex.value == 2,
                  hasDot: true),
              buildItemNav(
                label: 'Settings',
                icon: 'assets/ic_settings.png',
                iconOn: 'assets/ic_settings_on.png',
                onTap: () {
                  fragmentIndex.value = 2;
                },
                isActive: fragmentIndex.value == 2,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildItemNav({
    required String label,
    required String icon,
    required String iconOn,
    bool isActive = false,
    required VoidCallback onTap,
    bool hasDot = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          height: 46,
          child: Column(
            children: [
              Image.asset(
                isActive ? iconOn : icon,
                height: 24,
                width: 24,
              ),
              const Gap(4),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(isActive ? 0xffFFBC1C : 0xffFFFFFF)),
                  ),
                  if (hasDot)
                    Container(
                      margin: const EdgeInsets.only(left: 2),
                      height: 6,
                      width: 6,
                      decoration: const BoxDecoration(
                          color: Color(0xffFF2056), shape: BoxShape.circle),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemCircle() {
    return Container(
      height: 50,
      width: 50,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Color(0xffFFBC1C)),
      child: UnconstrainedBox(
        child: Image.asset(
          'assets/ic_status.png',
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
