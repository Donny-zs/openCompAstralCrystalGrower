# openCompAstralCrystalGrower
grows perfect crystals from astral sorcery mod
made for Enigmatica 2 extended expert 1.12.2

https://pixeldrain.com/api/file/4E5r9E6V
https://pixeldrain.com/api/file/y2jfLQbF
https://pixeldrain.com/api/file/zq3uiMVr
https://pixeldrain.com/api/file/tzj3Um4D

prompt:
я написал псевдокод для мода игры minecraft под названием opencomputers, этот код управляет установкой которая может работать в полуавтоматическом режиме, а задача компьютера - автоматизировать процесс. Суть процесса - некий кристалл помещается в некоторую жидкость, спустя случайное время кристалл потребляет жидкость и случайным образом увеличивает свои характеристики, если кристалл с максимальными характеристиками помещён в жидкость то он разделится на два кристалла. Установка сконструирована таким образом что она подаёт сигнал когда жидкость находится на месте, и не подаёт сигнал когда жидкость отсутствует. Этот сигнал может быть считан компьютером через redstone IO, а так же управляет vacoom hopper который благодаря этому автоматически забирает кристалл как только тот улучшился. Задача компьютера - сверять кристалл с образцовым кристаллом который лежит в 27 слоте vacoom hopper, и отправлять единичный экземпляр кристалла на улучшение в жидкость, помещая его в сундук на стороне 1 от transposer, либо если кристаллов несколько, и один из них соответствует эталону - отправить эталон в хранилище.
Вот псевдокод для этой задачи:

Установка состоит из компьютера, транспозера, редсотун IO, детектора наличия жидкости, установщика жидкости, дропера, вакуумной воронки, хранилища и нескольких сундуков

Компьютер спит 10 секунд, затем смотрит на редстоун сигнал на входе редстоун IO

[if statement] если сигнал есть - компьютер возвращается в сон на 10 секунд

[else statement] если сигнала нет - компьютер проверяет, есть ли предмет в vacoom hopper

  [if statement] если предмета нет - уходит в сон на 5 секунд, и если опять нету - бросает ошибку "Crystal lost"

  [else statement] в случае если кристалл есть, продолжаем

Проверяет все предметы в vacoom hopper, составляет таблицу

Сверяет кристалл(ы) с экземпляром в одном из сундуков,

Если это единственный кристалл - 
Bath()

Если кристаллов больше одного -
Если среди них есть perfect (совпал) - отправялет в хранилище
Bath()

засыпает на 10 секунд

[function Bath()] {

  наливает жидкость,
  спит 
  проверяет что жидкость налилась , 
  если нет кидает ошибку - "Out of starlight"
  кидает кристалл в жидкость

}
