import 'package:database_pharmacy/model/drugs_model.dart';
import 'package:database_pharmacy/repository/repository_.dart';

import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final Repository _repository = Repository();
  final drugsFetch = PublishSubject<DrugsModel>();

  Stream<DrugsModel> get fetchDrugs => drugsFetch.stream;

  DrugsModel? resultDrug;

  getDrugs() async {
    var response = await _repository.getDrugs();
    if (response.isSucces) {
      resultDrug = DrugsModel.fromJson(response.result);
      // List database = await _repository.getProduct();
      // for (int i = 0; i < resultDrug!.results.length; i++) {
      //   for (int j = 0; j < database.length; j++) {
      //     if (resultDrug!.results[i].id == database[j].id) {
      //       resultDrug!.results[i].cardCount = database[j].cardCount;
      //       break;
      //     }
      //   }
      // }

      drugsFetch.sink.add(resultDrug!);
    }
  }

  updateDrugs(
    bool type,
    int id,
    int cardCount,
  ) async {
    DrugsResult? data;
    for (int i = 0; i < resultDrug!.results.length; i++) {
      if (resultDrug!.results[i].id == id) {
        resultDrug!.results[i].cardCount = cardCount;
        data = resultDrug!.results[i];
        break;
      }
    }
    if (cardCount == 0) {
      _repository.deleteProducts(id);
    } else {
      if (type) {
        _repository.saveProducts(data!);
      } else {
        _repository.updateProduct(data!);
      }
    }

    drugsFetch.sink.add(resultDrug!);
  }

  dispose() {
    drugsFetch.close();
  }
}

final homeBloc = HomeBloc();
