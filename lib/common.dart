import 'dart:convert';

import 'package:flutter/material.dart';

const appTitle = 'Advent of Code 2024';

const settingsTitle = 'Advent of Code 2024 Settings';

const drawerTitle = 'Day Selection';

final elfImage = Image.memory(
    width: 17,
    height: 35,
    base64Decode(
        'iVBORw0KGgoAAAANSUhEUgAAABEAAAAjCAYAAABy3+FcAAAACXBIWXMAAC4jAAAuIwF4pT92AAAB'
        '50lEQVRIS51VvU4CQRCe40iws1J5AhoDrRQmWuADGBJL+vOBsLe08QGkkMQCW0hM5AkQjQmdFse6'
        'szDLzN7u7eEml/uZ+b795mfnAP65ptBSBK3ty3EyBUUEdE+qkiCY+z51WtCBucEHSZTaYJqzRIDx'
        '20dH4rzhMIIvV6lLUKrEle9TUJpYH0FZ7grhbEP59oEoTNdWSGxMBeUECZNkAy+Q8CYKhYClDZJU'
        'ISBi6hGhZB8Cl6juk9we3QeLMesNrI0SLXKCaohgfHhmnC9Wr8Cf8RsStdW7xYoSuwouByu7K39G'
        'P6zMer02l1CiRpPCOQnFlfS6SZ7n/hJXIUICTh6cJy8Pj0KE+05GVOOtDjqc31wDB+K7b6VpKnOC'
        'LY/DJlbiq+nc8NERMLH5phY6LpYTu3nzuAu4ARGQAYnqZQcOgbGFeJHYz7tGDGPsrp8l4QaUjNL5'
        'ckPh/kLJUfZbSYnrV7fJ6+vJDvEc2P7ojwGWmzejJNRIMVmEE82my2WXHjqg/07BdxjtbGLM6c+V'
        'D6D2tefHKGE/q1gEZF8t2rv99p72yFLpN8rl6B3djd5cuaY6GE4ta+ibAg9IYLSKU1PWrPGM/njx'
        '6uTp7cE2UNb+Q9nmtayYfKME52U+/AnOFl+2tb8N8w9ljc/ndA1KZgAAAABJRU5ErkJggg=='));

