part of 'slider_bloc.dart';

class SliderEvent {}

class AddSliderEvent extends SliderEvent {}

class SliderStartGetEvent extends SliderEvent {}

class SliderGetMoreEvent extends SliderEvent {}

class TitleChangeEvent extends SliderEvent {
  final String title;
  TitleChangeEvent({required this.title});
}

class ImageChangeEvent extends SliderEvent {
  final List<int> image;
  ImageChangeEvent({required this.image});
}

class MessengerChangeEvent extends SliderEvent {
  final String value;
  MessengerChangeEvent({required this.value});
}

class FacebookChangeEvent extends SliderEvent {
  final String value;
  FacebookChangeEvent({required this.value});
}

class YoutubeChangeEvent extends SliderEvent {
  final String value;
  YoutubeChangeEvent({required this.value});
}

class CourseLinkChangeEvent extends SliderEvent {
  final int id;
  CourseLinkChangeEvent({required this.id});
}

class SetSelectedSlider extends SliderEvent {
  final Slider? slider;
  SetSelectedSlider({this.slider});
}

class DeleteSlider extends SliderEvent {
  final int sliderID;
  DeleteSlider({required this.sliderID});
}

class UpdateSliderEvent extends SliderEvent {}

class SearchSliderEvent extends SliderEvent {
  final String data;
  SearchSliderEvent({required this.data});
}
