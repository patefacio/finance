library rate_input;
import 'dart:html';
import 'package:basic_input/formatting.dart';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';

final _logger = new Logger("rateInput");

@CustomTag("plus-rate-input")
class RateInput extends PolymerElement {
  num get rate => _rate;

  RateInput.created() : super.created() {
    // custom <RateInput created>

    if(shadowRoot != null) {
      _rateElement = shadowRoot.querySelector('#rate')
        ..onBlur.listen((evt) => reformatRate())
        ..onFocus.listen((evt) => reformatRate())
        ..onKeyUp.listen((evt) { if(evt.which == 13) reformatRate(); });
    }

    // end <RateInput created>
  }

  // custom <class RateInput>

  set label(String s) => _rateElement.placeholder = s;

  reformatRate() {
    var r = pullNum(_rateElement.value);
    if(r != null) {
      rate = r/100.0;
    }
  }

  set rate(num rate) {
    if(_rate != rate) {
      _rateElement.value = percentFormat(rate);
      notifyPropertyChange(#rate, _rate, rate);
      _rate = rate;
    }
  }

  onUpdate(observer) =>
    changes.listen((records) {
      if(records.any((record) => record.name == #rate))
        observer();
    });


  // end <class RateInput>
  InputElement _rateElement;
  num _rate;
}



// custom <rate_input>
// end <rate_input>
