library rate_input;
import 'dart:html' hide Timeline;
import 'package:basic_input/formatting.dart';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';

final _logger = new Logger("rateInput");

@CustomTag("plus-rate-input")
class RateInput extends PolymerElement {

  num get rate => _rate;

  RateInput.created() : super.created() {
    _logger.fine('RateInput created sr => $shadowRoot');
  }

  void domReady() {
    super.domReady();
    _logger.fine('RateInput domReady with sr => $shadowRoot');
  }

  void ready() {
    super.ready();
    _logger.fine('RateInput ready with sr => $shadowRoot');
  }

  void attached() {
    super.attached();
    _logger.fine('RateInput attached with sr => $shadowRoot');
    assert(shadowRoot != null);
    _rateElement = $['rate'] // shadowRoot.querySelector('#rate')
      ..onBlur.listen((evt) => reformatRate())
      ..onFocus.listen((evt) => reformatRate())
      ..onKeyUp.listen((evt) { if(evt.which == 13) reformatRate(); });
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
