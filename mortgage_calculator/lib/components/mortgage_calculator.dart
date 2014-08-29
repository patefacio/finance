library mortgage_calculator;
import 'dart:html' hide Timeline;
import 'package:logging/logging.dart';
import 'package:mortgage_calculator/components/mortgage_details.dart';
import 'package:mortgage_calculator/components/payment_schedule.dart';
import 'package:mortgage_calculator/mortgage.dart';
import 'package:polymer/polymer.dart';

final _logger = new Logger("mortgageCalculator");

@CustomTag("plus-mortgage-calculator")
class MortgageCalculator extends PolymerElement {

  MortgageDetails mortgageDetails;
  PaymentSchedule paymentSchedule;

  MortgageCalculator.created() : super.created() {
    _logger.fine('MortgageCalculator created sr => $shadowRoot');
  }

  @override
  void domReady() {
    super.domReady();
    _logger.fine('MortgageCalculator domReady with sr => $shadowRoot');
    // custom <MortgageCalculator domReady>
    mortgageDetails.mortgageAmount = 250000;
    mortgageDetails.termYears = 30;
    mortgageDetails.rate = 0.0525;
    updatePaymentSchedule();
    // end <MortgageCalculator domReady>

  }

  @override
  void ready() {
    super.ready();
    _logger.fine('MortgageCalculator ready with sr => $shadowRoot');
    // custom <MortgageCalculator created>
    // end <MortgageCalculator created>

    // custom <MortgageCalculator ready>
    // end <MortgageCalculator ready>

  }

  @override
  void attached() {
    super.attached();
    _logger.fine('MortgageCalculator attached with sr => $shadowRoot');
    assert(shadowRoot != null);
    // custom <MortgageCalculator attached>

    mortgageDetails = ($['details'] as MortgageDetails);
    paymentSchedule = ($['schedule'] as PaymentSchedule);
    mortgageDetails.changes.listen((records) {
      if (records.any((record) => record.name == #payment))updatePaymentSchedule();
    });

    // end <MortgageCalculator attached>

  }



  // custom <class MortgageCalculator>

  void updatePaymentSchedule() {
    var rate = mortgageDetails.rate;
    var term = mortgageDetails.termYears;
    if (rate != null && term != null) {
      paymentSchedule.paymentDetails(new MortgageSpec(mortgageDetails.mortgageAmount, rate, term));
    }
  }

// end <class MortgageCalculator>
}




// custom <mortgage_calculator>
// end <mortgage_calculator>
