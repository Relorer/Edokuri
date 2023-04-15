start:
	make prepare
	flutter run

prepare:
	flutter clean
	flutter pub get
	make generate
	make localization

generatewatch:
	flutter pub run build_runner watch --use-polling-watcher

generate:
	flutter pub run build_runner build --delete-conflicting-outputs

localization:
	flutter pub run easy_localization:generate -S "assets/translations"
	flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart -S "assets/translations"

format:
	make import
	dart format .
	dart fix --apply

import:
	flutter pub run import_sorter:main
