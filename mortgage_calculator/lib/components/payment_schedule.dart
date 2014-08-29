library payment_schedule;
import 'dart:html' hide Timeline;
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
  }

  update(observer){
    _startDateInput.onUpdate(observer);    
  }
  
  void attached() {
    super.attached();
    _startDateInput = $["date"] as DateInput;
    _scheduleTable = $['schedule_table'];
  }


  void domReady() {
    _startDateInput.label = "yyyy-MM-dd";
    _startDateInput.date = new DateTime.now();
    update(paymentDetails);
  }

  setTableExtras(num principal, num interest) {
    final tHead = new Element.tag('thead')
      ..innerHtml = '''
<td>Date</td>
<td>Principal Paid</td>
<td>Interest Paid</td>
<td>Balance</td>
''';

    final tFoot = new Element.tag('tfoot')
      ..innerHtml = '''
<td>Total Paid</td>
<td class="money">${moneyFormat(principal)}</td>
<td class="money">${moneyFormat(interest)}</td>
<td class="money">${moneyFormat(principal + interest)}</td>'''
      ..children.first.classes.add('table-line');

    _scheduleTable.children
      ..removeWhere((child) => child is TableSectionElement);

    _scheduleTable.children
      ..insert(0, tHead)
      ..add(tFoot);
  }

  bool paymentDetails([MortgageSpec mortgageSpec]) {
    if (mortgageSpec != null) {
      _mortgageSpec = mortgageSpec;
    }
    if (_mortgageSpec == null) return null;

    int originalLength = _scheduleTable.rows.length;
    for (int i = 0; i < originalLength; ++i) {
      _scheduleTable.deleteRow(0);
    }

    var payments = _mortgageSpec.paymentSchedule(_startDateInput.date);
    num totalPrincipal = 0.0;
    num totalInterest = 0.0;

    payments.forEach((payment) {
      //print("ScheduleTable => $_scheduleTable");
      var row = new TableRowElement();
      _scheduleTable.children.add(row);

      row.children.add(new TableCellElement()
        ..innerHtml = dateFormat(payment.date));

      var cell = (row.children
        ..add(new TableCellElement())).last;

      cell
        ..innerHtml = moneyFormat(payment.periodPrincipalPaid, true)
        ..classes.add('money');
      (row.children
        ..add(new TableCellElement())).last
        ..innerHtml = moneyFormat(payment.periodInterestPaid, true)
        ..classes.add('money');
      (row.children
        ..add(new TableCellElement())).last
        ..innerHtml = moneyFormat(payment.remainingPrincipal, true)
        ..classes.add('money');
      totalPrincipal += payment.periodPrincipalPaid;
      totalInterest += payment.periodInterestPaid;
    });
    setTableExtras(totalPrincipal, totalInterest);
    return true;
  }

  // end <class PaymentSchedule>
  DateInput _startDateInput;
  TableElement _scheduleTable;
  MortgageSpec _mortgageSpec;
}


// custom <payment_schedule>
// end <payment_schedule>
