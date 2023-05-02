import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class CheckAllBarButtons extends Given5WithWorld<String, String, String, String, String, FlutterWorld> {
  @override
  Future<void> executeStep(String homeButton, String profileButton, String createCategoryButton, String exploreButton, String exploreCategoryButton) async {

    final home = find.byValueKey(homeButton);
    final profile = find.byValueKey(profileButton);
    final createCat = find.byValueKey(createCategoryButton);
    final explore = find.byValueKey(exploreButton);
    final exploreCat = find.byValueKey(exploreCategoryButton);

    await FlutterDriverUtils.isPresent(world.driver, home);
    await FlutterDriverUtils.isPresent(world.driver, profile);
    await FlutterDriverUtils.isPresent(world.driver, createCat);
    await FlutterDriverUtils.isPresent(world.driver, explore);
    await FlutterDriverUtils.isPresent(world.driver, exploreCat);

  }

  @override
  RegExp get pattern => RegExp(r"there is a {string} button, a {string} button, a {string} button, a {string} button and a {string} button");

}

class ExploreTap extends When1WithWorld<String,FlutterWorld>{
  @override
  Future<void> executeStep(String exploreButton) async {
    final explore = find.byValueKey(exploreButton);
    await FlutterDriverUtils.tap(world.driver, explore);
  }

  @override
  RegExp get pattern => RegExp(r"the user taps the {string}");

}

class goExplorePage extends Then1WithWorld<String, FlutterWorld>{
  @override
  Future<void> executeStep(String exploreField) async {
    final explore = find.byValueKey(exploreField);
    await FlutterDriverUtils.isPresent(world.driver, explore);
  }

  @override
  RegExp get pattern => RegExp(r"it is expected the field {string} to be present");

}