import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mentorcenter_event.dart';
part 'mentorcenter_state.dart';

class MentorcenterBloc extends Bloc<MentorcenterEvent, MentorcenterState> {
  MentorcenterBloc() : super(MentorcenterInitial()) {
    on<MentorcenterEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
