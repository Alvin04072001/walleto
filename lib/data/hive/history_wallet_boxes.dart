import 'package:hive/hive.dart';
import 'package:walleto/data/model/history_wallet.dart';

class HistoryWalletBoxes {
  static Box<HistoryWallet> getHistoryWallet() =>
      Hive.box<HistoryWallet>("history_wallet");

  static void storeHistoryWallet(HistoryWallet historyWallet) {
    getHistoryWallet().add(historyWallet);
  }

  static void deleteHistoryWallet(String foreignKey) {
    final Map<dynamic, HistoryWallet> boxMap = getHistoryWallet().toMap();
    dynamic boxKey;
    boxMap.forEach((key, value) {
      if (value.foreign == foreignKey) {
        boxKey = key;
        getHistoryWallet().delete(boxKey);
      }
    });
  }
}
