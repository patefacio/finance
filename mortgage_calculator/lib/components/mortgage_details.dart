library mortgage_details;
import 'dart:html' hide Timeline;
import 'package:basic_input/components/money_input.dart';
import 'package:basic_input/components/num_with_units_input.dart';
import 'package:basic_input/components/rate_input.dart';
import 'package:basic_input/formatting.dart';
import 'package:logging/logging.dart';
import 'package:mortgage_calculator/mortgage.dart';
import 'package:polymer/polymer.dart';

final _logger = new Logger("mortgageDetails");

@CustomTag("plus-mortgage-details")
class MortgageDetails extends PolymerElement {

  NumWithUnitsInput termYearsInput;
  MoneyInput mortgageAmountInput;
  RateInput rateInput;
  @observable num payment;
  @observable String formattedPayment;

  MortgageDetails.created() : super.created() {
    // custom <MortgageDetails created>

    if(null == shadowRoot) return;

    (mortgageAmountInput = $["mortgage-amount"] as MoneyInput)
      ..label = r" $ Amount of Loan"
      ..onBlur.listen((_) => recalc())
      ..onFocus.listen((_) => recalc());

    (rateInput = $["rate"] as RateInput)
      ..label = " Rate (%)"
      ..onBlur.listen((_) => recalc())
      ..onFocus.listen((_) => recalc());

    (termYearsInput = $["term-years"] as NumWithUnitsInput)
      ..label = " Term (years)"
      ..units = "years"
      ..onBlur.listen((_) => recalc())
      ..onFocus.listen((_) => recalc());

    mortgageAmountInput.onUpdate(recalc);
    rateInput.onUpdate(recalc);
    termYearsInput.onUpdate(recalc);

    recalc();

    // end <MortgageDetails created>
  }

  // custom <class MortgageDetails>

  num get mortgageAmount => mortgageAmountInput.amount;
  num get termYears => termYearsInput.number;
  num get rate => rateInput.rate;

  set mortgageAmount(num amt) => mortgageAmountInput.amount = amt;
  set termYears(num term) => termYearsInput.number = term;
  set rate(num rate) => rateInput.rate = rate;

  void recalc() {
    var calculated = _payment;
    formattedPayment = moneyFormat(_payment);
    if(_payment != 0.0) {
      payment = _payment;
    }
  }

  num get _payment {
    if(null != mortgageAmountInput) {
      num amount = mortgageAmountInput.amount;
      num years = termYearsInput.number;
      num rate = rateInput.rate;
      if(rate == null || rate == 0 || years == null || years == 0) {
        return 0;
      }
      return mortgagePayment(amount, rate, years);
    }
    return 0;
  }


  // end <class MortgageDetails>
}




// custom <mortgage_details>
// end <mortgage_details>
