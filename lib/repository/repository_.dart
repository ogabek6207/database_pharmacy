import 'package:database_pharmacy/data_base/database_helper1.dart';
import 'package:database_pharmacy/model/drugs_model.dart';
import 'package:database_pharmacy/model/http_result.dart';
import 'package:database_pharmacy/provider/app_provider.dart';

class Repository {
  final AppProvider _provider = AppProvider();
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<List<DrugsResult>> getProduct() => databaseHelper.getDrugsDatabase();
  Future<int> saveProducts(DrugsResult item) =>
      databaseHelper.saveProduct(item);


  Future<int> deleteProducts(int id) => databaseHelper.deleteProduct(id);

  Future<int> updateProduct(DrugsResult item) =>
      databaseHelper.updateProduct(item);


  ///fav
  Future<List<DrugsResult>> getFavProduct() => databaseHelper.getDrugsFavDatabase();

  Future<int> saveFavProducts(DrugsResult item) =>
      databaseHelper.saveFavProduct(item);
  Future<int> deleteFavProducts(int id) => databaseHelper.deleteFavProduct(id);

  Future<HttpResult> getDrugs() => _provider.getDrugs();
}
