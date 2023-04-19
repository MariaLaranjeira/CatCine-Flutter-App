import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';

import 'steps/signedIn.dart';


Future<void> main() {
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test/acceptanceTests/features/signIn.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './test_report.json')
    ]
    ..stepDefinitions = [ClickSignInButton(), CheckAllBoxes(), FillEmailPassBoxes(), ClickToSignIn()]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test/app.dart";
  return GherkinRunner().execute(config);
}