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

class ClickToSignIn extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String signInButton) async {
    final signIn = find.byValueKey(signInButton);
    await FlutterDriverUtils.tap(world.driver, signIn);
  }

  @override
  RegExp get pattern => RegExp(r"the user taps the {string} button");
}

class SignInPage extends Then1WithWorld<String, FlutterWorld>{
  @override
  Future<void> executeStep(String emailField) async {
    final email = find.byValueKey(emailField);
    await FlutterDriverUtils.isPresent(world.driver, email);
  }

  @override

  RegExp get pattern => RegExp(r"it is expected the field {string} to be present");

}