import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import '../steps/register.dart';


Future<void> main() {
  final config = FlutterTestConfiguration()
    ..defaultTimeout = const Duration(seconds: 50)
    ..features = [Glob(r"test/acceptanceTests/features/register.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './test_report.json')
    ]
    ..stepDefinitions = [
      CheckCreateAccountPage(),
      FillCatnameBox(),
      FillREmailBox(),
      FillRPasswordBox(),
      FillConfirmPasswordBox(),
      ClicksRegisterButton(),
      GoToExplorePage(),
    ]
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test/acceptanceTests/acceptanceTests.dart";

  return GherkinRunner().execute(config);
}