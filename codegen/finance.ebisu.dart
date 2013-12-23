import "dart:io";
import "package:id/id.dart";
import "package:path/path.dart";
import "package:ebisu/ebisu_dart_meta.dart";
import "package:ebisu_web_ui/ebisu_web_ui.dart";
import "package:plus/paths.dart";

main() {
  String here = join(plusPath('open_source'), 'components');

  ComponentLibrary lib =
    componentLibrary('finance')
    ..system.includeReadme = true
    ..system.license = 'boost'
    ..system.introduction = 'In the long-run a collection of financial components. First component is a basic mortgage calculator.'
    ..pubSpec.addDependency(pubdep('collection_helpers')..version =  ">=0.9.0 < 0.10.0")
    ..prefix = 'plus'
    ..rootPath = here
    ..examples = [
      example(idFromString('mortgage_calculator')),
    ]
    ..libraries = [
    library('formatting')
    ..imports = [ 'package:intl/intl.dart' ],
    library('mortgage')
    ..classes = [
    class_('mortgage_spec')
    ..members = [
    member('principal')..type = 'num'..ctors = [''],
    member('rate')..type = 'num'..ctors = [''],
    member('term')..type = 'num'..ctors = [''],
    ],
    class_('mortgage_paydown_record')
    ..members = [
    member('date')..type = 'DateTime',
    member('period_interest_paid')..type = 'num',
    member('period_principal_paid')..type = 'num',
    member('remaining_principal')..type = 'num',
    ]
    ]
    ]
    ..components = [
      component('money_input')
      ..imports = [
        'package:finance/formatting.dart',
      ]
      ..implClass = (class_('money_input')
          ..defaultMemberAccess = IA
          ..members = [
            member('amount')..access = RO..classInit = 0..type = 'num',
            member('amount_element')..access = IA..type = 'InputElement',
          ]),
      component('rate_input')
      ..imports = [
        'package:finance/formatting.dart',
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
        'package:finance/formatting.dart',
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
        'package:finance/formatting.dart',
      ]
      ..implClass = (class_('date_input')
          ..members = [
            member('date_element')..access = IA..type = 'InputElement',
            member('date')..access = RO..type = 'DateTime',
          ]),

      component('year_input')
      ..imports = [
        'package:finance/formatting.dart',
      ]
      ..implClass = (class_('year_input')
          ..members = [
            member('year_element')..access = IA..type = 'InputElement',
            member('year')..access = RO..type = 'int',
          ]),
      component('mortgage_calculator')
      ..imports = [
        'package:finance/mortgage.dart',
        'package:finance/components/mortgage_details.dart',
        'package:finance/components/payment_schedule.dart',
      ]
      ..implClass = (class_('mortgage_calculator')
          ..members = [
            member('mortgage_details')..type = 'MortgageDetails',
            member('payment_schedule')..type = 'PaymentSchedule',
          ]),
      component('mortgage_details')
      ..imports = [
        'package:finance/formatting.dart',
        'package:finance/mortgage.dart',
        'package:finance/components/money_input.dart',
        'package:finance/components/rate_input.dart',
        'package:finance/components/num_with_units_input.dart'
      ]
      ..implClass = (class_('mortgage_details')
          ..members = [
            member('term_years_input')..type = 'NumWithUnitsInput',
            member('mortgage_amount_input')..type = 'MoneyInput',
            member('rate_input')..type = 'RateInput',
            member('payment')..type='num'..isObservable = true,
            member('formatted_payment')..isObservable = true,
          ]),
      component('payment_schedule')
      ..imports = [
        'package:finance/components/date_input.dart',
        'package:finance/mortgage.dart',
        'package:finance/formatting.dart',
        'html',
      ]
      ..implClass = (class_('payment_schedule')
          ..defaultMemberAccess = IA
          ..members = [
            member('start_date_input')..type = 'DateInput',
            member('schedule_table')..type = 'TableElement',
            member('mortgage_spec')..type = 'MortgageSpec',
          ]),
    ];


  lib.generate();
}