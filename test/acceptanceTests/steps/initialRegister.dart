import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CheckRegisterButton extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String registerButton) async {
    final register = find.byValueKey(registerButton);
    await FlutterDriverUtils.isPresent(world.driver, register);
  }

  @override
  RegExp get pattern => RegExp(r"there is a {string} button");
}

class ClickRegisterButton extends And1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String registerButton) async {
    final register = find.byValueKey(registerButton);
    await FlutterDriverUtils.tap(world.driver, register);
  }

  @override
  RegExp get pattern => RegExp(r"an user clicks the {string} button");
}

class GoToRegisterPage extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String catnameBox) async {
    final box = find.byValueKey(catnameBox);
    await FlutterDriverUtils.isPresent(world.driver, box);
  }

  @override
  RegExp get pattern => RegExp(r"I expect the {string} to be present");
}
