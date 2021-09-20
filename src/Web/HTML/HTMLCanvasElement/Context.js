"use strict";

exports.scale = function (x) {
  return function (y) {
    return function (ctx2d) {
      return function () {
        ctx2d.scale(x, y);
      };
    };
  };
};

exports.translate = function (x) {
  return function (y) {
    return function (ctx2d) {
      return function () {
        ctx2d.translate(x, y);
      };
    };
  };
};

exports.drawImage = function (img) {
  return function (dx) {
    return function (dy) {
      return function (ctx2d) {
        return function () {
          ctx2d.drawImage(img, dx, dy);
        };
      };
    };
  };
};

exports.beginPath = function (ctx2d) {
  return function () {
    ctx2d.beginPath();
  };
};

exports.strokeStyle = function (str) {
  return function (ctx2d) {
    return function () {
      ctx2d.strokeStyle = str;
    };
  };
};

exports.moveTo = function (x) {
  return function (y) {
    return function (ctx2d) {
      return function () {
        ctx2d.moveTo(x, y);
      };
    };
  };
};

exports.lineTo = function (x) {
  return function (y) {
    return function (ctx2d) {
      return function () {
        ctx2d.lineTo(x, y);
      };
    };
  };
};

exports.lineWidth = function (w) {
  return function (ctx2d) {
    return function () {
      ctx2d.lineWidth = w;
    };
  };

};

exports.stroke = function (ctx2d) {
  return function () {
    ctx2d.stroke();
  };
};


exports.getImageData = function (sx) {
  return function (sy) {
    return function (sw) {
      return function (sh) {
        return function (ctx2d) {
          return function () {
            return ctx2d.getImageData(sx, sy, sw, sh);
          };
        };
      };
    };
  };
};


exports.createImageData = function (w) {
  return function (h) {
    return function (ctx2d) {
      return function () {
        return ctx2d.createImageData(w, h);
      };
    };
  };
};

exports.putImageData = function (dx) {
  return function (dy) {
    return function (ctx2d) {
      return function () {
        ctx2d.putImageData(dx, dy);
      };
    };
  };
};
