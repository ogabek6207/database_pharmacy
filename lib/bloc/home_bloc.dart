import 'package:database_pharmacy/model/drugs_model.dart';
import 'package:database_pharmacy/repository/repository_.dart';

import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final Repository _repository = Repository();
  final drugsFetch = PublishSubject<DrugsModel>();
  final drugsCardFetch = PublishSubject<List<DrugsResult>>();
  final drugsFavFetch = PublishSubject<List<DrugsResult>>();

  Stream<DrugsModel> get fetchDrugs => drugsFetch.stream;

  Stream<List<DrugsResult>> get fetchCardDrugs => drugsCardFetch.stream;

  Stream<List<DrugsResult>> get fetchFavDrugs => drugsFavFetch.stream;

  DrugsModel? resultDrug;

  getDrugsCard() async {
    List<DrugsResult> database = await _repository.getProduct();
    drugsCardFetch.sink.add(database);
  }

  ///fav
  getDrugsFav() async {
    List<DrugsResult> database = await _repository.getFavProduct();
    drugsCardFetch.sink.add(database);
  }

  getDrugs() async {
    var response = await _repository.getDrugs();
    if (response.isSucces) {
      resultDrug = DrugsModel.fromJson(response.result);
      List<DrugsResult> database = await _repository.getProduct();
      List<DrugsResult> databaseFav = await _repository.getFavProduct();
      for (int i = 0; i < resultDrug!.results.length; i++) {
        for (int j = 0; j < database.length; j++) {
          if (resultDrug!.results[i].id == database[j].id) {
            resultDrug!.results[i].cardCount = database[j].cardCount;
            break;
          }
        }
        for (int j = 0; j < databaseFav.length; j++) {
          if (resultDrug!.results[i].id == databaseFav[j].id) {
            resultDrug!.results[i].favSelected = true;
            break;
          }
        }
      }

      drugsFetch.sink.add(resultDrug!);
    }
  }

  ///fav
  updateFavDrugs(
    DrugsResult data,
    bool like,
  ) async {
    for (int i = 0; i < resultDrug!.results.length; i++) {
      if (resultDrug!.results[i].id == data.id) {
        resultDrug!.results[i].favSelected = like;
        break;
      }
    }
    if (like) {
      _repository.saveFavProducts(data);
    } else {
      _repository.deleteFavProducts(data.id);
    }
    drugsFetch.sink.add(resultDrug!);
  }

  updateCardDrugs(
    DrugsResult data,
  ) async {
    if (data.cardCount == 0) {
      _repository.deleteProducts(data.id);
    } else {
      _repository.updateProduct(data);
    }
    List<DrugsResult> database = await _repository.getProduct();
    drugsCardFetch.sink.add(database);
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
    drugsCardFetch.close();
  }
}

final homeBloc = HomeBloc();
