//  Подсистема "Абстрактный тип данных массив"
//	Автор: Калякин Андрей Г.
//  https://github.com/KalyakinAG/adt-array
//  https://infostart.ru/1c/articles/1473034/

//@skip-check server-execution-safe-mode
//@skip-check module-unused-local-variable
#Область ПрограммныйИнтерфейс

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
Функция НайтиЭлемент(Элементы, ВыражениеПредикатаБезОбработки, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	ВыражениеПредиката = СтрЗаменить(ВыражениеПредикатаБезОбработки, "'", """");
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
Функция Отобрать(Элементы, ВыражениеПредикатаБезОбработки, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	НайденныеЭлементы = Новый Массив;
	ВыражениеПредиката = СтрЗаменить(ВыражениеПредикатаБезОбработки, "'", """");
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
Функция Отобразить(Элементы, ВыражениеБезОбработки, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	Выражение = СтрЗаменить(ВыражениеБезОбработки, "'", """");
	НовыеЭлементы = Новый Массив;
	Если ТипЗнч(Элементы) = Тип("Массив") Тогда
		Для Индекс = 0 По Элементы.ВГраница() Цикл
			Элемент = Элементы[Индекс];
			НовыеЭлементы.Добавить(Вычислить(Выражение));
		КонецЦикла;
	Иначе
		Для Каждого Элемент Из Элементы Цикл
			НовыеЭлементы.Добавить(Вычислить(Выражение));
		КонецЦикла;
	КонецЕсли;
	Возврат НовыеЭлементы;
КонецФункции

//  flat
Функция Спрямить(Элементы, Глубина = Неопределено) Экспорт
	СледующаяГлубина = ?(Глубина = Неопределено, Неопределено, Глубина - 1);
	НовыеЭлементы = Новый Массив;
	Для Каждого Элемент Из Элементы Цикл
		Если ТипЗнч(Элемент) = Тип("Массив") И (СледующаяГлубина = Неопределено ИЛИ СледующаяГлубина >= 0) Тогда
			ОбщегоНазначенияКлиентСервер.ДополнитьМассив(НовыеЭлементы, Спрямить(Элемент, СледующаяГлубина));
			Продолжить;
		КонецЕсли;
		НовыеЭлементы.Добавить(Элемент);
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
Функция Преобразовать(Элементы, ВыражениеБезОбработки, НачальноеЗначение = Неопределено, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	Выражение = СтрЗаменить(ВыражениеБезОбработки, "'", """");
	Накопитель = НачальноеЗначение;
	Для Каждого Элемент Из Элементы Цикл
		Накопитель = Вычислить(Выражение);
	КонецЦикла;
	Возврат Накопитель;
КонецФункции

//  last
Функция Последний(Элементы) Экспорт
	ВГраница = Элементы.ВГраница();
	Если ВГраница = -1 Тогда
		Возврат Неопределено;
	КонецЕсли;
	Результат = Элементы[ВГраница];
	Возврат Результат;
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
Функция ДляКаждого(Элементы, АлгоритмБезОбработки, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	Алгоритм = СтрЗаменить(АлгоритмБезОбработки, "'", """");
	Для Каждого Элемент Из Элементы Цикл
		//@skip-check unsupported-operator
		Выполнить(Алгоритм);
	КонецЦикла;
КонецФункции

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
Процедура Сортировать(Элементы, Знач ФункцияСравненияБезОбработки = Неопределено, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	ФункцияСравнения = ?(ЗначениеЗаполнено(ФункцияСравненияБезОбработки), ФункцияСравненияБезОбработки, "Сравнить(А, Б)");
	ФункцияСравнения = СтрЗаменить(ФункцияСравнения, "'", """");
	БыстраяСортировка(Элементы, ФункцияСравнения, Контекст, Параметры, 0, Элементы.ВГраница());
КонецПроцедуры

Процедура СортироватьЭлементыКоллекции(ЭлементыКоллекции, Знач ФункцияСравненияБезОбработки = Неопределено, СортироватьВложенные = Истина) Экспорт
	ФункцияСравнения = ?(ЗначениеЗаполнено(ФункцияСравненияБезОбработки), ФункцияСравненияБезОбработки, "Сравнить(А.Наименование, Б.Наименование)");
	ФункцияСравнения = СтрЗаменить(ФункцияСравнения, "'", """");
	Если ЭлементыКоллекции.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	Если СортироватьВложенные Тогда
		Для Каждого ЭлементДерева Из ЭлементыКоллекции Цикл
			СортироватьЭлементыКоллекции(ЭлементДерева.ПолучитьЭлементы(), ФункцияСравнения, СортироватьВложенные);
		КонецЦикла;
	КонецЕсли;
	СортироватьЭлементы(ЭлементыКоллекции, ФункцияСравнения, 0, ЭлементыКоллекции.Количество() - 1);
КонецПроцедуры

// Выполняет пропорциональное распределение суммы в соответствии
// с заданными коэффициентами распределения.
// Используется рекурсивный алгоритм с уменьшением базы. Допускается использование только положительных чисел.
//
// Параметры:
//  РаспределяемаяСумма - Число  - сумма, которую надо распределить. Сумма должна соответствовать определенной точности.
//  Коэффициенты        - Массив - коэффициенты распределения
//  Точность            - Число  - точность округления при распределении. Необязателен.
//
// Возвращаемое значение:
//  Массив - массив размерностью равный массиву коэффициентов, содержит
//           суммы в соответствии с весом коэффициента (из массива коэффициентов).
//           В случае, если распределить невозможно (кол-во коэффициентов = 0
//           есть коэффициенты с отрицательным значением или суммарный вес коэффициентов = 0),
//           тогда будет возвращено Неопределено.
//
// Пример:
//
//	Коэффициенты = Новый Массив;
//	Коэффициенты.Добавить(1);
//	Коэффициенты.Добавить(2);
//	Результат = РаспределитьСумму(1, Коэффициенты);
//	// Результат = [0.33, 0.67]
//
Функция РаспределитьСумму(Знач РаспределяемаяСумма, Знач Коэффициенты, Знач Точность = 2) Экспорт
	Если Коэффициенты.Количество() = 0 ИЛИ РаспределяемаяСумма = 0 Тогда
		Возврат Неопределено;
	КонецЕсли;
	НужноИнвертироватьРезультат = Ложь;
	Если РаспределяемаяСумма < 0 Тогда
		РаспределяемаяСумма = -РаспределяемаяСумма;
		НужноИнвертироватьРезультат = Истина;
	КонецЕсли;
	КоэффициентыОтрицательны = (Коэффициенты[0] < 0);
	КоэффициентыРаспределения = Новый Массив(Новый ФиксированныйМассив(Коэффициенты)); // Копируем массив в памяти.
	СуммаКоэффициентов = 0;
	Для Индекс = 0 По КоэффициентыРаспределения.Количество() - 1 Цикл
		Коэффициент = КоэффициентыРаспределения[Индекс];
		Если КоэффициентыОтрицательны Тогда
			Если Коэффициент > 0 Тогда
				Возврат Неопределено;
			КонецЕсли;
		Иначе
			Если Коэффициент < 0 Тогда
				Возврат Неопределено;
			КонецЕсли;
		КонецЕсли;
		СуммаКоэффициентов = СуммаКоэффициентов + Коэффициент;
	КонецЦикла;
	
	Если СуммаКоэффициентов = 0 Тогда
		Возврат Неопределено;
	КонецЕсли;

	Результат = Новый Массив(КоэффициентыРаспределения.Количество());
	
	ОстатокРаспределения = РаспределяемаяСумма;
	
	Для Индекс = 0 По КоэффициентыРаспределения.Количество() - 1 Цикл
		Если ОстатокРаспределения = 0 Тогда
			Результат[Индекс] = 0;
			Продолжить;
		КонецЕсли;
		Коэффициент = КоэффициентыРаспределения[Индекс];
		СуммаРаспределения = Мин(ОстатокРаспределения, Окр(ОстатокРаспределения * Коэффициент / СуммаКоэффициентов, Точность, 1));
		Результат[Индекс] = СуммаРаспределения;
		СуммаКоэффициентов = СуммаКоэффициентов - Коэффициент;
		ОстатокРаспределения = ОстатокРаспределения - СуммаРаспределения;
	КонецЦикла;
	
	Если ОстатокРаспределения <> 0 Тогда
		ВызватьИсключение "Не удалось распределить сумму";
	КонецЕсли;
	
	Если НужноИнвертироватьРезультат Тогда
		Для Индекс = 0  По Результат.ВГраница() Цикл
			Результат[Индекс] = -Результат[Индекс]; 
		КонецЦикла;		
	КонецЕсли;
	Возврат Результат;
КонецФункции

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

Функция СкопироватьМассив(МассивИсточник) Экспорт
	МассивРезультат = Новый Массив;
	Для Каждого Элемент Из МассивИсточник Цикл
		МассивРезультат.Добавить(Элемент);
	КонецЦикла;
	Возврат МассивРезультат;
КонецФункции

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

// Положить в очередь с приоритетом.
// 
// Параметры:
//  Очередь - Массив - элемнты очереди, по-умолчанию отсортированы от меньшего к большему
//  Элемент - Любой - 
//  ФункцияСравнения - Строка - Выражение предиката
Процедура ПоложитьВОчередьСПриоритетом(Очередь, Элемент, ФункцияСравнения = "Сравнить(А, Б)", Контекст = Неопределено, Параметры = Неопределено) Экспорт
	ИндексЭлемента = НайтиИндексЭлементаОчередиСПриоритетом(Очередь, Элемент, 0, Очередь.Количество(), ФункцияСравнения, Контекст, Параметры);
	Очередь.Вставить(ИндексЭлемента, Элемент);
КонецПроцедуры

#КонецОбласти

//@skip-check server-execution-safe-mode
//@skip-check module-unused-local-variable
#Область СлужебныеПроцедурыИФункции

// Быстрая сортировка
// http://ru.wikibooks.org/wiki/%D0%9F%D1%80%D0%B8%D0%BC%D0%B5%D1%80%D1%8B_%D1%80%D0%B5%D0%B0%D0%BB%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D0%B8_%D0%B1%D1%8B%D1%81%D1%82%D1%80%D0%BE%D0%B9_%D1%81%D0%BE%D1%80%D1%82%D0%B8%D1%80%D0%BE%D0%B2%D0%BA%D0%B8
// Реализация взята из публикации https://infostart.ru/1c/articles/204320/ 
// 
// Параметры:
//  Элементы - Массив
//  ФункцияСравнения - Строка, Неопределено - ФункцияСравнения
//  Контекст - Неопределено - Контекст
//  НижнийПредел - Число - Нижний предел
//  ВерхнийПредел - Число - Верхний предел
Процедура БыстраяСортировка(Элементы, ФункцияСравнения, Контекст, Параметры, НижнийПредел, ВерхнийПредел)
	Если НЕ ЗначениеЗаполнено(Элементы) Тогда
		Возврат;
	КонецЕсли;
    Начало = НижнийПредел;
    Конец = ВерхнийПредел;
    Б = Элементы[Цел((Начало + Конец)/2)];
	Пока Истина Цикл
		А = Элементы[Начало];
        Пока Вычислить(ФункцияСравнения) < 0 Цикл // Элементы[Начало] < Б
            Начало = Начало + 1;                   
			А = Элементы[Начало];
		КонецЦикла;
		А = Элементы[Конец];
        Пока Вычислить(ФункцияСравнения) > 0 Цикл // Элементы[Конец] > Б
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
        БыстраяСортировка(Элементы, ФункцияСравнения, Контекст, Параметры, НижнийПредел, Конец);        
	КонецЕсли; 
    Если Начало < ВерхнийПредел Тогда                      
        БыстраяСортировка(Элементы, ФункцияСравнения, Контекст, Параметры, Начало, ВерхнийПредел);        
    КонецЕсли;
КонецПроцедуры

// Найти индекс элемента очереди с приоритетом.
// 
// Параметры:
//  Очередь - Массив - элементы очереди, по-умолчанию отсортированы от меньшего к большему
//  Элемент - Любой - 
//  ИндексНачала - Число - Индекс начала
//  ИндексОкончания - Число - Индекс окончания
//  ФункцияСравнения - Строка - Выражение предиката
// 
// Возвращаемое значение:
//  Число - Найти индекс элемента очереди с приоритетом
Функция НайтиИндексЭлементаОчередиСПриоритетом(Очередь, Элемент, ИндексНачала, ИндексОкончания, ФункцияСравнения, Контекст = Неопределено, Параметры = Неопределено)
	Если ИндексНачала = ИндексОкончания Тогда
		Возврат ИндексНачала;
	КонецЕсли;
	ИндексСередины = Окр((ИндексНачала + ИндексОкончания) / 2, 0, 0);
	Если ИндексСередины = ИндексОкончания Тогда
		Возврат ИндексОкончания;
	КонецЕсли;
	А = Очередь[ИндексСередины];//@skip-check module-unused-local-variable
	Б = Элемент;//@skip-check module-unused-local-variable
	Если Вычислить(ФункцияСравнения) > 0 Тогда
		Возврат НайтиИндексЭлементаОчередиСПриоритетом(Очередь, Элемент, ИндексНачала, ИндексСередины, ФункцияСравнения, Контекст, Параметры);
	Иначе
		Возврат НайтиИндексЭлементаОчередиСПриоритетом(Очередь, Элемент, ИндексСередины + 1, ИндексОкончания, ФункцияСравнения, Контекст, Параметры);
	КонецЕсли;
КонецФункции

Процедура СортироватьЭлементы(Элементы, ВыражениеПредиката, НижнийПредел, ВерхнийПредел)
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
            //  Дерево значений
            //  Начало -> Конец
            //  Конец -> Начало 
			ШагСдвига = Конец - Начало;
			Если НЕ ШагСдвига = 0 Тогда
				Элементы.Сдвинуть(Начало, ШагСдвига);
				ШагСдвига = ШагСдвига - 1;
				Если НЕ ШагСдвига = 0 Тогда
					Элементы.Сдвинуть(Конец - 1, -ШагСдвига);
				КонецЕсли;
			КонецЕсли;
            //  Дерево значений            
            Начало = Начало + 1;
            Конец = Конец - 1;            
        КонецЕсли;
        Если Начало > Конец Тогда                       
            Прервать;                        
        КонецЕсли;
	КонецЦикла;
    Если НижнийПредел < Конец Тогда         
        СортироватьЭлементы(Элементы, ВыражениеПредиката, НижнийПредел, Конец);        
	КонецЕсли; 
    Если Начало < ВерхнийПредел Тогда                      
        СортироватьЭлементы(Элементы, ВыражениеПредиката, Начало, ВерхнийПредел);        
    КонецЕсли;
КонецПроцедуры

#КонецОбласти