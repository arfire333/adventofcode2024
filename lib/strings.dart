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
