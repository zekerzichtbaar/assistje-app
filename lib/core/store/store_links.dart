import 'package:flutter/foundation.dart';

import '../config/env.dart';

/// Links naar Assistje in de stores, voor delen en beoordelen.
///
/// Een directe store-link omzeilt het zoeken in de App Store, waar
/// "assistje" zolang de app nieuw is wordt verbeterd naar "assistent".
abstract final class StoreLinks {
  /// De App Store-pagina (Nederlandse storefront).
  static Uri get appStore => Uri.parse(
    'https://apps.apple.com/nl/app/assistje/id${Env.iosAppStoreId}',
  );

  /// De site, met downloadknoppen voor beide stores.
  static final Uri website = Uri.parse('https://assistje.nl');

  /// De link die je deelt vanaf dit toestel: op iOS meteen de App Store,
  /// elders de site (die kiest de juiste store).
  static Uri shareLink({TargetPlatform? platform}) =>
      (platform ?? defaultTargetPlatform) == TargetPlatform.iOS
      ? appStore
      : website;
}
