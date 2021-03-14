import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:lichtline/models/input_comparison_model.dart';

class DataProvider extends ChangeNotifier {
  int _month = 12;
  int _year = 12;
  double _electricityCostEuroKWH = 0.18;
  String companyName;
  DateTime _dateTime = new DateTime.now();
  List<InputModel> _lichtLine;
  List<InputModel> _altLosung;

  List<InputModel> get lichtLine => _lichtLine;
  List<InputModel> get altLosung => _altLosung;

  setCompanyName(String _companyName) {
    this.companyName = _companyName;
  }

  void setInputValues(List<InputModel> _licht, List<InputModel> _alt) {
    _lichtLine = _licht;
    _altLosung = _alt;
  }

  calculateEnergyCosting(List<InputModel> _valuesForCalculation) {
    int _stuck = int.parse(_valuesForCalculation[2].value);
    int _watt = int.parse(_valuesForCalculation[3].value);
    int _hours = int.parse(_valuesForCalculation[0].value);
    int _totalHours = int.parse(_valuesForCalculation[6].value);
    int _days = int.parse(_valuesForCalculation[1].value);
    int hoursToYearsForMaintenancePrice =
        ((_totalHours / _days) / _hours).round();
    List<Sales> _totalEnergyCosting = [];
    for (int i = 0; i <= _year; i++) {
      double _tempCalValue;
      if (i != 0) {
        _tempCalValue = _month *
            _days *
            _stuck *
            (_watt / 1000) *
            _electricityCostEuroKWH *
            (1 + pow((hoursToYearsForMaintenancePrice / 100), i));
        if (i == 1) {
          _totalEnergyCosting.add(
            Sales(
                _dateTime.year.toString(),
                double.parse(
                  _tempCalValue.toStringAsFixed(2),
                )),
          );
        } else {
          int currentIndex = i;
          double _newSubtractValue =
              _totalEnergyCosting[currentIndex - 2].sales - _tempCalValue;
          double _newValueForNextYear =
              _newSubtractValue + _totalEnergyCosting[0].sales;
          _totalEnergyCosting.add(
            Sales(
                (_dateTime.year + i).toString(),
                double.parse(
                  _newValueForNextYear.toStringAsFixed(2),
                )),
          );
        }
      }
    }
    print("Energy Costing: " + _totalEnergyCosting.toString());
    return _totalEnergyCosting;
  }

  totalCosting(List<InputModel> _valuesForCalculation,
      {bool isNewBulb = false}) {
    List<Sales> _totalCosting = [];
    int _stuck = int.parse(_valuesForCalculation[2].value);
    int _maintenanceP = int.parse(_valuesForCalculation[5].value);
    int _totalHours = int.parse(_valuesForCalculation[6].value);
    int _userProvidedHours = int.parse(_valuesForCalculation[0].value);
    int _numberOfDays = int.parse(_valuesForCalculation[1].value);
    int _totalLife = (_totalHours / _userProvidedHours / _numberOfDays).round();
    double _price = double.parse(_valuesForCalculation[4].value);
    int _tempInt = _totalLife;
    double newBulbInstallationCost;
    if (isNewBulb) {
      newBulbInstallationCost = _price * _stuck;
    }

    var _totalEnergy = calculateEnergyCosting(_valuesForCalculation);
    for (var i = 0; i < _totalEnergy.length; i++) {
      if (i == 0) {
        if (isNewBulb) {
          _totalEnergy[i].sales = newBulbInstallationCost;
          _totalCosting.add(_totalEnergy[i]);
        } else {
          _totalCosting.add(_totalEnergy[i]);
        }
      } else {
        //TODO check
        int remainder = i % _totalLife;
        if (_totalLife == i) {
          // if (_tempInt != _totalLife) {
          // } else {
          //   _totalLife = _totalLife + i - _tempInt;
          // }

          //  Sales(
          //       (_dateTime.year + i).toString(),
          //       double.parse(
          //         _newValueForNextYear.toStringAsFixed(2),
          //       )),
          double _cost = _totalCosting[i - 1].sales + _totalEnergy[i].sales;
          double _maintenance = _stuck.toDouble() * _maintenanceP.toDouble();
          _totalCosting.add(
              Sales((_dateTime.year + i).toString(), _cost + _maintenance));
        } else {
          // _totalCosting.add(_totalCosting[i - 1] + _totalEnergy[i]);

          _totalCosting.add(Sales((_dateTime.year + i).toString(),
              (_totalCosting[i - 1].sales + _totalEnergy[i].sales)));
        }
      }
    }
    print(_totalCosting);
  }

  totalCarbonDioxide(List<InputModel> _valuesForCalculation) {
    int _hours = int.parse(_valuesForCalculation[0].value);
    int _days = int.parse(_valuesForCalculation[1].value);
    int _stuck = int.parse(_valuesForCalculation[2].value);
    int _watt = int.parse(_valuesForCalculation[3].value);
    List<Sales> _totalCo2 = [];
    for (int i = 1; i <= _year; i++) {
      double tempCal =
          (_hours * _days * _stuck * (_watt / 10000) * (486 / 100000)) * i;
      _totalCo2.add(
        Sales(
          (_dateTime.year + i - 1).toString(),
          tempCal,
        ),
      );
      // _totalCo2.add(tempCal);
    }
    print("CO2: " + _totalCo2.toString());
    return _totalCo2;
  }

  totalKw(List<InputModel> _valuesForCalculation) {
    int _hours = int.parse(_valuesForCalculation[0].value);
    int _days = int.parse(_valuesForCalculation[1].value);
    int _stuck = int.parse(_valuesForCalculation[2].value);
    int _watt = int.parse(_valuesForCalculation[3].value);

    List<Sales> _totalKw = [];
    for (int i = 1; i <= _year; i++) {
      double tempCal = (_hours * _days * _stuck * (_watt / 1000)) * i;
      _totalKw.add(Sales((_dateTime.year + i).toString(), tempCal));
    }
    print("KW: " + _totalKw.toString());
    return _totalKw;
  }
}

class Sales {
  final String year;
  final double sales;

  Sales(this.year, this.sales);
}
