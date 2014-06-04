library year_input;
import 'dart:html' hide Timeline;
import 'package:basic_input/formatting.dart';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';

final _logger = new Logger("yearInput");

@CustomTag("plus-year-input")
class YearInput extends PolymerElement {

  int get year => _year;

  YearInput.created() : super.created() {
    // custom <YearInput created>

    if(shadowRoot == null) return;

    _yearElement = shadowRoot.querySelector('#year')
      ..onBlur.listen((evt) => reformatNumber())
      ..onFocus.listen((evt) => reformatNumber())
      ..onKeyUp.listen((evt) { if(evt.which == 13) reformatNumber(); });

    // end <YearInput created>
  }

  // custom <class YearInput>

  set label(String s) => _yearElement.placeholder = s;

  reformatNumber() => year = pullInteger(_yearElement.value);

  set year(num year) {
    if(_year != year) {
      _yearElement.value = "$year";
      notifyPropertyChange(#year, _year, year);
      _year = year;
    }
  }

  onUpdate(observer) =>
    changes.listen((records) {
      if(records.any((record) => record.name == #year))
        observer();
    });

  // end <class YearInput>
  InputElement _yearElement;
  int _year;
}




// custom <year_input>
// end <year_input>
