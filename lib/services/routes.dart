import 'package:know_karelia/about/about_page.dart';
import 'package:know_karelia/topics/topics_page.dart';
import 'package:know_karelia/profile/profile_page.dart';

var appRoutes = {
  '/topics': (context) => const TopicPage(),
  '/profile': (context) => const ProfilePage(),
  '/about': (context) => const AboutPage(),
};
