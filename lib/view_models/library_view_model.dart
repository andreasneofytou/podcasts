import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:podcasts/models/podcast.dart';

class LibraryViewModel extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref('/users');

  List<Podcast> _podcasts = [];
  List<Podcast> get podcasts => _podcasts;

  Future<void> subscribePodcast(Podcast podcast) async {
    var j = podcast.toJson();
    await ref.child('${auth.currentUser!.uid}/podcasts/${podcast.id}').set(j);
    notifyListeners();
  }
}
