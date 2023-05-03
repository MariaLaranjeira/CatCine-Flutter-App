import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import '../steps/mainBar.dart';


Future<void> main() {
  final config = FlutterTestConfiguration()
    ..defaultTimeout = const Duration(seconds: 50)
    ..features = [Glob(r"test/acceptanceTests/features/mainBar.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './test_report.json')
    ]
    ..stepDefinitions = [
      CheckAllBarButtons(),
      ExploreTap(),
      goExplorePage()
    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test/acceptanceTests/acceptanceTests.dart";

  return GherkinRunner().execute(config);
}