import 'package:ebayan/constants/colors.dart';
import 'package:ebayan/constants/typography.dart';
import 'package:ebayan/utils/routes.dart';
import 'package:ebayan/utils/style.dart';
import 'package:ebayan/widgets/shared/appbar_bottom.dart';
import 'package:ebayan/widgets/shared/appbar_top.dart';
import 'package:ebayan/widgets/utils/fade_in.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'widgets/guide_card.dart';
import 'widgets/temp_dashboard.dart';
import 'widgets/temp_dashboard_empty.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  TutorialCoachMark? tutorialCoachMark;

  final GlobalKey _joinBtnKey = GlobalKey();
  final GlobalKey _drawerKey = GlobalKey();
  final GlobalKey _cardAnnouncementsKey = GlobalKey();
  final GlobalKey _cardSphereKey = GlobalKey();

  // variables
  List<TargetFocus> _targets = [];
  int currentStep = 1;

  void _initTarget() {
    _targets = [
      TargetFocus(
        identify: 'join-btn-key',
        keyTarget: _joinBtnKey,
        enableTargetTab: false,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return guideCard(
                currentStep: currentStep,
                heading: 'Join a Barangay',
                description: 'Get started and join a barangay through this button!',
                tailPosition: TailPosition.bottomCenter,
                onSkip: () => controller.skip(),
                onNext: () {
                  controller.next();
                  setState(() => currentStep += 1);
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: 'drawer-key',
        keyTarget: _drawerKey,
        enableTargetTab: false,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return guideCard(
                currentStep: currentStep,
                heading: 'Sidebar',
                description: 'After joining a barangay, you can access your sidebar navigation links here.',
                tailPosition: TailPosition.topLeft,
                onSkip: () => controller.skip(),
                onNext: () {
                  controller.next();
                  setState(() => currentStep += 1);
                },
                onPrev: () {
                  controller.previous();
                  setState(() => currentStep -= 1);
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: 'card-announcement-key',
        keyTarget: _cardAnnouncementsKey,
        shape: ShapeLightFocus.RRect,
        enableTargetTab: false,
        radius: 20,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return guideCard(
                currentStep: currentStep,
                heading: 'Recent Announcements',
                description: 'Here are your recent announcements from your barangay sphere.',
                tailPosition: TailPosition.topCenter,
                onSkip: () => controller.skip(),
                onNext: () {
                  controller.next();
                  setState(() => currentStep += 1);
                },
                onPrev: () {
                  controller.previous();
                  setState(() => currentStep -= 1);
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: 'card-sphere-key',
        keyTarget: _cardSphereKey,
        shape: ShapeLightFocus.RRect,
        enableTargetTab: false,
        radius: 20,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return guideCard(
                currentStep: currentStep,
                heading: 'Joined Barangay',
                description: 'Here is the barangay sphere that you\'ve joined!',
                tailPosition: TailPosition.bottomCenter,
                onNext: () {
                  controller.skip();
                  Navigator.of(context).pushReplacement(createRoute(route: Routes.dashboard));
                },
                onPrev: () {
                  controller.previous();
                  setState(() => currentStep -= 1);
                },
              );
            },
          )
        ],
      ),
    ];
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      _initTarget();
      tutorialCoachMark = TutorialCoachMark(
        targets: _targets,
        hideSkip: true,
      )..show(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EBAppBar(drawerKey: _drawerKey),
      drawer: const EBDrawer(),
      body: (currentStep < 3)
          ? FadeIn(child: buildEmptyDashboard())
          : FadeIn(
              child: buildDashboard(
                cardAnnouncementsKey: _cardAnnouncementsKey,
                cardSphereKey: _cardSphereKey,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        key: _joinBtnKey,
        onPressed: () {},
        child: const Icon(FeatherIcons.plus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const EBAppBarBottom(activeIndex: 1),
    );
  }
}
