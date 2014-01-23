library payment_schedule;
import 'dart:html';
import 'package:basic_input/components/date_input.dart';
import 'package:basic_input/formatting.dart';
import 'package:logging/logging.dart';
import 'package:mortgage_calculator/mortgage.dart';
import 'package:polymer/polymer.dart';

final _logger = new Logger("paymentSchedule");

@CustomTag("plus-payment-schedule")
class PaymentSchedule extends PolymerElement {

  PaymentSchedule.created() : super.created() {
    // custom <PaymentSchedule created>

    if(shadowRoot != null) {
      (_startDateInput = $["date"] as DateInput)..label = "yyyy-MM-dd";
      _scheduleTable = $['schedule_table'];
      _startDateInput.date = new DateTime.now();
      onStartDateUpdate(paymentDetails);
    }

    // end <PaymentSchedule created>
  }

  // custom <class PaymentSchedule>

  onStartDateUpdate(observer) => _startDateInput.onUpdate(observer);

  bool get applyAuthorStyles => true;

  setTableExtras(num principal, num interest) {
    _scheduleTable
      ..tHead = (_scheduleTable.createTHead()..innerHtml =
          '<td>Date</td><td>Principal Paid</td><td>Interest Paid</td><td>Balance</td>')
      ..tFoot = (_scheduleTable.createTFoot()
          ..innerHtml =
          '''
<td>Total Paid</td>
<td class="money">${moneyFormat(principal)}</td>
<td class="money">${moneyFormat(interest)}</td>
<td class="money">${moneyFormat(principal + interest)}</td>'''
          ..children.first.classes.add('table-line')
                 );
  }

  bool paymentDetails([MortgageSpec mortgageSpec]) {
    if(mortgageSpec != null) {
      _mortgageSpec = mortgageSpec;
    }
    if(_mortgageSpec == null) return null;

    int originalLength = _scheduleTable.rows.length;
    for(int i=0; i<originalLength; ++i) {
      _scheduleTable.deleteRow(0);
    }

    var payments = _mortgageSpec.paymentSchedule(_startDateInput.date);
    num totalPrincipal = 0.0;
    num totalInterest = 0.0;

    payments.forEach((payment) {
      //print("ScheduleTable => $_scheduleTable");
      var row = _scheduleTable.addRow();
      row.addCell().innerHtml = dateFormat(payment.date);
      var cell = row.addCell();
      //print("Cell $cell");
      cell
        ..innerHtml = moneyFormat(payment.periodPrincipalPaid, true)
        ..classes.add('money');
      row.addCell()
        ..innerHtml = moneyFormat(payment.periodInterestPaid, true)
        ..classes.add('money');
      row.addCell()
        ..innerHtml = moneyFormat(payment.remainingPrincipal, true)
        ..classes.add('money');
      totalPrincipal += payment.periodPrincipalPaid;
      totalInterest += payment.periodInterestPaid;
    });
    setTableExtras(totalPrincipal, totalInterest);
  }

  // end <class PaymentSchedule>
  DateInput _startDateInput;
  TableElement _scheduleTable;
  MortgageSpec _mortgageSpec;
}




// custom <payment_schedule>
// end <payment_schedule>
