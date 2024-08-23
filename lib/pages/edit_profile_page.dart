import 'package:d_session/d_session.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:taufiqsejati_motobike/common/info.dart';
import 'package:taufiqsejati_motobike/models/account.dart';
import 'package:taufiqsejati_motobike/sources/auth_source.dart';
import 'package:taufiqsejati_motobike/widgets/button_primary.dart';
import 'package:taufiqsejati_motobike/widgets/input.dart';

class EditProfilePage extends StatefulWidget {
  final Account account;
  const EditProfilePage({super.key, required this.account});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final edtEmail = TextEditingController();
  final edtName = TextEditingController();
  final edtUID = TextEditingController();

  @override
  void initState() {
    setState(() {
      edtEmail.text = widget.account.email;
      edtName.text = widget.account.name;
      edtUID.text = widget.account.uid;
    });
    super.initState();
  }

  editProfile() {
    if (edtEmail.text == '') return Info.error('Email must be filled');
    if (edtName.text == '') return Info.error('Name must be filled');
    if (edtUID.text == '') return Info.error('Name must be filled');

    // Info.netral('Loading..');
    // AuthSource.changePassword(
    //   edtPasswordLama.text,
    //   edtPasswordBaru.text,
    //   edtEmail.text,
    // ).then((message) {
    //   if (message != 'success') return Info.error(message);

    //   //success
    //   Info.success('Success Change Password');
    //   Future.delayed(const Duration(milliseconds: 1500), () {
    //     DSession.removeUser().then((removed) {
    //       if (!removed) return;
    //       Navigator.pushReplacementNamed(context, '/signin');
    //     });
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
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
                'Edit Profile',
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

    return Scaffold(
      body: ListView(padding: const EdgeInsets.all(0), children: [
        Gap(MediaQuery.of(context).padding.top),
        buildHeader(),
        const Gap(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'UID',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff070623)),
              ),
              const Gap(12),
              Input(
                onTapBox: () {},
                editingController: edtUID,
                icon: 'assets/ic_profile.png',
                hint: 'Write real name',
                enable: false,
              ),
              const Gap(20),
              const Text(
                'Email Address',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff070623)),
              ),
              const Gap(12),
              Input(
                onTapBox: () {},
                editingController: edtEmail,
                icon: 'assets/ic_email.png',
                hint: 'Write real email',
                enable: false,
              ),
              const Gap(20),
              const Text(
                'Name',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff070623)),
              ),
              const Gap(12),
              Input(
                onTapBox: () {},
                editingController: edtName,
                icon: 'assets/ic_profile.png',
                hint: 'Write real name',
              ),
              const Gap(30),
              ButtonPrimary(text: 'Simpan Perubahan', onTap: editProfile),
              const Gap(30),
            ],
          ),
        ),
      ]),
    );
  }
}
