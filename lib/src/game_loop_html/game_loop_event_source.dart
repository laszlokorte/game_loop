part of game_loop_html;

class GameLoopEventSource {
  HtmlDocument _document;
  Element _element;
  Window _window;

  GameLoopEventSource(HtmlDocument doc, this._element) :
    _document = doc,
    _window = doc.window as Window;

  Stream<Event> get onFullscreenError => _document.onFullscreenError;
  Stream<Event> get onFullscreenChange => _document.onFullscreenChange;

  Stream<TouchEvent> get onTouchStart => _element.onTouchStart;
  Stream<TouchEvent> get onTouchEnd => _element.onTouchStart;
  Stream<TouchEvent> get onTouchCancel => _element.onTouchStart;
  Stream<TouchEvent> get onTouchMove => _element.onTouchStart;

  Stream<KeyboardEvent> get onKeyDown => _window.onKeyDown;
  Stream<KeyboardEvent> get onKeyUp => _window.onKeyUp;
  Stream<Event> get onResize => _window.onResize;

  Stream<MouseEvent> get onMouseMove => _element.onMouseMove;
  Stream<MouseEvent> get onMouseDown => _element.onMouseDown;
  Stream<MouseEvent> get onMouseUp => _element.onMouseUp;
  Stream<MouseEvent> get onMouseWheel => _element.onMouseWheel;
}
