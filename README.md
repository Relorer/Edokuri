flutter pub run build_runner build
flutter packages pub run build_runner build

flutter pub run easy_localization:generate -S "assets/translations"
flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart -S "assets/translations"
