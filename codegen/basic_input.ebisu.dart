import "dart:io";
import "package:id/id.dart";
import "package:path/path.dart";
import "package:ebisu/ebisu_dart_meta.dart";
import "package:ebisu_web_ui/ebisu_web_ui.dart";
import "package:plus/paths.dart";

main() {
  String here = join(dirname(dirname(Platform.script.path)));

  ComponentLibrary lib =
    componentLibrary('basic_input')
    ..system.includeReadme = true
    ..system.license = 'boost'
    ..system.introduction = 'Common input types'
    ..pubSpec.addDependency(pubdep('collection_helpers')..version =  ">=0.9.0 < 0.10.0")
    ..prefix = 'plus'
    ..rootPath = here
    ..examples = [
      example(idFromString('basic_input')),
    ]
    ..libraries = [
      library('formatting')
      ..imports = [ 'package:intl/intl.dart' ],
    ]
    ..components = [
      component('money_input')
      ..imports = [
        'package:basic_input/formatting.dart',
      ]
      ..implClass = (class_('money_input')
          ..defaultMemberAccess = IA
          ..members = [
            member('amount')..access = RO..classInit = 0..type = 'num',
            member('amount_element')..access = IA..type = 'InputElement',
          ]),
      component('rate_input')
      ..imports = [
        'package:basic_input/formatting.dart',
      ]
      ..implClass = (class_('rate_input')
          ..defaultMemberAccess = IA
          ..members = [
            member('rate_element')..type = 'InputElement',
            member('rate')..access = RO
            ..type = 'num',
          ]),
      component('num_with_units_input')
      ..imports = [
        'package:intl/intl.dart',
        'package:basic_input/formatting.dart',
      ]
      ..implClass = (class_('num_with_units_input')
          ..defaultMemberAccess = IA
          ..members = [
            member('value_element')..type = 'InputElement',
            member('units')..access = RW,
            member('number_format')..type = 'NumberFormat',
            member('number')..access = RO..type = 'num',
          ]),
      component('date_input')
      ..imports = [
        'package:basic_input/formatting.dart',
      ]
      ..implClass = (class_('date_input')
          ..members = [
            member('date_element')..access = IA..type = 'InputElement',
            member('date')..access = RO..type = 'DateTime',
          ]),

      component('year_input')
      ..imports = [
        'package:basic_input/formatting.dart',
      ]
      ..implClass = (class_('year_input')
          ..members = [
            member('year_element')..access = IA..type = 'InputElement',
            member('year')..access = RO..type = 'int',
          ]),
    ];

  lib.generate();
}