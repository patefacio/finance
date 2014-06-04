library num_with_units_input;
import 'dart:html' hide Timeline;
import 'package:basic_input/formatting.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';

final _logger = new Logger("numWithUnitsInput");

@CustomTag("plus-num-with-units-input")
class NumWithUnitsInput extends PolymerElement {

  String units;
  num get number => _number;

  NumWithUnitsInput.created() : super.created() {
    // custom <NumWithUnitsInput created>

    if(shadowRoot == null) return;

    _valueElement = shadowRoot.querySelector('#value')
      ..onBlur.listen((evt) => reformatNumber())
      ..onFocus.listen((evt) => reformatNumber())
      ..onKeyUp.listen((evt) { if(evt.which == 13) reformatNumber(); });

    // end <NumWithUnitsInput created>
  }

  // custom <class NumWithUnitsInput>

  set label(String s) => _valueElement.placeholder = s;

  reformatNumber() => number = pullNum(_valueElement.value);

  set number(num number) {
    if(_numberFormat == null) {
      _numberFormat = new NumberFormat.decimalPattern("en");
    }
    if(_number != number) {
      _valueElement.value = "${_numberFormat.format(number)} $units";
      notifyPropertyChange(#number, _number, number);
      _number = number;
    }
  }

  onUpdate(observer) =>
    changes.listen((records) {
      if(records.any((record) => record.name == #number))
        observer();
    });


  // end <class NumWithUnitsInput>
  InputElement _valueElement;
  NumberFormat _numberFormat;
  num _number;
}




// custom <num_with_units_input>
// end <num_with_units_input>
