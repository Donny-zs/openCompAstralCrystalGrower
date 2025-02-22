# openCompAstralCrystalGrower
grows perfect crystals from astral sorcery mod
made for Enigmatica 2 extended expert 1.12.2

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

Проверяет все предметы в vacoom hopper, составляет таблицу
Сверяет кристалл с экземпляром в одном из сундуков,
Если это единственный кристалл - наливает жидкость, проверяет что жидкость налилась, если нет 
кидает ошибку - "Out of starlight"

кидает кристалл в жидкость

