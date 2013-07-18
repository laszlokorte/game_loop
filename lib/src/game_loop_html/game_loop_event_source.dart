part of game_loop_html;

class GameLoopEvent {
  static const int OTHER = 0;
  static const int KEYBOARD = 1;
  static const int MOUSE = 1;
  static const int TOUCH = 2;

  int type;

  GameLoopEvent(this.type);
}

class GameLoopEventSourceMock extends Stream<GameLoopEvent> {

  StreamController<GameLoopEvent> _controller;

  GameLoopEventSourceMock() {
    _controller = new StreamController<GameLoopEvent>();
  }

  StreamSubscription<GameLoopEvent> listen(void onData(GameLoopEvent line),
      { void onError(Error error),
    void onDone(),
    bool cancelOnError }) {
    return _controller.stream.listen(onData);
  }

  triggerEvents(Iterable<GameLoopEvent> events) {
    for(GameLoopEvent e in events) {
      _controller.add(e);
    }
  }
}

class GameLoopEventSource extends Stream<GameLoopEvent> {
  HtmlDocument _document;
  Element _element;
  Window _window;

  StreamController<GameLoopEvent> _controller;
  List<StreamSubscription> _subscriptions;

  GameLoopEventSource(HtmlDocument doc, this._element) :
    _document = doc,
    _window = doc.window as Window {

    _controller = new StreamController<GameLoopEvent>(
        onListen: _onListen,
        onPause: _onPause,
        onResume: _onResume,
        onCancel: _onCancel);
  }

  void _init() {
    _subscriptions = [
    _document.onFullscreenError.listen(_onFullScrenError
        , onError: _controller.addError),
    _document.onFullscreenChange.listen(_onFullscreenChange
        , onError: _controller.addError),

    _element.onTouchStart.listen(_onTouchStart
        , onError: _controller.addError),
    _element.onTouchEnd.listen(_onTouchEnd
        , onError: _controller.addError),
    _element.onTouchCancel.listen(_onTouchCancel
        , onError: _controller.addError),
    _element.onTouchMove.listen(_onTouchMove
        , onError: _controller.addError),

    _element.onMouseMove.listen(_onMouseMove
        , onError: _controller.addError),
    _element.onMouseDown.listen(_onMouseDown
        , onError: _controller.addError),
    _element.onMouseUp.listen(_onMouseUp
        , onError: _controller.addError),
    _element.onMouseWheel.listen(_onMouseWheel
        , onError: _controller.addError),

    _window.onKeyDown.listen(_onKeyDown
        , onError: _controller.addError),
    _window.onKeyDown.listen(_onKeyUp
        , onError: _controller.addError),
    _window.onKeyDown.listen(_onResize
        , onError: _controller.addError),
    ];

  }

  void _onFullScrenError(Event e) {
    _controller.add(_transformEvent(e, GameLoopEvent.OTHER));
  }
  void _onFullscreenChange(Event e) {
    _controller.add(_transformEvent(e, GameLoopEvent.OTHER));
  }

  void _onTouchStart(Event e) {
    _controller.add(_transformEvent(e, GameLoopEvent.TOUCH));
  }
  void _onTouchEnd(Event e) {
    _controller.add(_transformEvent(e, GameLoopEvent.TOUCH));
  }
  void _onTouchCancel(Event e) {
    _controller.add(_transformEvent(e, GameLoopEvent.TOUCH));
  }
  void _onTouchMove(Event e) {
    _controller.add(_transformEvent(e, GameLoopEvent.TOUCH));
  }

  void _onMouseMove(Event e) {
    _controller.add(_transformEvent(e, GameLoopEvent.MOUSE));
  }
  void _onMouseDown(Event e) {
    _controller.add(_transformEvent(e, GameLoopEvent.MOUSE));
  }
  void _onMouseUp(Event e) {
    _controller.add(_transformEvent(e, GameLoopEvent.MOUSE));
  }
  void _onMouseWheel(Event e) {
    _controller.add(_transformEvent(e, GameLoopEvent.MOUSE));
  }

  void _onKeyDown(Event e) {
    _controller.add(_transformEvent(e, GameLoopEvent.KEYBOARD));
  }
  void _onKeyUp(Event e) {
    _controller.add(_transformEvent(e, GameLoopEvent.KEYBOARD));
  }
  void _onResize(Event e) {
    _controller.add(_transformEvent(e, GameLoopEvent.OTHER));
  }

  _transformEvent(Event e, int type) {
    // TODO extract stuff from original event and pass it to the GameLoopEvent
    return new GameLoopEvent(type);
  }

  StreamSubscription<GameLoopEvent> listen(void onData(GameLoopEvent line),
      { void onError(Error error),
    void onDone(),
    bool cancelOnError }) {
    return _controller.stream.listen(onData,
                                     onError: onError,
                                     onDone: onDone,
                                     cancelOnError: cancelOnError);
  }

  void _onListen() {
    _init();
  }

  void _onCancel() {
    for(StreamSubscription sub in _subscriptions) {
      sub.cancel();
    }
  }

  void _onPause() {
    for(StreamSubscription sub in _subscriptions) {
      sub.pause();
    }
  }

  void _onResume() {
    for(StreamSubscription sub in _subscriptions) {
      sub.resume();
    }
  }

  void _onDone() {
    _controller.close();
  }

}
