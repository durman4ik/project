// Generated by CoffeeScript 1.8.0
(function() {
  var Animation, AreaBuffer, AreaMap, DrawingArea, EventsHanlerInitializer, SchemeData, SchemeElement, SchemeLine,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Animation = (function() {
    function Animation() {
      this.InitStage = __bind(this.InitStage, this);
      this.loopr = __bind(this.loopr, this);
      this.stop = __bind(this.stop, this);
      this.start = __bind(this.start, this);
      this.setAnimated = __bind(this.setAnimated, this);
      this.UpdateScene = __bind(this.UpdateScene, this);
      this.isAnimated = __bind(this.isAnimated, this);
      this.getStage = __bind(this.getStage, this);
      this.getFPS = __bind(this.getFPS, this);
      this.getFrame = __bind(this.getFrame, this);
      this.getTimeInterval = __bind(this.getTimeInterval, this);
      this.getDuration = __bind(this.getDuration, this);
      this.stage;
      this.startTime;
      this.lastTime;
      this.timeInterval;
      this.duration = 0;
      this.frame = 0;
      this.fps;
      this.animated = false;
    }

    Animation.prototype.getDuration = function(SI) {
      if (SI === 'sec') {
        return Math.round(this.duration / 1000);
      } else {
        return this.duration;
      }
    };

    Animation.prototype.getTimeInterval = function() {
      return this.timeInterval;
    };

    Animation.prototype.getFrame = function() {
      return this.frame;
    };

    Animation.prototype.getFPS = function() {
      return this.fps;
    };

    Animation.prototype.getStage = function() {
      return this.stage();
    };

    Animation.prototype.isAnimated = function() {
      return this.animated;
    };

    Animation.prototype.UpdateScene = function(_stage) {
      return this.stage = _stage;
    };

    Animation.prototype.setAnimated = function(flag) {
      var _ref;
      return this.animated = (_ref = flag === true || flag === false) != null ? _ref : {
        flag: this.animated
      };
    };

    Animation.prototype.start = function() {
      var date;
      window.requestAnimFrame = (function(callback) {
        return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(callback) {
          console.log(callback + ' - clbxk');
          return window.setTimeout(callback, 100);
        };
      })();
      this.setAnimated(true);
      date = new Date();
      this.startTime = date.getTime();
      this.lastTime = this.startTime;
      return this.loopr();
    };

    Animation.prototype.stop = function() {
      return this.setAnimated(false);
    };

    Animation.prototype.loopr = function() {
      this.timeInterval = new Date().getTime() - this.lastTime;
      this.duration += this.timeInterval;
      this.lastTime = new Date().getTime();
      this.delta = this.timeInterval / 1000;
      this.fps = Math.round(1 / this.delta);
      this.frame++;
      this.InitStage();
      if (this.animated) {
        return requestAnimFrame((function(_this) {
          return function() {
            return _this.loopr();
          };
        })(this));
      } else {
        return console.log("animation is stopped ");
      }
    };

    Animation.prototype.InitStage = function() {
      if (this.stage !== void 0) {
        this.getStage();
      } else {
        console.log("undefined stage: ");
      }
      return [];
    };

    return Animation;

  })();

  AreaBuffer = (function() {
    function AreaBuffer() {
      this.Remove = __bind(this.Remove, this);
      this.Update = __bind(this.Update, this);
      this.Add = __bind(this.Add, this);
      this.GetPositionInArr = __bind(this.GetPositionInArr, this);
      this.GetByKey = __bind(this.GetByKey, this);
      this.bufferArray = __bind(this.bufferArray, this);
      this.bufferArray = new Array();
    }

    AreaBuffer.prototype.bufferArray = function() {
      return this.bufferArray;
    };

    AreaBuffer.prototype.GetByKey = function(key) {
      var i, _i, _ref;
      for (i = _i = 0, _ref = this.bufferArray.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        if (this.bufferArray[i].key === key) {
          return this.bufferArray[i];
        }
      }
      return void 0;
    };

    AreaBuffer.prototype.GetPositionInArr = function(key) {
      var i, _i, _ref;
      for (i = _i = 0, _ref = this.bufferArray.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        if (this.bufferArray[i].key === key) {
          return i;
        }
      }
      return void 0;
    };

    AreaBuffer.prototype.Add = function(key, image, x, y) {
      this.bufferArray.push({
        key: key,
        image: image,
        x: x,
        y: y
      });
      return this.bufferArray.length;
    };

    AreaBuffer.prototype.Update = function(key, image) {
      return this.GetByKey(key).image = image;
    };

    AreaBuffer.prototype.Remove = function(key) {
      var pos;
      pos = this.GetPositionInArr(key);
      if (pos !== void 0) {
        return this.bufferArray.splice(pos, 1);
      }
    };

    return AreaBuffer;

  })();

  AreaMap = (function() {
    function AreaMap(width, height, step) {
      var i, _i, _ref;
      this.width = width;
      this.height = height;
      this.step = step;
      this.map = new Array(this.width / this.step);
      for (i = _i = 0, _ref = this.map.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        this.map[i] = new Array(height / this.step);
      }
    }

    return AreaMap;

  })();

  DrawingArea = (function() {
    function DrawingArea(myConfig) {
      this.myConfig = myConfig;
      this.MouseMoveBall = __bind(this.MouseMoveBall, this);
      this.MoveBallIfMouseDown = __bind(this.MoveBallIfMouseDown, this);
      this.sqr = __bind(this.sqr, this);
      this.CheckMouseHoverOnBall = __bind(this.CheckMouseHoverOnBall, this);
      this.ChangeColorByHover = __bind(this.ChangeColorByHover, this);
      this.GetValueAreaMapCell = __bind(this.GetValueAreaMapCell, this);
      this.ValidateMapIndexes = __bind(this.ValidateMapIndexes, this);
      this.IsEmptyAreaMapCell = __bind(this.IsEmptyAreaMapCell, this);
      this.SnapToGrid = __bind(this.SnapToGrid, this);
      this.EnterImageInCanvas = __bind(this.EnterImageInCanvas, this);
      this.GetCanvasCoords = __bind(this.GetCanvasCoords, this);
      this.DrawSchemeData = __bind(this.DrawSchemeData, this);
      this.GetSelectedColor = __bind(this.GetSelectedColor, this);
      this.DrawImageData = __bind(this.DrawImageData, this);
      this.DrawGrid = __bind(this.DrawGrid, this);
      this.CleareBuffer = __bind(this.CleareBuffer, this);
      this.BufferedDraw = __bind(this.BufferedDraw, this);
      this.DrawBackground = __bind(this.DrawBackground, this);
      this.defShadowBlur = 10;
      this.defBallsColor = 'rgba(0,0,0,1)';
      this.defBallHoverColor = '#4169E1';
      this.canvas = document.getElementById(this.myConfig.canvasId);
      this.canvas.height = this.myConfig.canvasHeight;
      this.canvas.width = this.myConfig.canvasWidth;
      this.context = this.canvas.getContext("2d");
      this.mousePos = [];
      this.mouseDown = false;
      this.isStart = false;
      this.dragingToSchemeElement = "";
      this.bufferArea = new AreaBuffer();
      this.areaMap = new AreaMap(this.myConfig.canvasWidth, this.myConfig.canvasHeight, this.myConfig.gridStep);
    }

    DrawingArea.prototype.DrawBackground = function() {
      this.context.beginPath();
      this.context.fillStyle = 'rgba( 200, 255, 255, 1 )';
      this.context.rect(0, 0, this.canvas.width, this.canvas.height);
      this.context.closePath();
      return this.context.fill();
    };

    DrawingArea.prototype.BufferedDraw = function(key, drawFunct, x, y, w, h) {
      var b, img;
      b = this.bufferArea.GetByKey(key);
      if (b !== void 0) {
        return this.DrawImageData(b.image, b.x, b.y);
      } else {
        drawFunct();
        img = this.context.getImageData(x, y, w, h);
        return this.bufferArea.Add(key, img, x, y);
      }
    };

    DrawingArea.prototype.CleareBuffer = function(key) {
      return this.bufferArea.Remove(key);
    };

    DrawingArea.prototype.DrawGrid = function(step) {
      var i, j, _i, _ref, _results;
      _results = [];
      for (i = _i = 0, _ref = this.canvas.width / step; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
        _results.push((function() {
          var _j, _ref1, _results1;
          _results1 = [];
          for (j = _j = 0, _ref1 = this.canvas.height / step; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; j = 0 <= _ref1 ? ++_j : --_j) {
            this.context.beginPath();
            this.context.arc(i * step, j * step, 1, 0, 2 * Math.PI);
            this.context.fillStyle = 'blue';
            this.context.closePath();
            _results1.push(this.context.fill());
          }
          return _results1;
        }).call(this));
      }
      return _results;
    };

    DrawingArea.prototype.DrawImageData = function(image, dx, dy) {
      return this.context.putImageData(image, dx, dy);
    };

    DrawingArea.prototype.GetSelectedColor = function() {
      return $('#' + this.myConfig.idPaintForm + ' ' + this.myConfig.classColorSelector)[0].value;
    };

    DrawingArea.prototype.DrawSchemeData = function(schemeData) {
      var i, _i, _ref, _results;
      _results = [];
      for (i = _i = 0, _ref = schemeData.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        _results.push(schemeData[i].obj.Draw(this.context));
      }
      return _results;
    };

    DrawingArea.prototype.GetCanvasCoords = function(mouseX, mouseY) {
      var c;
      c = this.SnapToGrid(mouseX - this.canvas.offsetLeft, mouseY - this.canvas.offsetTop);
      return {
        canvasX: c.canvasX,
        canvasY: c.canvasY,
        mapCellX: Math.round(c.canvasX / this.myConfig.gridStep),
        mapCellY: Math.round(c.canvasY / this.myConfig.gridStep)
      };
    };

    DrawingArea.prototype.EnterImageInCanvas = function(x, y, w, h) {
      if (x < this.canvas.offsetLeft) {
        x = this.canvas.offsetLeft;
      }
      if (x + w > this.canvas.offsetLeft + this.canvas.offsetWidth) {
        x = this.canvas.offsetLeft + this.canvas.offsetWidth - w;
      }
      if (y < this.canvas.offsetTop) {
        y = this.canvas.offsetTop;
      }
      if (y + h > this.canvas.offsetTop + this.canvas.offsetHeight) {
        y = this.canvas.offsetTop + this.canvas.offsetHeight - h;
      }
      return {
        x: x,
        y: y
      };
    };

    DrawingArea.prototype.SnapToGrid = function(x, y, dx, dy) {
      var canvasOffsetX, canvasOffsetY, snapX, snapY;
      if (dx === void 0) {
        dx = 0;
      }
      if (dy === void 0) {
        dy = 0;
      }
      snapX = Math.round((x - dx) / this.myConfig.gridStep);
      snapY = Math.round((y - dy) / this.myConfig.gridStep);
      canvasOffsetY = this.canvas.offsetTop % this.myConfig.gridStep;
      canvasOffsetX = this.canvas.offsetLeft % this.myConfig.gridStep;
      return {
        canvasX: snapX * this.myConfig.gridStep,
        canvasY: snapY * this.myConfig.gridStep,
        newClientX: (snapX * this.myConfig.gridStep) + canvasOffsetX,
        newClientY: (snapY * this.myConfig.gridStep) + canvasOffsetY
      };
    };

    DrawingArea.prototype.IsEmptyAreaMapCell = function(x, y) {
      if (!this.ValidateMapIndexes(x, y)) {
        return false;
      }
      if (this.areaMap.map[x][y] !== void 0) {
        return false;
      }
      return true;
    };

    DrawingArea.prototype.ValidateMapIndexes = function(x, y) {
      if (x >= 0 && x < this.areaMap.map.length) {
        if (y < 0 || y > this.areaMap.map[x].length - 1) {
          return false;
        }
      } else {
        return false;
      }
      return true;
    };

    DrawingArea.prototype.GetValueAreaMapCell = function(x, y) {
      return this.areaMap.map[x][y];
    };

    DrawingArea.prototype.ChangeColorByHover = function(ball) {
      if (this.CheckMouseHoverOnBall(ball) && this.CheckPressedAnyButtons() === false) {
        return this.defBallHoverColor;
      } else {
        return ball.color;
      }
    };

    DrawingArea.prototype.CheckMouseHoverOnBall = function(ball) {
      var x, y;
      x = this.mousePos['currentX'];
      y = this.mousePos['currentY'];
      if ((this.sqr(x - ball.x) + this.sqr(y - ball.y)) <= this.sqr(ball.radius)) {
        return true;
      } else {
        return false;
      }
    };

    DrawingArea.prototype.sqr = function(val) {
      return val * val;
    };

    DrawingArea.prototype.MoveBallIfMouseDown = function(ballsNumber) {
      if (this.idMovingBall >= 0) {
        return this.MouseMoveBall(this.idMovingBall);
      } else if (this.mouseDown && this.CheckMouseHoverOnBall(this.ballsArray.balls[ballsNumber]) && this.CheckPressedAnyButtons() === false) {
        this.idMovingBall = ballsNumber;
        return this.MouseMoveBall(ballsNumber);
      }
    };

    DrawingArea.prototype.MouseMoveBall = function(ballsNumber) {};

    return DrawingArea;

  })();

  EventsHanlerInitializer = (function() {
    function EventsHanlerInitializer(app) {
      this.app = app;
      $('#canvas').on('mousemove', (function(_this) {
        return function(e) {
          var canvasCoords, hres, idHover, imgCoords, mapCoords, snappedCoords, vres;
          mapCoords = _this.app.drawingArea.GetCanvasCoords(e.pageX, e.pageY);
          if (!_this.app.drawingArea.IsEmptyAreaMapCell(mapCoords.mapCellX, mapCoords.mapCellY)) {
            idHover = _this.app.drawingArea.GetValueAreaMapCell(mapCoords.mapCellX, mapCoords.mapCellY);
            _this.elem = _this.app.schemeData.GetById(idHover);
            _this.elem.obj.isMouseHover = true;
            _this.app.UpdateArea();
            _this.elem.obj.isMouseHover = false;
            _this.elementHasBeenSelected = true;
            hres = _this.elem.obj.IsHorizontalResize(mapCoords.canvasX);
            vres = _this.elem.obj.IsVerticalResize(mapCoords.canvasY);
            if (hres || vres) {
              if (hres) {
                $('#canvas')[0].style.cursor = 'e-resize';
              }
              if (vres) {
                $('#canvas')[0].style.cursor = 'n-resize';
              }
            } else {
              $('#canvas')[0].style.cursor = 'default';
            }
          } else {
            $('#canvas')[0].style.cursor = 'default';
            if (_this.elementHasBeenSelected) {
              _this.app.UpdateArea();
              _this.elementHasBeenSelected = false;
            }
          }
          if (_this.elementIsMoving) {
            _this.elem.obj.RemoveFromMap(_this.app.drawingArea.areaMap);
            snappedCoords = _this.app.drawingArea.SnapToGrid(event.pageX, event.pageY, _this.elem.obj.width / 2, _this.elem.obj.height / 2);
            imgCoords = _this.app.drawingArea.EnterImageInCanvas(snappedCoords.newClientX, snappedCoords.newClientY, _this.elem.obj.width, _this.elem.obj.height);
            canvasCoords = _this.app.drawingArea.GetCanvasCoords(imgCoords.x, imgCoords.y);
            _this.elem.obj.x = canvasCoords.canvasX;
            _this.elem.obj.y = canvasCoords.canvasY;
            _this.elem.obj.PlaceToMap(_this.app.drawingArea.areaMap);
            return _this.app.UpdateArea();
          }
        };
      })(this));
      $('#canvas').on('mousedown', (function(_this) {
        return function(e) {
          if (_this.elementHasBeenSelected) {
            return _this.elementIsMoving = true;
          }
        };
      })(this));
      $('#canvas').on('mouseup', (function(_this) {
        return function(e) {
          return _this.elementIsMoving = false;
        };
      })(this));
      $((function(_this) {
        return function() {
          return $(_this.app.myConfig.schemeElementImage).draggable({
            helper: "clone",
            start: function(e, ui) {
              _this.app.drawingArea.dragingToSchemeElement = e.srcElement;
              _this.startDx = e.pageX - ui.position.left;
              return _this.startDy = e.pageY - ui.position.top;
            },
            drag: function(event, ui) {
              var imgCoords, snappedCoords;
              snappedCoords = _this.app.drawingArea.SnapToGrid(event.pageX, event.pageY, _this.startDx, _this.startDy);
              imgCoords = _this.app.drawingArea.EnterImageInCanvas(snappedCoords.newClientX, snappedCoords.newClientY, ui.helper[0].width, ui.helper[0].height);
              ui.position.left = imgCoords.x;
              return ui.position.top = imgCoords.y;
            },
            stop: function(event, ui) {
              var canvasCoords, color, countConn, img, newId;
              img = ui.helper[0];
              countConn = 2;
              color = _this.app.drawingArea.GetSelectedColor();
              canvasCoords = _this.app.drawingArea.GetCanvasCoords(ui.position.left, ui.position.top);
              newId = _this.app.schemeData.GetNewID();
              _this.app.schemeData.Add(newId, SchemeElement, new SchemeElement(newId, canvasCoords.canvasX, canvasCoords.canvasY, img.width, img.height, countConn, img, color));
              _this.app.schemeData.LastComponent().obj.PlaceToMap(_this.app.drawingArea.areaMap);
              return _this.app.UpdateArea();
            }
          });
        };
      })(this));
    }

    return EventsHanlerInitializer;

  })();

  this.myConfig = {
    classSchemeElementImage: '.scheme-element-image',
    classPaintSchemeForm: '.paint-scheme-form',
    schemeElementImage: '.scheme-element-image',
    classColorSelector: '.color-selector',
    gridStep: '10',
    canvasId: 'canvas',
    canvasWidth: '600',
    canvasHeight: '400',
    idPaintForm: '1',
    colorOnHover: 'blue'
  };

  $(document).ready((function(_this) {
    return function() {
      _this.drawingArea = new DrawingArea(_this.myConfig);
      _this.schemeData = new SchemeData();
      _this.EventsHanlerInitializer = new EventsHanlerInitializer(_this);
      _this.anim = new Animation();
      _this.anim.UpdateScene(_this.UpdateArea);
      _this.drawingBufferedGrid = function() {
        return _this.drawingArea.DrawGrid(_this.myConfig.gridStep);
      };
      _this.drawingBufferedArea = function() {
        _this.drawingArea.DrawGrid(_this.myConfig.gridStep);
        return _this.drawingArea.DrawSchemeData(_this.schemeData.GetListComponent());
      };
      _this.UpdateArea = function() {
        _this.drawingArea.BufferedDraw('grid', _this.drawingBufferedGrid, 0, 0, _this.myConfig.canvasWidth, _this.myConfig.canvasHeight);
        return _this.drawingArea.DrawSchemeData(_this.schemeData.listComponents);
      };
      return _this.UpdateArea();
    };
  })(this));

  SchemeData = (function() {
    function SchemeData() {
      this.Remove = __bind(this.Remove, this);
      this.GetNewID = __bind(this.GetNewID, this);
      this.GetPositionInArr = __bind(this.GetPositionInArr, this);
      this.GetById = __bind(this.GetById, this);
      this.LastComponent = __bind(this.LastComponent, this);
      this.CountComponent = __bind(this.CountComponent, this);
      this.listComponents = new Array();
    }

    SchemeData.prototype.Add = function(id, type, obj) {
      return this.listComponents.push({
        id: id,
        type: type,
        obj: obj
      });
    };

    SchemeData.prototype.CountComponent = function() {
      return this.listComponents.length;
    };

    SchemeData.prototype.LastComponent = function() {
      return this.listComponents[this.listComponents.length - 1];
    };

    SchemeData.prototype.GetById = function(id) {
      var i, _i, _ref;
      for (i = _i = 0, _ref = this.listComponents.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        if (this.listComponents[i].id === id) {
          return this.listComponents[i];
        }
      }
      return void 0;
    };

    SchemeData.prototype.GetPositionInArr = function(id) {
      var i, _i, _ref;
      for (i = _i = 0, _ref = this.listComponents.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        if (this.listComponents[i].id === id) {
          return i;
        }
      }
      return void 0;
    };

    SchemeData.prototype.GetNewID = function() {
      return this.listComponents.length + 1;
    };

    SchemeData.prototype.Remove = function(id) {
      var pos;
      pos = this.GetPositionInArr(id);
      if (pos !== void 0) {
        return this.listComponents.splice(pos, 1);
      }
    };

    return SchemeData;

  })();

  SchemeElement = (function() {
    SchemeElement.isMouseHover = false;

    function SchemeElement(id, x, y, width, height, CountOfConnections, image, borderColor) {
      this.id = id;
      this.x = x;
      this.y = y;
      this.width = width;
      this.height = height;
      this.CountOfConnections = CountOfConnections;
      this.image = image;
      this.borderColor = borderColor;
      this.DrawShadowRect = __bind(this.DrawShadowRect, this);
      this.IsHorizontalResize = __bind(this.IsHorizontalResize, this);
      this.IsVerticalResize = __bind(this.IsVerticalResize, this);
      this.RemoveFromMap = __bind(this.RemoveFromMap, this);
      this.PlaceToMap = __bind(this.PlaceToMap, this);
      this.Draw = __bind(this.Draw, this);
    }

    SchemeElement.prototype.Draw = function(ctx) {
      var color;
      if (this.isMouseHover) {
        color = myConfig.colorOnHover;
      } else {
        color = this.borderColor;
      }
      this.DrawShadowRect(this.x, this.y, this.width, this.height, color, ctx);
      return ctx.drawImage(this.image, this.x, this.y);
    };

    SchemeElement.prototype.PlaceToMap = function(areaMap) {
      var i, j, lengthByX, lengthByY, startX, startY, _i, _ref, _results;
      lengthByX = Math.round(this.width / areaMap.step);
      lengthByY = Math.round(this.height / areaMap.step);
      startX = Math.round(this.x / areaMap.step);
      startY = Math.round(this.y / areaMap.step);
      _results = [];
      for (i = _i = startX, _ref = startX + lengthByX; startX <= _ref ? _i <= _ref : _i >= _ref; i = startX <= _ref ? ++_i : --_i) {
        _results.push((function() {
          var _j, _ref1, _results1;
          _results1 = [];
          for (j = _j = startY, _ref1 = startY + lengthByY; startY <= _ref1 ? _j <= _ref1 : _j >= _ref1; j = startY <= _ref1 ? ++_j : --_j) {
            _results1.push(areaMap.map[i][j] = this.id);
          }
          return _results1;
        }).call(this));
      }
      return _results;
    };

    SchemeElement.prototype.RemoveFromMap = function(areaMap) {
      var i, j, lengthByX, lengthByY, startX, startY, _i, _ref, _results;
      lengthByX = Math.round(this.width / areaMap.step);
      lengthByY = Math.round(this.height / areaMap.step);
      startX = Math.round(this.x / areaMap.step);
      startY = Math.round(this.y / areaMap.step);
      _results = [];
      for (i = _i = startX, _ref = startX + lengthByX; startX <= _ref ? _i <= _ref : _i >= _ref; i = startX <= _ref ? ++_i : --_i) {
        _results.push((function() {
          var _j, _ref1, _results1;
          _results1 = [];
          for (j = _j = startY, _ref1 = startY + lengthByY; startY <= _ref1 ? _j <= _ref1 : _j >= _ref1; j = startY <= _ref1 ? ++_j : --_j) {
            _results1.push(areaMap.map[i][j] = void 0);
          }
          return _results1;
        })());
      }
      return _results;
    };

    SchemeElement.prototype.IsVerticalResize = function(y) {
      if ((this.y < y + 3 && this.y > y - 3) || (this.y + this.height < y + 3 && this.y + this.height > y - 3)) {
        return true;
      } else {
        return false;
      }
    };

    SchemeElement.prototype.IsHorizontalResize = function(x) {
      if ((this.x < x + 3 && this.x > x - 3) || (this.x + this.width < x + 3 && this.x + this.width > x - 3)) {
        return true;
      } else {
        return false;
      }
    };

    SchemeElement.prototype.DrawShadowRect = function(x, y, w, h, color, ctx) {
      ctx.beginPath();
      ctx.shadowColor = color;
      ctx.shadowBlur = 3;
      ctx.shadowOffsetX = 0;
      ctx.shadowOffsetY = 0;
      ctx.rect(x, y, w, h);
      ctx.closePath();
      return ctx.fill();
    };

    return SchemeElement;

  })();

  SchemeLine = (function() {
    function SchemeLine(coords, borderColor) {
      this.coords = coords;
      this.borderColor = borderColor;
      this.DrawLine = __bind(this.DrawLine, this);
      this.Draw = __bind(this.Draw, this);
    }

    SchemeLine.prototype.Draw = function() {};

    SchemeLine.prototype.DrawLine = function(coords, color) {
      var i, _i, _ref;
      this.context.beginPath();
      for (i = _i = 0, _ref = coords.length - 1; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        this.context.moveTo(coords[i][0], coords[i][1]);
        this.context.lineTo(coords[i + 1][0], coords[i + 1][1]);
      }
      this.context.lineWidth = 2;
      this.context.strokeStyle = color;
      this.context.lineCap = "butt";
      return this.context.stroke();
    };

    return SchemeLine;

  })();

}).call(this);
