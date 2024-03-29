import 'package:community_app/state/post_setting/models/post_setting.dart';
import 'package:community_app/state/post_setting/notifiers/post_setting_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postSettingProvider =
    StateNotifierProvider<PostSettingNotifier, Map<PostSetting, bool>>(
        (_) => PostSettingNotifier());
