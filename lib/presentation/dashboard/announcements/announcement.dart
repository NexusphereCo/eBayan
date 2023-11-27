import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/controller/anct_controller.dart';
import 'package:ebayan/data/viewmodel/announcement_view_model.dart';
import 'package:ebayan/presentation/dashboard/announcements/widgets/comment_section.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  _AnnouncementScreenState createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  final AnnouncementController _announcementController = AnnouncementController();

  @override
  Widget build(BuildContext context) {
    String annId = ModalRoute.of(context)?.settings.arguments as String;
    Future<AnnouncementViewModel> _announcementFuture = _announcementController.fetchAnnouncementDetails(annId);

    return FutureBuilder<AnnouncementViewModel>(
      future: _announcementFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: Text('Announcement not found.'),
            ),
          );
        } else {
          AnnouncementViewModel announcement = snapshot.data!;
          return Scaffold(
            appBar: EBAppBar(
              enablePop: true,
              noTitle: true,
              more: true,
              annId: announcement.id,
            ),
            body: Padding(
              padding: const EdgeInsets.all(Global.paddingBody),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      EBTypography.h2(
                        text: announcement.heading,
                        color: EBColor.primary,
                      ),
                      const SizedBox(height: Spacing.sm),
                      Row(
                        children: [
                          const Icon(FeatherIcons.feather, size: 13, color: Colors.black45),
                          EBTypography.small(text: 'John Doe', muted: true), // authorName
                        ],
                      ),
                      EBTypography.small(text: announcement.formattedTime, muted: true), // timeCreated
                    ],
                  ),
                  const SizedBox(height: Spacing.md),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EBTypography.text(
                        text: announcement.body.toString(),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: Spacing.lg),
                      const SizedBox(height: Spacing.md),
                      EBTypography.small(text: 'What do you think about this post?', fontWeight: FontWeight.bold),
                      const SizedBox(height: Spacing.sm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(FeatherIcons.thumbsUp, size: 13, color: EBColor.primary),
                              const SizedBox(width: 3),
                              EBTypography.small(text: 'Like', color: EBColor.primary),
                            ],
                          ),
                          const SizedBox(width: Spacing.lg),
                          Row(
                            children: [
                              Icon(FeatherIcons.thumbsDown, size: 13, color: EBColor.primary),
                              const SizedBox(width: 3),
                              EBTypography.small(text: 'Dislike', color: EBColor.primary),
                            ],
                          ),
                        ],
                      )
                    ],
                  ), // Position at the bottom center
                ],
              ),
            ),
            floatingActionButton: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: Global.paddingBody),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const CommentSection();
                      },
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                      ),
                    );
                  },
                  label: const Text('View Comment'), // Text label
                  icon: const Icon(FeatherIcons.messageCircle), // Icon
                  backgroundColor: EBColor.light, // Background color
                  foregroundColor: EBColor.primary, // Text and icon color
                  shape: RoundedRectangleBorder(
                    // Customize the shape
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(
                      color: EBColor.primary,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
