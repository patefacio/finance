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
    // custom <MortgageCalculator created>

    if(shadowRoot != null) {
      mortgageDetails = ($['details'] as MortgageDetails);
      paymentSchedule = ($['schedule'] as PaymentSchedule);

      mortgageDetails.changes.listen((records) {
        if(records.any((record) => record.name == #payment))
            updatePaymentSchedule();
      });

      mortgageDetails.mortgageAmount = 250000;
      mortgageDetails.termYears = 30;
      mortgageDetails.rate = 0.0525;
      updatePaymentSchedule();
    }

    // end <MortgageCalculator created>
  }

  // custom <class MortgageCalculator>

  void updatePaymentSchedule() {
    var rate = mortgageDetails.rate;
    var term = mortgageDetails.termYears;
    if(rate != null && term != null) {
      paymentSchedule.paymentDetails
        (new MortgageSpec(mortgageDetails.mortgageAmount,
            rate, term));
    }
  }

  // end <class MortgageCalculator>
}




// custom <mortgage_calculator>
// end <mortgage_calculator>
