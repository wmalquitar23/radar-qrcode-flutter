part of 'contact_us_bloc.dart';

abstract class ContactUsState extends Equatable {
  const ContactUsState();

  @override
  List<Object> get props => [];
}

class ContactUsInitial extends ContactUsState {}

class ContactUsGetDataInProgress extends ContactUsState {}

class ContactUsGetDataDone extends ContactUsState {
  final RapidPassContact rapidPassContact;

  ContactUsGetDataDone(this.rapidPassContact);

  @override
  List<Object> get props => [rapidPassContact];
}
