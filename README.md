# openCompAstralCrystalGrower
grows perfect crystals from astral sorcery mod

https://pixeldrain.com/api/file/4E5r9E6V
https://pixeldrain.com/api/file/y2jfLQbF
https://pixeldrain.com/api/file/zq3uiMVr
https://pixeldrain.com/api/file/tzj3Um4D

Установка состоит из компьютера, транспозера, редсотун IO, детектора наличия жидкости, установщика жидкости, дропера, вакуумной воронки, хранилища и нескольких сундуков

Компьютер спит 10 секунд, затем смотрит на редстоун сигнал на входе редстоун IO

[if statement] если сигнала нет - компьютер возвращается в сон на 10 секунд

[else statement] если сигнал есть - компьютер проверяет, есть ли предмет в vacoom hopper

  [if statement] если нет - уходит в сон на 5 секунд, и если опять нету - бросает ошибку "Утерян кристалл"

  [else statement] в случае если кристалл есть, продолжаем

Сверяет кристалл с экземпляром в одном из сундуков


