import "package:dart_pre_commit/dart_pre_commit.dart";
import "package:git_hooks/git_hooks.dart";
import "package:process_run/shell_run.dart";

final shell = Shell();

void main(List<String> arguments) {
  final params = {Git.preCommit: _preCommit};
  GitHooks.call(arguments, params);
}

Future<bool> _preCommit() async {
  await shell.run('''
    flutter pub run build_runner build --delete-conflicting-outputs
    flutter pub run import_sorter:main
    dart format .
    dart fix --apply
  ''');

  final result = await DartPreCommit.run();
  return result.isSuccess;
}
