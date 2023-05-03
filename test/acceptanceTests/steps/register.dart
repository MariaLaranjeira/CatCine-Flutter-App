import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CheckCreateAccountPage extends Given5WithWorld<String, String, String, String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String catnameBox, String emailBox, String passwordBox, String confirmPasswordBox, String registerButton) async {
    final catname = find.byValueKey(catnameBox);
    final email = find.byValueKey(emailBox);
    final password = find.byValueKey(passwordBox);
    final confirmPassword = find.byValueKey(confirmPasswordBox);
    final register = find.byValueKey(registerButton);

    await FlutterDriverUtils.isPresent(world.driver, catname);
    await FlutterDriverUtils.isPresent(world.driver, email);
    await FlutterDriverUtils.isPresent(world.driver, password);
    await FlutterDriverUtils.isPresent(world.driver, confirmPassword);
    await FlutterDriverUtils.isPresent(world.driver, register);
  }

  @override
  RegExp get pattern => RegExp(r"there is a {string}, an {string}, a {string}, a {string}, and a {string}");
}

class FillCatnameBox extends When2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String field1, String field2) async {
    await FlutterDriverUtils.enterText(world.driver,
        find.byValueKey(field1), field2);
  }

  @override
  RegExp get pattern => RegExp(r"the user fills the {string} with {string}");
}

class FillREmailBox extends And2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String field1, String field2) async {
    await FlutterDriverUtils.enterText(world.driver,
        find.byValueKey(field1), field2);
  }

  @override
  RegExp get pattern => RegExp(r"the user fills the {string} with {string}");
}

class FillRPasswordBox extends And2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String field1, String field2) async {
    await FlutterDriverUtils.enterText(world.driver,
        find.byValueKey(field1), field2);
  }

  @override
  RegExp get pattern => RegExp(r"the user fills the {string} with {string}");
}

class FillConfirmPasswordBox extends And2WithWorld<String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String field1, String field2) async {
    await FlutterDriverUtils.enterText(world.driver,
        find.byValueKey(field1), field2);
  }

  @override
  RegExp get pattern => RegExp(r"the user fills the {string} with {string}");
}

class ClicksRegisterButton extends And1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String registerButton) async {
    final register = find.byValueKey(registerButton);
    await FlutterDriverUtils.tap(world.driver, register);
  }

  @override
  RegExp get pattern => RegExp(r"the user fills the {string} with {string}");
}

class GoToExplorePage extends Then1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String catnameBox) async {
    final box = find.byValueKey(catnameBox);
    await FlutterDriverUtils.isPresent(world.driver, box);
  }

  @override
  RegExp get pattern => RegExp(r"I expect the {string} to be present");
}
