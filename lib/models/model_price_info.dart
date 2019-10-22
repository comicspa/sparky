

class ModelPriceInfo
{
  double _apple;
  double _creditCard;
  double _gift;
  double _google;
  double _happyMoney;
  double _phone;
  double _wire;

  double get apple => _apple;
  double get creditCard => _creditCard;
  double get gift => _gift;
  double get google => _google;
  double get happyMoney => _happyMoney;
  double get phone => _phone;
  double get wire => _wire;

  set apple(double apple)
  {
    _apple = apple;
  }

  set creditCard(double creditCard)
  {
    _creditCard = creditCard;
  }

  set gift(double gift)
  {
    _gift = gift;
  }
  set google(double google)
  {
    _google = google;
  }

  set happyMoney(double happyMoney)
  {
    _happyMoney = happyMoney;
  }

  set phone(double phone)
  {
    _phone = phone;
  }

  set wire(double wire)
  {
    _wire = wire;
  }

  static List<ModelPriceInfo> list;
}