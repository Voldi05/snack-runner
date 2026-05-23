import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> registerFcmToken(SupabaseClient supabase) async {
  final token = await FirebaseMessaging.instance.getToken();
  if (token == null) return;

  final platform = Platform.isAndroid
      ? 'android'
      : Platform.isIOS
      ? 'ios'
      : 'web';

  await supabase.from('fcm_tokens').upsert({
    'user_id': supabase.auth.currentUser!.id,
    'token': token,
    'platform': platform,
  }, onConflict: 'token');

  // Renouvellement automatique du token
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
    await supabase.from('fcm_tokens').upsert({
      'user_id': supabase.auth.currentUser!.id,
      'token': newToken,
      'platform': platform,
    }, onConflict: 'token');
  });
}
