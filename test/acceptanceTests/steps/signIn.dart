import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CheckAllSignInBoxes extends Given3WithWorld<String, String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String emailBox, String passwordBox, String signInButton) async {

    final email = find.byValueKey(emailBox);
    final pass = find.byValueKey(passwordBox);
    final signIn = find.byValueKey(signInButton);

    await FlutterDriverUtils.isPresent(world.driver, email);
    await FlutterDriverUtils.isPresent(world.driver, pass);
    await FlutterDriverUtils.isPresent(world.driver, signIn);

  }

  @override
  RegExp get pattern => RegExp(r"there is a {string} field, a {string} field and a {string} button");
}

class FillEmailBox extends When2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String emailBox, String theEmail) async {
    await FlutterDriverUtils.enterText(
        world.driver, find.byValueKey(emailBox), theEmail);
  }

  @override
  RegExp get pattern => RegExp(r"the user fills the {string} with {string}");

}

class FillPasswordBox extends When2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String passwordBox, String thePass) async {
    await FlutterDriverUtils.enterText(
        world.driver, find.byValueKey(passwordBox), thePass);
  }

  @override
  RegExp get pattern => RegExp(r"the user fills the {string} with {string}");

}

class ClickSignIn extends And1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String signInButton) async {
    final signIn = find.byValueKey(signInButton);
    await FlutterDriverUtils.tap(world.driver, signIn);
  }

  @override
  RegExp get pattern => RegExp(r"the user clicks the {string} button");
}

class ExplorePage extends Then1WithWorld<String, FlutterWorld>{
  @override
  Future<void> executeStep(String exploreField) async {
    final explore = find.byValueKey(exploreField);
    await FlutterDriverUtils.isPresent(world.driver, explore);
  }

  @override

  RegExp get pattern => RegExp(r"it is expected the field {string} to be present");

}




