import 'package:radar_qrcode_flutter/data/mappers/rapidpass_contact_mapper.dart';
import 'package:radar_qrcode_flutter/data/models/rapidpass_contact_model.dart';
import 'package:sembast/sembast.dart';
import 'package:radar_qrcode_flutter/data/local_db/database.dart';

class RapidPassContactDb extends Db {
  RapidPassContactDb(Database db)
      : super(db, stringMapStoreFactory.store("contact"));

  RecordRef get currentSessionRecord => store.record("rapidpass");

  RapidPassContactMapper _rapidPassContactMapper = RapidPassContactMapper();
  final String _mobile = "mobile";
  final String _email = "email";

  Future<void> saveContact(RapidPassContact rapidPassContact) async {
    await currentSessionRecord.put(db, {
      _mobile: rapidPassContact?.mobileNumber,
      _email: rapidPassContact?.emailAddress,
    });
  }

  Future<RapidPassContact> getContact() async {
    Map<String, dynamic> data = await currentSessionRecord.get(db) as Map;
    return _rapidPassContactMapper.fromMap(data);
  }

  Future<RapidPassContact> updateContact(
      RapidPassContact rapidPassContact) async {
    final updatedData = await currentSessionRecord.update(
        db, _rapidPassContactMapper.toMap(rapidPassContact));
    return _rapidPassContactMapper.fromMap(updatedData);
  }
}
