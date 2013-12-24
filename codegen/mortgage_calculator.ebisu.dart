import "dart:io";
import "package:id/id.dart";
import "package:path/path.dart";
import "package:ebisu/ebisu_dart_meta.dart";
import "package:ebisu_web_ui/ebisu_web_ui.dart";
import "package:plus/paths.dart";

main() {
  String here = join(dirname(dirname(Platform.script.path)));

  ComponentLibrary lib =
    componentLibrary('mortgage_calculator')
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
      component('mortgage_calculator')
      ..imports = [
        'package:mortgage_calculator/mortgage.dart',
        'package:mortgage_calculator/components/mortgage_details.dart',
        'package:mortgage_calculator/components/payment_schedule.dart',
      ]
      ..implClass = (class_('mortgage_calculator')
          ..members = [
            member('mortgage_details')..type = 'MortgageDetails',
            member('payment_schedule')..type = 'PaymentSchedule',
          ]),
      component('mortgage_details')
      ..imports = [
      'package:mortgage_calculator/mortgage.dart',     
      'package:basic_input/formatting.dart',
      'package:basic_input/components/money_input.dart',
      'package:basic_input/components/rate_input.dart',
      'package:basic_input/components/num_with_units_input.dart'
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
      'package:mortgage_calculator/mortgage.dart',
      'package:basic_input/components/date_input.dart',
      'package:basic_input/formatting.dart',
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