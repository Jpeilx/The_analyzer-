import 'package:the_analyzer/core/network/local/cache_helper.dart';

void addToLatestSearch(String search) {
  CacheHelper.savedata(key: '5', value: CacheHelper.getData(key: '4'));
  CacheHelper.savedata(key: '4', value: CacheHelper.getData(key: '3'));
  CacheHelper.savedata(key: '3', value: CacheHelper.getData(key: '2'));
  CacheHelper.savedata(key: '2', value: CacheHelper.getData(key: '1'));
  CacheHelper.savedata(key: '1', value: search);
}

List<String> getLatestSearchData() {
  List<String> result = [];
  if (CacheHelper.getData(key: '1') != null &&
      CacheHelper.getData(key: '1') != '') {
    result.add(CacheHelper.getData(key: '1'));
  }
  if (CacheHelper.getData(key: '2') != null &&
      CacheHelper.getData(key: '2') != '') {
    result.add(CacheHelper.getData(key: '2'));
  }
  if (CacheHelper.getData(key: '3') != null &&
      CacheHelper.getData(key: '3') != '') {
    result.add(CacheHelper.getData(key: '3'));
  }
  if (CacheHelper.getData(key: '4') != null &&
      CacheHelper.getData(key: '4') != '') {
    result.add(CacheHelper.getData(key: '4'));
  }
  if (CacheHelper.getData(key: '5') != null &&
      CacheHelper.getData(key: '5') != '') {
    result.add(CacheHelper.getData(key: '5'));
  }

  return result;
}

Future<void> deleteElementFormLatestSearchData(String index) async {
  if (index == '1') {
    CacheHelper.savedata(key: '1', value: CacheHelper.getData(key: '2') ?? '');
    CacheHelper.savedata(key: '2', value: CacheHelper.getData(key: '3') ?? '');
    CacheHelper.savedata(key: '3', value: CacheHelper.getData(key: '4') ?? '');
    CacheHelper.savedata(key: '4', value: CacheHelper.getData(key: '5') ?? '');
    CacheHelper.removedata(key: '5');
  } else if (index == '2') {
    CacheHelper.savedata(key: '2', value: CacheHelper.getData(key: '3') ?? '');
    CacheHelper.savedata(key: '3', value: CacheHelper.getData(key: '4') ?? '');
    CacheHelper.savedata(key: '4', value: CacheHelper.getData(key: '5') ?? '');
    CacheHelper.removedata(key: '5');
  } else if (index == '3') {
    CacheHelper.savedata(key: '3', value: CacheHelper.getData(key: '4') ?? '');
    CacheHelper.savedata(key: '4', value: CacheHelper.getData(key: '5') ?? '');
    CacheHelper.removedata(key: '5');
  } else if (index == '4') {
    CacheHelper.savedata(key: '4', value: CacheHelper.getData(key: '5') ?? '');
    CacheHelper.removedata(key: '5');
  } else {
    CacheHelper.removedata(key: '5');
  }
}

void deleteAllLatestSearchData() {
  CacheHelper.removedata(key: '1');
  CacheHelper.removedata(key: '2');
  CacheHelper.removedata(key: '3');
  CacheHelper.removedata(key: '4');
  CacheHelper.removedata(key: '5');
}
