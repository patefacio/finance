library mortgage_details;
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
  }

  @override
  void attached() {
    super.attached();
    (mortgageAmountInput = $["mortgage-amount"] as MoneyInput)
      ..onBlur.listen((_) => recalc())
      ..onFocus.listen((_) => recalc());

    (rateInput = $["rate"] as RateInput)
      ..onBlur.listen((_) => recalc())
      ..onFocus.listen((_) => recalc());

    (termYearsInput = $["term-years"] as NumWithUnitsInput)
      ..onBlur.listen((_) => recalc())
      ..onFocus.listen((_) => recalc());

    mortgageAmountInput.onUpdate(recalc);
    rateInput.onUpdate(recalc);
    termYearsInput.onUpdate(recalc);
  }


  void domReady() {
    mortgageAmountInput.label = r" $ Amount of Loan";
    rateInput.label = " Rate (%)";
    termYearsInput
      ..label = " Term (years)"
      ..units = "years";

    recalc();
  }

  num get mortgageAmount => mortgageAmountInput.amount;

  num get termYears => termYearsInput.number;

  num get rate => rateInput.rate;

  set mortgageAmount(num amt) => mortgageAmountInput.amount = amt;

  set termYears(num term) => termYearsInput.number = term;

  set rate(num rate) => rateInput.rate = rate;

  void recalc() {
    var calculated = _payment;
    formattedPayment = moneyFormat(_payment);
    if (_payment != 0.0) {
      payment = _payment;
    }
  }

  num get _payment {
    if (null != mortgageAmountInput) {
      num amount = mortgageAmountInput.amount;
      num years = termYearsInput.number;
      num rate = rateInput.rate;
      if (rate == null || rate == 0 || years == null || years == 0) {
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
