"use strict";

exports.data_ = function (imgData) {
  return function () {
    return imgData.data;
  };
};

exports.height = function (imgData) {
  return function () {
    return imgData.height;
  };
};

exports.width = function (imgData) {
  return function () {
    return imgData.width;
  };
};
