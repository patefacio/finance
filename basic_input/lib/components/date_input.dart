library date_input;
import 'dart:html' hide Timeline;
import 'package:basic_input/formatting.dart';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';

final _logger = new Logger("dateInput");

@CustomTag("plus-date-input")
class DateInput extends PolymerElement {

  DateTime get date => _date;

  DateInput.created() : super.created() {
    _logger.fine('DateInput created sr => $shadowRoot');
  }

  void domReady() {
    super.domReady();
    _logger.fine('DateInput domReady with sr => $shadowRoot');
  }

  void ready() {
    super.ready();
    _logger.fine('DateInput ready with sr => $shadowRoot');
    // custom <DateInput created>

    if(shadowRoot == null) return;

    _dateElement = shadowRoot.querySelector('#date')
      ..onBlur.listen((evt) => reformatDate())
      ..onFocus.listen((evt) => reformatDate())
      ..onKeyUp.listen((evt) { if(evt.which == 13) reformatDate(); });

    // end <DateInput created>

  }

  void attached() {
    super.attached();
    _logger.fine('DateInput attached with sr => $shadowRoot');
    assert(shadowRoot != null);
  }



  // custom <class DateInput>

  set label(String s) => _dateElement.placeholder = s;

  reformatDate() => date = pullDate(_dateElement.value);

  set date(DateTime d) {
    if(d != null && _date != d) {
      _dateElement.value = dateFormat(d);
      notifyPropertyChange(#date, _date, d);
      _date = d;
    }
  }

  onUpdate(observer) =>
    changes.listen((records) {
      if(records.any((record) => record.name == #date))
        observer();
    });

  // end <class DateInput>
  InputElement _dateElement;
  DateTime _date;
}




// custom <date_input>
// end <date_input>
