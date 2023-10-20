import 'package:ebayan/constants/assets.dart';
import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/icons.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/screens/auth/login.dart';
import 'package:ebayan/screens/resident/join_brgy.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class EBTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const EBTopAppBar({Key? key}) : super(key: key);

  @override
  State<EBTopAppBar> createState() => _EBTopAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _EBTopAppBarState extends State<EBTopAppBar> {
  @override
  Widget build(BuildContext context) {
    const iconSize = 20.0;

    return AppBar(
      iconTheme: const IconThemeData(color: EBColor.primary),
      title: Row(
        children: [
          EBTypography.h3(
            text: 'eBayan',
            color: EBColor.primary,
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(Asset.logoColorPath),
        ],
      ),
      leading: Container(
        // moves the drawer icon to the right more
        margin: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
        child: InkResponse(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: const Icon(
            EBIcons.menu,
            size: iconSize,
            color: EBColor.dark,
          ),
        ),
      ),
      backgroundColor: EBColor.light,
      elevation: 1,
    );
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class TooltipContainer extends StatelessWidget {
  final String message;

  const TooltipContainer({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    const double paddingTooltipContainer = 20.0;

    return Container(
      decoration: BoxDecoration(
        color: EBColor.primary,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(paddingTooltipContainer),
        child: EBTypography.text(text: message, color: EBColor.light),
      ),
    );
  }
}

class EBDrawer extends StatefulWidget {
  const EBDrawer({super.key});

  @override
  State<EBDrawer> createState() => _EBDrawerState();
}

class _EBDrawerState extends State<EBDrawer> {
  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      // NOTE: fix this
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.leftToRight,
          child: const LoginScreen(),
        ),
      );
    } catch (e) {
      print('Sign-in failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const iconSize = 20.0;

    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 57.0,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                  child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).closeDrawer();
                    },
                    icon: const Icon(
                      EBIcons.menu,
                      size: iconSize,
                    ),
                  ),
                ),
                EBTypography.h3(
                  text: 'eBayan',
                  color: EBColor.primary,
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(Asset.logoColorPath),
              ],
            ),
          ),
          ListTile(
            title: EBTypography.text(text: 'Dashboard'),
            onTap: () {},
          ),
          ListTile(
            title: EBTypography.text(text: 'File Complaints'),
            onTap: () {},
          ),
          ListTile(
            title: EBTypography.text(text: 'Raise Suggestions'),
            onTap: () {},
          ),
          ListTile(
            title: EBTypography.text(text: 'Account Settings'),
            onTap: () {},
          ),
          ListTile(
            title: EBTypography.text(text: 'Logout', color: EBColor.danger),
            onTap: () {
              logOut();
            },
          ),
        ],
      ),
    );
  }
}
