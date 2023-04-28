import 'dart:async';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'package:glob/glob.dart';
import 'steps/signedIn.dart';


Future<void> main() {
  final config = FlutterTestConfiguration()
    ..defaultTimeout = const Duration(seconds: 50)
    ..features = [Glob(r"test/acceptanceTests/features/signIn.feature")]
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './test_report.json')
    ]
    ..stepDefinitions = [ CheckSignInButton(), ClickSignInButton(), CheckAllBoxes(), FillEmailPassBoxes(), ClickToSignIn()]
    ..customStepParameterDefinitions = []
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test/acceptanceTests/runAcceptanceTests.dart";

  return GherkinRunner().execute(config);
}