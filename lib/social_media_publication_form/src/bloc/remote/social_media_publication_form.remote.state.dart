part of 'social_media_publication_form.remote.bloc.dart';

enum SocialMediaPublicationFormStatus { initial, failure }

enum SocialMediaPublicationFormActions { none, success, failure }

class SocialMediaPublicationFormRemoteState extends Equatable{

  SocialMediaPublicationFormRemoteState({
    this.status=SocialMediaPublicationFormStatus.initial,
    this.action=SocialMediaPublicationFormActions.none,
    this.title = "",
    this.description = "",
    this.publishNow = false,
    this.decidePublishTimeLater = false,
    DateTime? publishDate,
    TimeOfDay? publishTime,
    this.errorMessage = ""
  }):publishDate =publishDate ?? DateTime.now(),
    publishTime = publishTime ?? TimeOfDay.now();

  SocialMediaPublicationFormStatus status;
  SocialMediaPublicationFormActions action;
  String title;
  String description;
  bool publishNow;
  DateTime publishDate;
  TimeOfDay publishTime;
  String errorMessage;
  bool decidePublishTimeLater;

  SocialMediaPublicationFormRemoteState copyWith({
    SocialMediaPublicationFormStatus? status,
    SocialMediaPublicationFormActions? action,
    String? title,
    String? description,
    bool? publishNow,
    DateTime? publishDate,
    TimeOfDay? publishTime,
    String? errorMessage,
    bool? decidePublishTimeLater
  }){
    return SocialMediaPublicationFormRemoteState(
      status: status ?? this.status,
      action: action ?? this.action,
      title: title ?? this.title,
      description: description ?? this.description,
      publishNow: publishNow ?? this.publishNow,
      publishDate: publishDate ?? this.publishDate,
      publishTime: publishTime ?? this.publishTime,
      errorMessage: errorMessage ?? this.errorMessage,
        decidePublishTimeLater: decidePublishTimeLater ?? this.decidePublishTimeLater
    );
  }

  bool canSubmit(){
    return title.isNotEmpty && description.isNotEmpty;
  }

  String getDatedAt(){
    DateTime fullDateTime =publishNow ? DateTime.now()
    :DateTime(publishDate.year,publishDate.month,publishDate.day,publishTime.hour,publishTime.minute);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(fullDateTime);
  }

  bool showPublishCalendar(){
    return !publishNow && !decidePublishTimeLater;
  }

  @override
  List<Object?> get props => [status,action,title,description,publishNow,publishDate,publishTime,errorMessage,decidePublishTimeLater];

}

extension DateTimeHelpers on DateTime{
  bool isToday(){
    DateTime today = DateTime.now();
    return this.year == today.year && this.month == today.month && this.day == today.day;
  }
}

extension TimeOfDayHelpers on TimeOfDay{
  bool isInPast(){
    TimeOfDay now = TimeOfDay.now();
    int nowMinutes = now.hour * 60 + now.minute;
    int eventMinutes = this.hour * 60 + this.minute;
    return eventMinutes < nowMinutes;
  }
}