import 'package:the_analyzer/core/network/local/cache_helper.dart';
import 'package:the_analyzer/core/network/local/cache_keys.dart';

void handleUserDataCaching(userData) {
  CacheHelper.savedata(key: CacheKeys.kUserToken, value: userData?.data?.token);
  CacheHelper.savedata(key: CacheKeys.kUserEmail, value: userData?.data?.email);
  CacheHelper.savedata(key: CacheKeys.kUserName, value: userData?.data?.name);
  CacheHelper.savedata(
      key: CacheKeys.kUserNickName, value: userData?.data?.nickname);
  CacheHelper.savedata(
      key: CacheKeys.kUserImage, value: userData?.data?.avatar);
  CacheHelper.savedata(key: CacheKeys.kUserId, value: userData?.data?.id);
  CacheHelper.savedata(
      key: CacheKeys.kNotificationMessagingStatus,
      value: userData?.data?.messageNotifications);
  CacheHelper.savedata(
      key: CacheKeys.kAppCountry, value: userData?.data?.country?.id);
  CacheHelper.savedata(
      key: CacheKeys.kuserAvatar, value: userData?.data?.avatar);
}

void handleUserDataDeleting() {
  CacheHelper.removedata(key: CacheKeys.kUserToken);
  CacheHelper.removedata(key: CacheKeys.kUserEmail);
  CacheHelper.removedata(key: CacheKeys.kUserName);
  CacheHelper.removedata(key: CacheKeys.kUserNickName);
  CacheHelper.removedata(key: CacheKeys.kUserImage);
  CacheHelper.removedata(key: CacheKeys.kUserId);
  CacheHelper.removedata(key: CacheKeys.kNotificationMessagingStatus);
  CacheHelper.removedata(key: CacheKeys.kAppCountry);
  CacheHelper.removedata(key: CacheKeys.kuserAvatar);
}
