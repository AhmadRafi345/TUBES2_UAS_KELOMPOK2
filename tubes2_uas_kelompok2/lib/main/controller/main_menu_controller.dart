import 'package:cat_app/features/home/home_screen.dart';
import 'package:get/get.dart';

import '.../.../favorite/favorite_screen.dart';
import '.../.../vote/vote_screen.dart';

class MainMenuController extends GetxController {
  var currentIndex = 0.obs;

  // Daftar halaman untuk BottomNavigationBar
  final List pages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const VoteScreen(),
  ];

  // Fungsi untuk mengganti halaman
  void changePage(int index) {
    currentIndex.value = index;
  }
}
