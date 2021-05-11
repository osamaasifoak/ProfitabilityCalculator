import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:lichtline/models/input_comparison_model.dart';

class DataProvider extends ChangeNotifier {
  int _month = 12;
  int _year = 0;
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
                i.toString(),
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
                i.toString(),
                double.parse(
                  _newValueForNextYear.toStringAsFixed(2),
                )),
          );
        }
      }
    }
    // print("Energy Costing: " + _totalEnergyCosting.toString());
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

    List<Sales> _totalEnergy = calculateEnergyCosting(_valuesForCalculation);
    var _totalMaintenanceCost = calculateMaintenanceCost(
        _maintenanceP.toDouble(),
        _year,
        double.parse(calculateMaintenanceIncrementCycle(
                _totalHours, _userProvidedHours, _numberOfDays)
            .toString()));
    for (var i = 0; i < _totalEnergy.length; i++) {
      if (i == 0) {
        if (isNewBulb) {
          // _totalEnergy[i].sales = newBulbInstallationCost;
          _totalCosting.add(Sales("0", newBulbInstallationCost));
        } else {
          _totalCosting.add(_totalEnergy[i]);
        }
      } else {
        if (_totalMaintenanceCost[i] != null) {
          double _cost = _totalCosting[i - 1].sales + _totalEnergy[i].sales;
          double _maintenance = _stuck.toDouble() * _maintenanceP.toDouble();
          _totalCosting.add(Sales(i.toString(), _cost + _maintenance));
        } else {
          _totalCosting.add(Sales(i.toString(),
              (_totalCosting[i - 1].sales + _totalEnergy[i].sales)));
        }
      }
    }
    print(_totalCosting);
    return _totalCosting;
  }

  totalCarbonDioxide(List<InputModel> _valuesForCalculation) {
    int _hours = int.parse(_valuesForCalculation[0].value);
    int _days = int.parse(_valuesForCalculation[1].value);
    int _stuck = int.parse(_valuesForCalculation[2].value);
    int _watt = int.parse(_valuesForCalculation[3].value);
    int _maintenanceP = int.parse(_valuesForCalculation[5].value);
    int _totalNumberofHours = int.parse(_valuesForCalculation[6].value);
    calculateMaintenanceCost(
        _maintenanceP.toDouble(),
        _year,
        double.parse(calculateMaintenanceIncrementCycle(
                _totalNumberofHours, _hours, _days)
            .toString()));
    List<Sales> _totalCo2 = [];
    for (int i = 1; i <= _year; i++) {
      double tempCal =
          (_hours * _days * _stuck * (_watt / 10000) * (486 / 100000)) * i;
      _totalCo2.add(
        Sales(
          // (i - 1).toString(),
          (i).toString(),
          tempCal,
        ),
      );
      // _totalCo2.add(tempCal);
    }
    // print("CO2: " + _totalCo2.toString());
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
      _totalKw.add(Sales(i.toString(), tempCal));
    }
    // print("KW: " + _totalKw.toString());
    return _totalKw;
  }

  calculateMaintenanceCost(double maintenanceCost, int totalYears,
      double maintenanceIncrementYearCycle) {
    int tempIncrement = 0;
    List<double> totalMaintenanceCost = [];
    double incrementMaintenanceCost = maintenanceIncrementYearCycle;
    for (int i = 0; i < totalYears; i++) {
      if (incrementMaintenanceCost.ceil() == tempIncrement) {
        totalMaintenanceCost.add(maintenanceCost);
        incrementMaintenanceCost =
            incrementMaintenanceCost + maintenanceIncrementYearCycle;
        tempIncrement++;
      } else {
        tempIncrement++;
        totalMaintenanceCost.add(null);
      }
    }
    print(totalMaintenanceCost);
    return totalMaintenanceCost;
  }

  calculateMaintenanceIncrementCycle(
      int totalNumberOfHours, int numberOfGivenHours, int daysInYear) {
    return (totalNumberOfHours / numberOfGivenHours / daysInYear);
  }

  calculateTotalYears() {
    int numberOfGivenHours = int.parse(_lichtLine[0].value);
    int totalNumberOfHours = int.parse(_lichtLine[6].value);
    int daysInYear = int.parse(_lichtLine[1].value);
    _year = calculateMaintenanceIncrementCycle(
            totalNumberOfHours, numberOfGivenHours, daysInYear)
        .ceil();
    print(_year);
  }

  // annualCostSaving(List<InputModel> _valuesForCalculation) {
  //   int _hours = int.parse(_valuesForCalculation[0].value);
  //   int _days = int.parse(_valuesForCalculation[1].value);
  //   int _stuck = int.parse(_valuesForCalculation[2].value);
  //   int _watt = int.parse(_valuesForCalculation[3].value);
  //   int _maintenanceP = int.parse(_valuesForCalculation[5].value);
  //   calculateMaintenanceCost(_maintenanceP.toDouble(), 12, 2);
  // }
  calculationKumAmortisation() {
    List<Sales> _lichtlineTotalCosting =
        totalCosting(_lichtLine, isNewBulb: true);
    List<Sales> _altLosungTotalCosting =
        totalCosting(_altLosung, isNewBulb: true);
    List<Sales> _kumAmortisation = [];
    for (var i = 0; i < _lichtlineTotalCosting.length; i++) {
      double temp = double.parse(
          (_lichtlineTotalCosting[i].sales - _altLosungTotalCosting[i].sales)
              .toStringAsFixed(2));
      Sales _sales = new Sales(i.toString(), temp);
      _kumAmortisation.add(_sales);
    }
    print(_kumAmortisation);
    return _kumAmortisation;
  }
}

class Sales {
  final String year;
  final double sales;

  Sales(this.year, this.sales);
}
