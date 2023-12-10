import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/controller/brgy_controller.dart';
import 'package:ebayan/controller/user_controller.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
import 'package:ebayan/presentation/dashboard/announcements/widgets/announcement_card.dart';
import 'package:ebayan/utils/global.dart';
import 'package:ebayan/constants/size.dart';
import 'package:ebayan/widgets/layout_components/appbar_bottom.dart';
import 'package:ebayan/widgets/layout_components/appbar_top.dart';
import 'package:ebayan/widgets/utils/fade_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/loading.dart';

class SavedAnnouncementScreen extends StatefulWidget {
  const SavedAnnouncementScreen({super.key});

  @override
  State<SavedAnnouncementScreen> createState() => _SavedAnnouncementScreenState();
}

class _SavedAnnouncementScreenState extends State<SavedAnnouncementScreen> {
  // Controllers
  final AnnouncementController announcementController = AnnouncementController();
  final BarangayController brgyController = BarangayController();
  final UserController userController = UserController();

  @override
  void initState() {
    connectionHandler(context);
    super.initState();
  }

  Future<List<AnnouncementViewModel>> fetchSavedAnnouncements() async {
    return await userController.getSavedAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EBAppBar(enablePop: true),
      drawer: const EBDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(Global.paddingBody),
        child: FutureBuilder(
          future: fetchSavedAnnouncements(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      EBTypography.h1(text: 'Announcement'),
                      const SizedBox(width: Spacing.sm),
                      FaIcon(FontAwesomeIcons.solidBookmark, size: 30, color: EBColor.dark),
                    ],
                  ),
                  const SizedBox(height: Spacing.md),
                  buildLoadingIndicator(context),
                ],
              );
            } else {
              final List<AnnouncementViewModel> announcements = snapshot.data!;

              return RefreshIndicator(
                onRefresh: () async => setState(() {}),
                backgroundColor: EBColor.light,
                child: ListView.builder(
                  itemCount: announcements.isEmpty ? 1 : announcements.length,
                  itemBuilder: (context, index) {
                    return announcements.isEmpty //
                        ? const EmptySavedAnnouncements()
                        : RenderSavedAnnouncements(
                            announcements: announcements,
                            index: index,
                          );
                  },
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: const EBAppBarBottom(activeIndex: 3),
    );
  }
}

class RenderSavedAnnouncements extends StatelessWidget {
  final int index;

  const RenderSavedAnnouncements({
    super.key,
    required this.announcements,
    required this.index,
  });

  final List<AnnouncementViewModel> announcements;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (index == 0)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  EBTypography.h1(text: 'Announcement'),
                  const SizedBox(width: Spacing.sm),
                  FaIcon(FontAwesomeIcons.solidBookmark, size: 30, color: EBColor.dark),
                ],
              ),
              const SizedBox(height: Spacing.md),
            ],
          ),
        FadeIn(
          child: AnnouncementCard(announcement: announcements[index]),
        ),
      ],
    );
  }
}

class EmptySavedAnnouncements extends StatelessWidget {
  const EmptySavedAnnouncements({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            EBTypography.h1(text: 'Announcement'),
            const SizedBox(width: Spacing.sm),
            FaIcon(FontAwesomeIcons.solidBookmark, size: 30, color: EBColor.dark),
          ],
        ),
        const SizedBox(height: Spacing.md),
      ],
    );
  }
}
