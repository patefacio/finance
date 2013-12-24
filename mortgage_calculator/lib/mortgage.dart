library mortgage;

// custom <additional imports>

import 'dart:math';

// end <additional imports>


class MortgageSpec {

  MortgageSpec(this.principal, this.rate, this.term);

  num principal;
  num rate;
  num term;

  // custom <class MortgageSpec>

  num get payment =>
    mortgagePayment(principal, rate, term);

  List<MortgagePaydownRecord> paymentSchedule(DateTime startDate) {
    if(rate <=0 || term <=0) return [];
    var pmt = payment;
    var monthlyRate = rate/12.0;
    var months = (12*term).ceil();
    var result = new List<MortgagePaydownRecord>(months);
    var remainingPrincipal = principal;

    for(int i=0; i<months && remainingPrincipal>0; i++) {
      startDate = new DateTime(startDate.year,
          startDate.month + 1, startDate.day);
      var periodInterestPaid = remainingPrincipal * monthlyRate;
      var principalPaid = pmt - periodInterestPaid;
      remainingPrincipal -= principalPaid;
      result[i] = new MortgagePaydownRecord()
        ..date = startDate
        ..periodInterestPaid = periodInterestPaid
        ..periodPrincipalPaid = principalPaid
        ..remainingPrincipal = remainingPrincipal;
    }
    return result;
  }

  String toString() => '''
Principal: $principal
Rate: $rate
Term: $term
''';

  // end <class MortgageSpec>
}

class MortgagePaydownRecord {
  DateTime date;
  num periodInterestPaid;
  num periodPrincipalPaid;
  num remainingPrincipal;

  // custom <class MortgagePaydownRecord>

  String toString() => '''
Date: $date
Interest Paid: $periodInterestPaid
Principal Paid: $periodPrincipalPaid
Remaining Principal: $remainingPrincipal
''';

  // end <class MortgagePaydownRecord>
}

// custom <library mortgage>

double mortgagePayment(principal, rate, years) {
  var monthlyRate = rate/12.0;
  var months = 12.0*years;
  return principal*(monthlyRate/(1.0 - pow(1.0 + monthlyRate, -months)));
}

// end <library mortgage>
