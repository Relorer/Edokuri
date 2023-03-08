import "package:dart_pre_commit/dart_pre_commit.dart";
import "package:git_hooks/git_hooks.dart";

void main(List<String> arguments) {
  final params = {Git.preCommit: _preCommit};
  GitHooks.call(arguments, params);
}

Future<bool> _preCommit() async {
  final result = await DartPreCommit.run();
  return result.isSuccess;
}
