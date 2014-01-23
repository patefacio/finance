library money_input;
import 'dart:html';
import 'package:basic_input/formatting.dart';
import 'package:logging/logging.dart';
import 'package:polymer/polymer.dart';

final _logger = new Logger("moneyInput");

@CustomTag("plus-money-input")
class MoneyInput extends PolymerElement {
  num get amount => _amount;

  MoneyInput.created() : super.created() {
    // custom <MoneyInput created>

    if(shadowRoot != null) {
      _amountElement = shadowRoot.querySelector('#money-amount')
        ..onBlur.listen((evt) => reformatAmount())
        ..onFocus.listen((evt) => reformatAmount())
        ..onKeyUp.listen((evt) { if(evt.which == 13) reformatAmount(); });
    }

    // end <MoneyInput created>
  }

  // custom <class MoneyInput>

  set label(String s) => _amountElement.placeholder = s;

  reformatAmount() => amount = pullNum(_amountElement.value);

  set amount(num amount) {
    if(_amount != amount && amount != null) {
      _amountElement.value = moneyFormat(amount);
      notifyPropertyChange(#amount, _amount, amount);
      _amount = amount;
    }
  }

  bool get applyAuthorStyles => true;

  onUpdate(observer) =>
    changes.listen((records) {
      if(records.any((record) => record.name == #amount))
        observer();
    });

  // end <class MoneyInput>
  num _amount = 0;
  InputElement _amountElement;
}




// custom <money_input>
// end <money_input>
