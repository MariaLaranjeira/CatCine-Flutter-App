import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CheckSignInButton extends Given1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String signInButton) async {
    final signIn = find.byValueKey(signInButton);
    await FlutterDriverUtils.isPresent(world.driver, signIn);
  }

  @override
  RegExp get pattern => RegExp(r"there is a {string} button");
}

class ClickSignInButton extends And1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String signInButton) async {
    final signIn = find.byValueKey(signInButton);
    await FlutterDriverUtils.tap(world.driver, signIn);
  }

  @override
  RegExp get pattern => RegExp(r"an user clicks the {string} button");
}

class CheckAllBoxes extends Given3WithWorld<String, String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String input1, String input2, String input3) async {
    final emailBox = find.byValueKey(input1);
    final passwordBox = find.byValueKey(input2);
    final signInButton = find.byValueKey(input3);
    await FlutterDriverUtils.isPresent(world.driver, emailBox);
    await FlutterDriverUtils.isPresent(world.driver, passwordBox);
    await FlutterDriverUtils.isPresent(world.driver, signInButton);
  }

  @override
  RegExp get pattern => RegExp(r"there is an {string}, a {string} and a {string}");
}

class FillEmailPassBoxes extends When2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String field1, String field2) async {
    await FlutterDriverUtils.enterText(world.driver, find.byValueKey(field1), field2);
  }

  @override
  RegExp get pattern => RegExp(r"the user fills the {string} with {string}");
}

class ClickToSignIn extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String signInButton) async {
    final signIn = find.byValueKey(signInButton);
    await FlutterDriverUtils.tap(world.driver, signIn);
  }

  @override
  RegExp get pattern => RegExp(r"the user clicks the {string}");
}