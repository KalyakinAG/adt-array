//  Подсистема "Абстрактный тип данных массив"
//	Автор: Калякин Андрей Г.
//  https://github.com/KalyakinAG/adt-array
//  https://infostart.ru/1c/articles/1473034/

// find - поиск элемента коллекции
// 
// Параметры:
//  Элементы - Массив - Коллекция
//  ВыражениеПредиката - Строка - Функция, при вычислении которой для искомого элемента возвращается Истина.
//  Контекст - Любой - Контекст, который может быть использован для вызова функции
//  Параметры - Любой - Параметры, которые могут быть использованы при вычислении функции
// 
// Возвращаемое значение:
//  Произвольный, Неопределено -- Найденный элемент
// Найденный элемент
Функция НайтиЭлемент(Элементы, ВыражениеПредиката, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	Для Каждого Элемент Из Элементы Цикл
		Если Вычислить(ВыражениеПредиката) Тогда
			Возврат Элемент;
		КонецЕсли;
	КонецЦикла;
	Возврат Неопределено;
КонецФункции

// filter
// 
// Параметры:
//  Элементы - Массив - Коллекция
//  ВыражениеПредиката - Строка
//  Контекст - Неопределено - Контекст
//  Параметры - Неопределено - Параметры
// 
// Возвращаемое значение:
//  Массив - Отобрать
Функция Отобрать(Элементы, ВыражениеПредиката, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	НайденныеЭлементы = Новый Массив;
	Для Каждого Элемент Из Элементы Цикл
		Если Вычислить(ВыражениеПредиката) Тогда
			НайденныеЭлементы.Добавить(Элемент);
		КонецЕсли;
	КонецЦикла;
	Возврат НайденныеЭлементы;
КонецФункции

// map
// 
// Параметры:
//  Элементы - Массив - Коллекция
//  Выражение - Строка - Выражение функции
//  Контекст - Неопределено - Контекст
//  Параметры - Неопределено - Параметры
// 
// Возвращаемое значение:
//  Массив - Отобразить
Функция Отобразить(Элементы, Выражение, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	НовыеЭлементы = Новый Массив;
	Для Каждого Элемент Из Элементы Цикл
		НовыеЭлементы.Добавить(Вычислить(Выражение));
	КонецЦикла;
	Возврат НовыеЭлементы;
КонецФункции

// reduce
// 
// Параметры:
//  Элементы - Массив - Коллекция
//  Выражение - Строка - Выражение функции
//  НачальноеЗначение - Неопределено - Начальное значение
//  Контекст - Неопределено - Контекст
//  Параметры - Неопределено - Параметры
// 
// Возвращаемое значение:
//  Произвольный - Преобразовать
Функция Преобразовать(Элементы, Выражение, НачальноеЗначение = Неопределено, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	Накопитель = НачальноеЗначение;
	Для Каждого Элемент Из Элементы Цикл
		Накопитель = Вычислить(Выражение);
	КонецЦикла;
	Возврат Накопитель;
КонецФункции

//  pop
Функция Взять(Элементы) Экспорт
	ВГраница = Элементы.ВГраница();
	Если ВГраница = -1 Тогда
		Возврат Неопределено;
	КонецЕсли;
	Результат = Элементы[ВГраница];
	Элементы.Удалить(ВГраница);
	Возврат Результат;
КонецФункции

//  push
Функция Положить(Элементы, Элемент) Экспорт
	Элементы.Добавить(Элемент);
КонецФункции

//  forEach
Функция ДляКаждого(Элементы, Алгоритм, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	Для Каждого Элемент Из Элементы Цикл
		Выполнить(Алгоритм);
	КонецЦикла;
КонецФункции

// Быстрая сортировка
// http://ru.wikibooks.org/wiki/%D0%9F%D1%80%D0%B8%D0%BC%D0%B5%D1%80%D1%8B_%D1%80%D0%B5%D0%B0%D0%BB%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D0%B8_%D0%B1%D1%8B%D1%81%D1%82%D1%80%D0%BE%D0%B9_%D1%81%D0%BE%D1%80%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%BA%D0%B8
// Реализация взята из публикации https://infostart.ru/1c/articles/204320/ 
// 
// Параметры:
//  Элементы Элементы
//  ВыражениеПредиката - Строка, Неопределено - ВыражениеПредиката
//  Контекст - Неопределено - Контекст
//  НижнийПредел - Число - Нижний предел
//  ВерхнийПредел - Число - Верхний предел
Процедура БыстраяСортировка(Элементы, ВыражениеПредиката, Контекст, Параметры, НижнийПредел, ВерхнийПредел)
    Начало = НижнийПредел;
    Конец = ВерхнийПредел;
    Б = Элементы[Цел((Начало + Конец)/2)];
	Пока Истина Цикл
		А = Элементы[Начало];
        Пока Вычислить(ВыражениеПредиката) < 0 Цикл // Элементы[Начало] < Б
            Начало = Начало + 1;                   
			А = Элементы[Начало];
		КонецЦикла;
		А = Элементы[Конец];
        Пока Вычислить(ВыражениеПредиката) > 0 Цикл // Элементы[Конец] > Б
            Конец = Конец - 1;                   
			А = Элементы[Конец];
        КонецЦикла; 
        Если Начало <= Конец Тогда               
            Значение = Элементы[Начало];
            Элементы[Начало] = Элементы[Конец];
            Элементы[Конец] = Значение;
            Начало = Начало + 1;
            Конец = Конец - 1;            
        КонецЕсли;
        Если Начало > Конец Тогда                       
            Прервать;                        
        КонецЕсли;
	КонецЦикла;
    Если НижнийПредел < Конец Тогда         
        БыстраяСортировка(Элементы, ВыражениеПредиката, Контекст, Параметры, НижнийПредел, Конец);        
	КонецЕсли; 
    Если Начало < ВерхнийПредел Тогда                      
        БыстраяСортировка(Элементы, ВыражениеПредиката, Контекст, Параметры, Начало, ВерхнийПредел);        
    КонецЕсли;
КонецПроцедуры

// Сравнить.
// 
// Параметры:
//  А - Любой - сравнимаемое значение 1  
//  Б - Любой - сравнимаемое значение 2
// 
// Возвращаемое значение:
//  Число - меньше 0, сортировка поставит 1-ое значение по меньшему индексу, чем 2-ое, 
//			равно 0, сортировка не меняет индексы значений,
//			больше 0, сортировка поставит 2-ое значение по меньшему индексу, чем 1-ое 
Функция Сравнить(А, Б) Экспорт
	Если А = Б Тогда
		Возврат 0;
	КонецЕсли;
	Если А < Б Тогда
		Возврат -1;
	КонецЕсли;
	Возврат 1;
КонецФункции

Функция СравнитьПо(А, Б, Поля) Экспорт
	Для Каждого Поле Из СтрРазделить(Поля, ", ", Ложь) Цикл
		Результат = Сравнить(А[Поле], Б[Поле]);
		Если Результат < 0 Тогда
			Возврат -1;
		ИначеЕсли Результат > 0 Тогда
			Возврат 1;
		КонецЕсли;
	КонецЦикла;
	Возврат 0;
КонецФункции

//  sortBy
Процедура СортироватьПо(Элементы, Знач Поля) Экспорт
	ВыражениеПредиката = СтрШаблон("СравнитьПо(А, Б, ""%1"")", Поля);
	БыстраяСортировка(Элементы, ВыражениеПредиката, , , 0, Элементы.ВГраница());
КонецПроцедуры

//  sort
Процедура Сортировать(Элементы, Знач ВыражениеПредиката = Неопределено, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	ВыражениеПредиката = ?(ЗначениеЗаполнено(ВыражениеПредиката), ВыражениеПредиката, "Сравнить(А, Б)");
	БыстраяСортировка(Элементы, ВыражениеПредиката, Контекст, Параметры, 0, Элементы.ВГраница());
КонецПроцедуры

// Дополняет массив МассивПриемник значениями из массива МассивИсточник.
//
// Параметры:
//  МассивПриемник - Массив - массив, в который необходимо добавить значения.
//  МассивИсточник - Массив - массив значений для заполнения.
//  ТолькоУникальныеЗначения - Булево - если истина, то в массив будут включены только уникальные значения.
//
Процедура ДополнитьМассив(МассивПриемник, МассивИсточник, ТолькоУникальныеЗначения = Ложь) Экспорт
	
	Если ТолькоУникальныеЗначения Тогда
		
		УникальныеЗначения = Новый Соответствие;
		
		Для Каждого Значение Из МассивПриемник Цикл
			УникальныеЗначения.Вставить(Значение, Истина);
		КонецЦикла;
		
		Для Каждого Значение Из МассивИсточник Цикл
			Если УникальныеЗначения[Значение] = Неопределено Тогда
				МассивПриемник.Добавить(Значение);
				УникальныеЗначения.Вставить(Значение, Истина);
			КонецЕсли;
		КонецЦикла;
		
	Иначе
		
		Для Каждого Значение Из МассивИсточник Цикл
			МассивПриемник.Добавить(Значение);
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

Функция АТДМассив(Элементы = Неопределено) Экспорт
	#Если Клиент Тогда
        АТДМассив = ПолучитьФорму("Обработка.АТДМассив.Форма.Форма");
    #Иначе
        АТДМассив = Обработки.АТДМассив.Создать();
    #КонецЕсли
	Если Элементы <> Неопределено Тогда
		АТДМассив.Установить(Элементы);
	КонецЕсли;
	Возврат АТДМассив;
КонецФункции