final elfWalk = [
  Image.memory(
      height: 35,
      base64Decode(
          'iVBORw0KGgoAAAANSUhEUgAAABQAAAAjCAYAAACU9ioYAAAACXBIWXMAAC4jAAAuIwF4pT92AAAB'
          'x0lEQVRIS+WVvU7DMBDHzy0COiA2YGNB3cjcASSGvAALY0ckVhbegrU7I0sfgGxlQOpWJj4WxARI'
          'SBVDQagJPteXOvHZcSgblqw2yfnn+5/vzgD/ZoygnaFY8VvFmyO1UkGuonaOqQ00QUh5iWZOoYcR'
          '3ItaQAlLS6qEBBZGI1SyhKG83IG1cRO9s0YQcGfQVLGigTBX/CuBCPtYn1qefA+XWXHeGGqZvqhY'
          'Maw8FMovhirkqdaLYZbcZO/DO8C5m1yUFxfiSh+dMUQYGh10xzmIgVoespIJ5grebdxVnzCRyzYu'
          'D9EwN76+7IemKyxxliLuqNeD4zP1u3d0aJlx3jmT01zNyZcbOrOjMrFR+tZGB3Difx8syEMzubHk'
          'Hven3tytXSlV0BDJoJtB0Ek7gST1rbeiQNSVuUZh7uQEmm29ChIE9Okr98eFgb7NWMkymb0HUCcE'
          'gDBdcthtMqwUmvhsTHZT1sNy7S7UHKgx6PsX4HXuCL3Tyc166K2U7fNW9hlPrIV0uXNEb6U8nU7E'
          'atL6m0qh3dFDvDKN8vOqKnjYOJmVGQ35rO6V54cUzFTJ48to9u+mgdy6tPcVnjZkKRepDV2LOeIP'
          'xsCasVWTJKIAAAAASUVORK5CYII=')),
  Image.memory(
      height: 35,
      base64Decode(
          'iVBORw0KGgoAAAANSUhEUgAAABQAAAAjCAYAAACU9ioYAAAACXBIWXMAAC4jAAAuIwF4pT92AAAB'
          'v0lEQVRIS82VvU7DMBDHnRaoGFBZECML6kY2RAeQGMoDICTGjpX6MqzdGVl4ALJUdEBiK1vFC/Cx'
          'REwFivE/0lXOxfY5ZcFSlES5++V/X7ZS/3FNVUeTrsZfBO5OlSYY3ZNVgADZfndpR6VqVrBqATkI'
          'gJe0zIgO2cDeeTQcFq0wRll0UVywUN7FkLfyZq26BYsiqVsphzp70E+9fkUltQn/EFQImO3AwS6o'
          'mMNx+0jhwjrIrsV8eoGk7rSfixDbwBkyD5UTKfTokJNeN8FFoMnNbXRR1kLxEOj48rxk5qtw1Ojx'
          '8G3ltZJrG6PBpSYne3H74iDXdIhVJgOfqhDU24cGprATY9XdIJy5xRkBhY1hq7jTu5RLcfRcf5Og'
          'ToU+dVRx005OP6/Ct1FL7QznRR7PpjOXc2knIgPvpCwuxkq9GrMMJ1u3ApwMquMIo2AOXTNMZD6O'
          'okIuCW1krTxJu9uuPAQnZe9qU68ffqqP9mLpK01KJWT0HbxRTcC+HjdqNXZJoYGBpVFdWqRo/76p'
          'SWnt0UPLYMGRFD+fLJY/Z/kspbKSQwLA6mc0B/DbPPLTPjHf4hobENvSvAd3dU79BW97rHVR/ACS'
          'AAAAAElFTkSuQmCC')),
  Image.memory(
      height: 35,
      base64Decode(
          'iVBORw0KGgoAAAANSUhEUgAAABQAAAAjCAYAAACU9ioYAAAACXBIWXMAAC4jAAAuIwF4pT92AAAB'
          'iklEQVRIS+WVrU4DQRDHd1ugilQgeAFSxzkCAhLEvQAGWY/lZeqRmD4ANQQECa44gkHyYRpE+Qgc'
          'O0dmGZadjzskl1xyucz88v/PzM469y+eqRtUaNS3cbw6dRFwUgwionDXvhGQgpByVzgPCgEG/8zA'
          'AHsM8SvUEcBShyYgpyxXro5Ww7WzbqwXxi7PumyaqDCn7M+Wq8lFdVUOfynCJjSqIcBoQgrOQdUa'
          'nvY3HbzwrE+OtJI7FojqdoczFUIDsk1JraZEtG627MstDy+Czo/H5qYsSH4QtL2/9yOM67Dp6KX2'
          'qfJGxaXBMODakJvXVwrKLQS1yxjAqZKg6mADXFoGaR1V4MOoV+fQzSw1gwXSe+Kp/25uqKowR5I6'
          '3grYyrLZYxIobex6F4aTElPCKVFHzmQ5txw4B+xyCIX/eu6/U/EfzOXNTr7zjS4pAL1dLrnbwzmb'
          'J1qmJwRhixuvYr9EYLAVlYAygGlDzgI7B71448Hxey7nNaz1tqHA1OPH6KV5DWlS+DbP+SdqLYKb'
          'y86RuQAAAABJRU5ErkJggg==')),
  Image.memory(
      height: 35,
      base64Decode(
          'iVBORw0KGgoAAAANSUhEUgAAABQAAAAjCAYAAACU9ioYAAAACXBIWXMAAC4jAAAuIwF4pT92AAAB'
          'sUlEQVRIS82WsU4CQRCGB1CpDJXxBQid1xktNLHAB7CxpDThCXwUeksbH0Aag4WJHXbEF0BtiBXo'
          'ed5PMro3O7uzYOMmm4O72e/+f2dmc0T/cYypU7Cu+l8E7o6pYBhfa+sAAXLX3WYdymiyZK0ElCAA'
          'plmVkWy5hL1JNxKWrDBFWXJSNNj2rBHcetOyXByDmZY1da60tfawGD4UT92eZ5HLRD6Ilg1g7gIJ'
          '1qDmHt61DggTY294ZfZBEMjqTnozE+IGqJalVUlk68mWa93DGiaD7q9vNJWqmI2YHwYdnZ9VwkIZ'
          'NusQAdK+q3ylzXWDUeBWkXO8eXxJkNYdZpY5IKQqBg3WoQuzDgRXYRCIYx3jddCk91ZO/N9KhNl6'
          'GiCWIBO4058vVZ6OJ0kqVaDVepbtynPARheXOLZ+Ju7xdO6rXFWhbDWsDPSzB/V6mVursvEvv+va'
          'owayPitrUR3RTpG1+PG4RZv7C3o+zoPrPMv1fnN57IdgqMnYqFjWYGizKeXUHi0KC4YXqUlB3WEA'
          'xi9xbcYK29sLBgD4NZgD+Fn+9D4V8Eyz7inkQOcaPdUl9BscobWnAQTXFwAAAABJRU5ErkJggg==')),
];
