library mortgage_details;
import 'dart:html' hide Timeline;
import 'package:basic_input/components/money_input.dart';
import 'package:basic_input/components/num_with_units_input.dart';
import 'package:basic_input/components/rate_input.dart';
import 'package:basic_input/formatting.dart';
import 'package:logging/logging.dart';
import 'package:mortgage_calculator/mortgage.dart';
import 'package:polymer/polymer.dart';

// custom <additional imports>
// end <additional imports>


final _logger = new Logger("mortgageDetails");

@CustomTag("plus-mortgage-details")
class MortgageDetails extends PolymerElement {

  NumWithUnitsInput termYearsInput;
  MoneyInput mortgageAmountInput;
  RateInput rateInput;
  @observable num payment;
  @observable String formattedPayment;

  MortgageDetails.created() : super.created() {
    _logger.fine('MortgageDetails created sr => $shadowRoot');
    // custom <MortgageDetails created>
    // end <MortgageDetails created>

  }

  @override
  void domReady() {
    super.domReady();
    _logger.fine('MortgageDetails domReady with sr => $shadowRoot');
    // custom <MortgageDetails domReady>

    mortgageAmountInput.placeholder = r" $ Amount of Loan";
    rateInput.placeholder = " Rate (%)";
    termYearsInput
      ..placeholder = " Term (years)"
      ..units = "years";

    recalc();

    // end <MortgageDetails domReady>

  }

  @override
  void ready() {
    super.ready();
    _logger.fine('MortgageDetails ready with sr => $shadowRoot');
    // custom <MortgageDetails ready>
    // end <MortgageDetails ready>

  }

  @override
  void attached() {
    // custom <MortgageDetails pre-attached>
    // end <MortgageDetails pre-attached>

    super.attached();
    _logger.fine('MortgageDetails attached with sr => $shadowRoot');
    assert(shadowRoot != null);
    // custom <MortgageDetails attached>

    (mortgageAmountInput = $["mortgage-amount"] as MoneyInput)
      ..onBlur.listen((_) => recalc())
      ..onFocus.listen((_) => recalc());

    (rateInput = $["rate"] as RateInput)
      ..onBlur.listen((_) => recalc())
      ..onFocus.listen((_) => recalc());

    (termYearsInput = $["term-years"] as NumWithUnitsInput)
      ..onBlur.listen((_) => recalc())
      ..onFocus.listen((_) => recalc());

    mortgageAmountInput.onAttached((x) => x.onUpdate((_) => recalc()));
    rateInput.onAttached((x) => x.onUpdate((_) => recalc()));
    termYearsInput.onAttached((x) => x.onUpdate((_) => recalc()));

    // end <MortgageDetails attached>

    _isAttached = true;
    _onAttachedHandlers.forEach((handler) => handler(this));
  }

  void onAttached(void onAttachedHandler(MortgageDetails)) {
    if(_isAttached) {
      onAttachedHandler(this);
    } else {
      _onAttachedHandlers.add(onAttachedHandler);
    }
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
    formattedPayment = moneyFormat(calculated);
    if (calculated != 0.0) {
      payment = calculated;
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
  bool _isAttached = false;
  List _onAttachedHandlers = [];
}




// custom <mortgage_details>
// end <mortgage_details>
