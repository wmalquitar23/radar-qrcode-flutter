import 'package:radar_qrcode_flutter/data/local_db/rapidpass_contact_db.dart';
import 'package:radar_qrcode_flutter/data/models/rapidpass_contact_model.dart';
import 'package:radar_qrcode_flutter/data/sources/data/rest_client.dart';
import 'package:radar_qrcode_flutter/domain/repositories/rapidpass_contact_repository.dart';
import 'package:sembast/sembast.dart';

class RapidPassContactRepositoryImpl extends RapidPassContactRepository {
  Database db;
  RestClient restClient;
  RapidPassContactDb rapidPassContactDb;

  RapidPassContactRepositoryImpl(this.db, this.restClient) {
    restClient = this.restClient;
    rapidPassContactDb = RapidPassContactDb(db);
  }

  @override
  Future<RapidPassContact> getRapidPassContact() async {
    RapidPassContact rapidPassContact = await rapidPassContactDb.getContact();

    // Get Contact from API via Rest Client
    if (rapidPassContact == null) {
      rapidPassContact = await Future.value(
        RapidPassContact(
          mobileNumber: "09212479833",
          emailAddress: "phonradar@gmail.com",
        ),
      );

      await rapidPassContactDb.saveContact(rapidPassContact);
    }

    return rapidPassContact;
  }
}
