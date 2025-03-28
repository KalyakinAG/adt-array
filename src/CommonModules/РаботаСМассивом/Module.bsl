//  Подсистема "Абстрактный тип данных массив"
//	Автор: Калякин Андрей Г.
//  https://github.com/KalyakinAG/adt-array
//  https://infostart.ru/1c/articles/1473034/

//@skip-check server-execution-safe-mode
//@skip-check module-unused-local-variable
#Область ПрограммныйИнтерфейс

Функция ПривестиСтроку(Строка)
	Возврат ?(Лев(Строка, 1) = "!", Прав(Строка, СтрДлина(Строка) - 1), СтрЗаменить(Строка, "'", """"));
КонецФункции

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
	ВыражениеПредиката = ПривестиСтроку(ВыражениеПредикатаБезОбработки);
	Для Каждого Элемент Из Элементы Цикл
		Если Вычислить(ВыражениеПредиката) Тогда
			Возврат Элемент;
		КонецЕсли;
	КонецЦикла;
	Возврат Неопределено;
КонецФункции

Функция Индекс(Элементы, ВыражениеПредикатаБезОбработки, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	ВыражениеПредиката = ПривестиСтроку(ВыражениеПредикатаБезОбработки);
	Для Индекс = 0 По Элементы.Количество() - 1 Цикл
		Элемент = Элементы[Индекс];
		Если Вычислить(ВыражениеПредиката) Тогда
			Возврат Индекс;
		КонецЕсли;
	КонецЦикла;
	Возврат Неопределено;
КонецФункции

// Найти элемент в очереди с приоритетом. Проверят наличие элемента в очереди с приоритетом
// 
// Параметры:
//  Очередь - Массив - элементы очереди, по-умолчанию отсортированы от меньшего к большему
//  Элемент - Любой - 
//  ИндексНачала - Число - Индекс начала
//  ИндексОкончания - Число - Индекс окончания
//  ФункцияСравнения - Строка - Выражение предиката
// 
// Возвращаемое значение:
//  Булево - Истина - элемент найден
Функция НайтиЭлементОчередиСПриоритетом(Очередь, Элемент, ИндексНачала, ИндексОкончания, ФункцияСравнения, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	Если ИндексНачала = ИндексОкончания Тогда
		Возврат Ложь;
	КонецЕсли;
	ИндексСередины = Окр((ИндексНачала + ИндексОкончания) / 2, 0, 0);
	Если ИндексСередины = ИндексОкончания Тогда
		Возврат Ложь;
	КонецЕсли;
	А = Очередь[ИндексСередины];//@skip-check module-unused-local-variable
	Б = Элемент;//@skip-check module-unused-local-variable
	Результат = Вычислить(ФункцияСравнения);
	Если Результат = 0 Тогда
		Возврат Истина;
	ИначеЕсли Результат > 0 Тогда
		Возврат НайтиЭлементОчередиСПриоритетом(Очередь, Элемент, ИндексНачала, ИндексСередины, ФункцияСравнения, Контекст, Параметры);
	Иначе
		Возврат НайтиЭлементОчередиСПриоритетом(Очередь, Элемент, ИндексСередины + 1, ИндексОкончания, ФункцияСравнения, Контекст, Параметры);
	КонецЕсли;
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
	ВыражениеПредиката = ПривестиСтроку(ВыражениеПредикатаБезОбработки);
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
	Выражение = ПривестиСтроку(ВыражениеБезОбработки);
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
			ДополнитьМассив(НовыеЭлементы, Спрямить(Элемент, СледующаяГлубина));
			Продолжить;
		КонецЕсли;
		НовыеЭлементы.Добавить(Элемент);
	КонецЦикла;
	Возврат НовыеЭлементы;
КонецФункции

// reduce
// 
//МаксимальныйУровень = РаботаСМассивом.АТДМассив(ПоказателиРасчета)
//	.Отобразить("Макс(Накопитель, Элемент.Уровень)", 0)
//;
//
////  Группировка показателей по уровням
//Показатели = РаботаСМассивом.АТДМассив(ПоказателиРасчета)
//	.Отобразить("Элемент.Значение")
//	.Преобразовать("
//		|ОбщийКлиентСервер.ВставитьСвойство(
//		|	Накопитель, 
//		|	Элемент.Уровень, 
//		|	?(Накопитель[Элемент.Уровень] = Неопределено, 
//		|		ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Элемент),
//		|		РаботаСМассивом.Дополнить(Накопитель[Элемент.Уровень], ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Элемент))
//		|	)
//		|)", Новый Соответствие)
//;
//
////  Пересборка соответствия
//ЭлементыПоказателей = РаботаСМассивом.АТДМассив(Показатели)
//	.Преобразовать("ОбщийКлиентСервер.ВставитьСвойство(Накопитель, Элемент.Ключ, РаботаСМассивом.Отобразить(Элемент.Значение, ' ''ЗначенияПоказателей'' + Элемент.Код'))", Новый Соответствие)
//;
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
//
Функция Преобразовать(Элементы, ВыражениеБезОбработки, НачальноеЗначение = Неопределено, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	Выражение = ПривестиСтроку(ВыражениеБезОбработки);
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

//  shift
Функция Сдвинуть(Элементы) Экспорт
	ВГраница = Элементы.ВГраница();
	Если ВГраница = -1 Тогда
		Возврат Неопределено;
	КонецЕсли;
	Результат = Элементы[0];
	Элементы.Удалить(0);
	Возврат Результат;
КонецФункции

//  push
Функция Положить(Элементы, Элемент) Экспорт
	Элементы.Добавить(Элемент);
	Возврат Элементы;
КонецФункции

//  add
Функция Добавить(Элементы, Элемент) Экспорт
	Элементы.Добавить(Элемент);
	Возврат Элементы;
КонецФункции

//  slice
Функция Срез(Элементы, НижняяГраница = 0, Знач ВерхняяГраница = Неопределено, Шаг = 1) Экспорт
	Если ВерхняяГраница = Неопределено Тогда
		ВерхняяГраница = Элементы.Количество();
	КонецЕсли;
	Результат = Новый Массив;
	Индекс = НижняяГраница;
	Пока Индекс < ВерхняяГраница Цикл
		Результат.Добавить(Элементы[Индекс]);
		Индекс = Индекс + Шаг;
	КонецЦикла;
	Возврат Результат;
КонецФункции

//  range
Функция Диапазон(НижняяГраница, ВерхняяГраница, Шаг = 1) Экспорт
	Если НижняяГраница >= ВерхняяГраница Тогда
		Возврат Новый Массив;
	КонецЕсли;
	Результат = Новый Массив;
	Индекс = НижняяГраница;
	Пока Истина Цикл
		СледующийИндекс = Индекс + Шаг;
		Если СледующийИндекс > ВерхняяГраница Тогда
			Прервать;
		КонецЕсли;
		Результат.Добавить(Индекс);
		Индекс = СледующийИндекс;
	КонецЦикла;
	Возврат Результат;
КонецФункции

//  forEach
Функция ДляКаждого(Элементы, АлгоритмБезОбработки, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	Алгоритм = ПривестиСтроку(АлгоритмБезОбработки);
	Для Каждого Элемент Из Элементы Цикл
		//@skip-check unsupported-operator
		Выполнить(Алгоритм);
	КонецЦикла;
КонецФункции

// Следующий.
// 
// Параметры:
//  Индекс - Число
//  Элемент - Неопределено
//  Элементы - Массив из Неопределено
//  Шаг - Число - Шаг, позволяет выполнять обход по данным заданной ширины
// 
// Возвращаемое значение:
//  Булево - Следующий
Функция Следующий(Индекс, Элемент, Элементы, Шаг = 1) Экспорт
	Если Индекс = Неопределено Тогда
		Индекс = 0;
	Иначе
		Индекс = Индекс + Шаг;
	КонецЕсли;
	Если Индекс > Элементы.ВГраница() Тогда
		Возврат Ложь;
	КонецЕсли;
	Элемент = Элементы[Индекс];
	Возврат Истина;
КонецФункции

// Сравнить.
// 
// Параметры:
//  А - Любой - сравнимаемое значение 1  
//  Б - Любой - сравнимаемое значение 2
//  Направление - Строка - +/-
// 
// Возвращаемое значение:
//  Число - < 0, сортировка поставит 1-ое значение по меньшему индексу, чем 2-ое, 
//			= 0, сортировка не меняет индексы значений,
//			> 0, сортировка поставит 2-ое значение по меньшему индексу, чем 1-ое 
Функция Сравнить(А, Б, Направление = "+") Экспорт
	Если А = Б Тогда
		Возврат 0;
	КонецЕсли;
	Результат = ?(А < Б, -1, 1);
	Возврат ?(Направление = "-", -Результат, Результат); 
КонецФункции

// Возвращает массив в свойств. Требования к свойствам такие же как при объявлении структуры.
// 
// Параметры:
//	Значение	- Строка - свойства через запятую 
//              - Массив - возвращается в исходном массиве
// Возвращаемое значение:
//	Массив - массив свойств
//
Функция Массив(Значение) Экспорт
	ТипЗначения = ТипЗнч(Значение);
	Если ТипЗначения = Тип("Массив") Тогда
		Возврат Значение;
	КонецЕсли;
	Если ТипЗначения = Тип("Строка") И НЕ ПустаяСтрока(Значение) Тогда
		Возврат СтрРазделить(СтрЗаменить(СтрЗаменить(Значение, " ", ""), Символы.ПС, ""), ",", Ложь);
	КонецЕсли;
	Возврат Новый Массив;
КонецФункции

//  Параметры:
//    Поля - Строка - поля через запятую с указанием направления сортировки +/-
//  Возвращаемое значение:
//    Массив - {Поле, Направление}
Функция ПоляСравнения(Поля) Экспорт
	ПоляСравнения = Новый Массив;
	Для Каждого Поле Из Массив(Поля) Цикл
		Направление = Прав(Поле, 1);
		Если Направление = "+" ИЛИ Направление = "-" Тогда
			ПоляСравнения.Добавить(Новый Структура("Поле, Направление", Лев(Поле, СтрДлина(Поле) - 1), Направление));
		Иначе
			ПоляСравнения.Добавить(Новый Структура("Поле, Направление", Поле, "+"));
		КонецЕсли;
	КонецЦикла;
	Возврат ПоляСравнения;
КонецФункции

//  Сравнивает два структурных объекта. Сравнивается каждое поле отдельно и если они не равны, то сразу определяется порядок.
//  Т.е. принцип такой: находится первое неравенство и оно как больший разряд определяет порядок элементов.
Функция СравнитьПо(А, Б, ПоляСравнения) Экспорт
	Для Каждого ПолеСравнения Из ПоляСравнения Цикл
		Поле = ПолеСравнения.Поле;
 		Результат = Сравнить(А[Поле], Б[Поле], ПолеСравнения.Направление);
		Если Результат <> 0 Тогда
			Возврат Результат;
		КонецЕсли;
	КонецЦикла;
	Возврат 0;
КонецФункции

//  sortBy
Процедура СортироватьПо(Элементы, Знач Поля) Экспорт
	ПоляСравнения = ПоляСравнения(Поля);
	БыстраяСортировкаПо(Элементы, ПоляСравнения, 0, Элементы.ВГраница());
КонецПроцедуры

//  sort
Процедура Сортировать(Элементы, Знач ФункцияСравненияБезОбработки = Неопределено, Контекст = Неопределено, Параметры = Неопределено) Экспорт
	Если НЕ ЗначениеЗаполнено(ФункцияСравненияБезОбработки) ИЛИ ФункцияСравненияБезОбработки = "+" Тогда
		Список = Новый СписокЗначений;
		Список.ЗагрузитьЗначения(Элементы);
		Список.СортироватьПоЗначению();
		Элементы = Список.ВыгрузитьЗначения();
		Возврат;
	ИначеЕсли ФункцияСравненияБезОбработки = "-" Тогда
		Список = Новый СписокЗначений;
		Список.ЗагрузитьЗначения(Элементы);
		Список.СортироватьПоЗначению(НаправлениеСортировки.Убыв);
		Элементы = Список.ВыгрузитьЗначения();
		Возврат;
	КонецЕсли;
	ФункцияСравнения = ПривестиСтроку(ФункцияСравненияБезОбработки);
	БыстраяСортировка(Элементы, ФункцияСравнения, Контекст, Параметры, 0, Элементы.ВГраница());
КонецПроцедуры

Процедура СортироватьЭлементыКоллекции(ЭлементыКоллекции, Знач ФункцияСравненияБезОбработки = Неопределено, СортироватьВложенные = Истина) Экспорт
	Если ЗначениеЗаполнено(ФункцияСравненияБезОбработки) Тогда
		ФункцияСравнения = ПривестиСтроку(ФункцияСравненияБезОбработки);
	Иначе
		ФункцияСравнения = "Сравнить(А.Наименование, Б.Наименование)";
	КонецЕсли;
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
// Подробное описание алгоритма в [Распределение суммы по базе](https://infostart.ru/1c/articles/416217/)
// Алгоритм в сравнении с другими в [Честное распределение суммы](https://infostart.ru/1c/tools/16630/) (вариант 3) 
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
//  НижняяГраница - Число - нижняя граница среза
//  ВерхняяГраница - Число - верхняя граница среза
//  Шаг - Число - ширина обхода источника
//
Функция Дополнить(МассивПриемник, МассивИсточник, ТолькоУникальныеЗначения = Ложь, НижняяГраница = 0, Знач ВерхняяГраница = Неопределено, Шаг = 1) Экспорт
	Если ВерхняяГраница = Неопределено Тогда
		ВерхняяГраница = МассивИсточник.Количество();
	КонецЕсли;
	Индекс = НижняяГраница;
	Если ТолькоУникальныеЗначения Тогда
		УникальныеЗначения = Новый Соответствие;
		Для Каждого Значение Из МассивПриемник Цикл
			УникальныеЗначения.Вставить(Значение, Истина);
		КонецЦикла;
		Пока Индекс < ВерхняяГраница Цикл
			Значение = МассивИсточник[Индекс];
			Если УникальныеЗначения[Значение] = Неопределено Тогда
				МассивПриемник.Добавить(Значение);
				УникальныеЗначения.Вставить(Значение, Истина);
			КонецЕсли;
			Индекс = Индекс + Шаг;
		КонецЦикла;
	Иначе
		Пока Индекс < ВерхняяГраница Цикл
			МассивПриемник.Добавить(МассивИсточник[Индекс]);
			Индекс = Индекс + Шаг;
		КонецЦикла;
	КонецЕсли;
	Возврат МассивПриемник;
КонецФункции

// Возвращает разность массивов. Разностью двух массивов является массив, содержащий
// все элементы первого массива, не существующие во втором массиве.
//
// Параметры:
//  Массив - Массив - массив элементов, из которого необходимо выполнить вычитание;
//  МассивВычитания - Массив - массив элементов, который будет вычитаться.
// 
// Возвращаемое значение:
//  Массив - разностью двух массивов.
//
// Пример:
//	//А = [1, 3, 5, 7];
//	//В = [3, 7, 9];
//	Результат = ОбщегоНазначенияКлиентСервер.РазностьМассивов(А, В);
//	//Результат = [1, 5];
//
Функция Разность(Знач Массив, Знач МассивВычитания) Экспорт
	
	Результат = Новый Массив;
	Для Каждого Элемент Из Массив Цикл
		Если МассивВычитания.Найти(Элемент) = Неопределено Тогда
			Результат.Добавить(Элемент);
		КонецЕсли;
	КонецЦикла;
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
	Дополнить(МассивПриемник, МассивИсточник, ТолькоУникальныеЗначения);
КонецПроцедуры

Функция Свернуть(Знач Массив) Экспорт
	Возврат Дополнить(Новый Массив, Массив, Истина);
КонецФункции

Функция Скопировать(МассивИсточник) Экспорт
	МассивРезультат = Новый Массив;
	Для Каждого Элемент Из МассивИсточник Цикл
		МассивРезультат.Добавить(Элемент);
	КонецЦикла;
	Возврат МассивРезультат;
КонецФункции

Функция СкопироватьМассив(МассивИсточник) Экспорт
	Возврат Скопировать(МассивИсточник);
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


//  Порядок определяется алгоритмом рекурсивного спуска по вершинам графа. Чем выше порядок, тем выше вершина
//	4 - 11 - 12 - 13
//	|   | \  /
//	3   7  10
//	|   |  | \
//	2   6  8  9
//	|   |
//	1   5
// Параметры:
//  Элементы - Массив
//  Ключ - Строка - имя свойства, которое определяет уникальность элемента. Используется для вывода пути к узлу элемента и для поиска подчиненных элементов, где хранятся только ключи
//  СвойствоПорядка - Строка - имя свойства, по которому определяется порядок. Тип свойства числовое
//  СвойствоПодчиненныхЭлементов - Строка - имя свойство, в котором хранится список подчиненных элементов
//  Словарь - Соответствие - используется для поиска элемента по ключу, если подчиненные элементы содержат только ключи
//  СвойствоЗначенияСловара - Строка - используется для доступа к подчиненному элементу, если по ключу из словаря элемент содержится в свойстве
//  
//  Если в процессе определения порядка обнаруживается циклическая ссылка, то выкидывается исключение с выводом цепочки зависимостей
//
Функция ОпределитьТопографическийПорядок(Элементы, Ключ = "Идентификатор", СвойствоПодчиненныхЭлементов = "ПодчиненныеЭлементы", СвойствоПорядка = "Порядок", Словарь = Неопределено, СвойствоЗначенияСловара = Неопределено) Экспорт
	ТипКоллекции = ТипЗнч(Элементы);
	ЭтоКлючЗначение = (ТипКоллекции = Тип("Соответствие") ИЛИ ТипКоллекции = Тип("Структура"));
	Если НЕ ЗначениеЗаполнено(Словарь) Тогда
		Словарь = Новый Соответствие;
		Для Каждого ЭлементИлиКлючЗначение Из Элементы Цикл
			Если ЭтоКлючЗначение Тогда
				Элемент = ЭлементИлиКлючЗначение.Значение;
			Иначе
				Элемент = ЭлементИлиКлючЗначение;
			КонецЕсли;
			Словарь[Элемент[Ключ]] = Элемент;
			Элемент[СвойствоПорядка] = -1;
		КонецЦикла;
	Иначе
		Для Каждого ЭлементИлиКлючЗначение Из Элементы Цикл
			Если ЭтоКлючЗначение Тогда
				Элемент = ЭлементИлиКлючЗначение.Значение;
			ИначеЕсли ТипЗнч(ЭлементИлиКлючЗначение) = Тип("Строка") Тогда
				Если ЗначениеЗаполнено(СвойствоЗначенияСловара) Тогда
					Элемент = Словарь[ЭлементИлиКлючЗначение][СвойствоЗначенияСловара];
				Иначе
					Элемент = Словарь[ЭлементИлиКлючЗначение];
				КонецЕсли;
			Иначе
				Элемент = ЭлементИлиКлючЗначение;
			КонецЕсли;
			Элемент[СвойствоПорядка] = -1;
		КонецЦикла;
	КонецЕсли;
	Возврат ОпределитьПорядок(Элементы, СвойствоПорядка, СвойствоПодчиненныхЭлементов, РаботаСОчередью.ОчередьУникальныхЗначений(Ключ), Словарь, СвойствоЗначенияСловара)
КонецФункции

Функция Содержит(Элементы, Значение) Экспорт
	Возврат Элементы.Найти(Значение) <> Неопределено;
КонецФункции

#КонецОбласти

//@skip-check server-execution-safe-mode
//@skip-check module-unused-local-variable
#Область СлужебныеПроцедурыИФункции

//  Топографическая сортировка
Функция ОпределитьПорядок(Элементы, СвойствоПорядка, СвойствоПодчиненныхЭлементов, Очередь, Словарь, СвойствоЗначенияСловара, Знач Порядок = 0)
	ТипКоллекции = ТипЗнч(Элементы);
	ЭтоКлючЗначение = (ТипКоллекции = Тип("Соответствие") ИЛИ ТипКоллекции = Тип("Структура"));
	Для Каждого ЭлементИлиКлючЗначение Из Элементы Цикл
		//  Нужно проверить тип элемента. Если это подчиненные элементы, то это ключ, верхнего - это сами элементы
		Если ЭтоКлючЗначение Тогда
			Элемент = ЭлементИлиКлючЗначение.Значение;
		ИначеЕсли ТипЗнч(ЭлементИлиКлючЗначение) = Тип("Строка") Тогда
			Если ЗначениеЗаполнено(СвойствоЗначенияСловара) Тогда
				Элемент = Словарь[ЭлементИлиКлючЗначение][СвойствоЗначенияСловара];
			Иначе
				Элемент = Словарь[ЭлементИлиКлючЗначение];
			КонецЕсли;
		Иначе
			Элемент = ЭлементИлиКлючЗначение;
		КонецЕсли;
		ПорядокЭлемента = Элемент[СвойствоПорядка];
		Если ПорядокЭлемента <> -1 Тогда
			Порядок = Макс(Порядок, ПорядокЭлемента);
			Продолжить;
		КонецЕсли;
		//  Контроль циклической ссылки
		Если РаботаСОчередью.Содержит(Очередь, Элемент) Тогда
			ЭлементыСтека = РаботаСМассивом.Отобразить(Очередь.Элементы, СтрШаблон("Элемент['%1']", Очередь.Ключ));
			ЭлементыСтека.Добавить(Элемент[Очередь.Ключ]);
			ВызватьИсключение "Циклическая ссылка: " + СтрСоединить(ЭлементыСтека, "<--");
		КонецЕсли;
		//  Контроль циклической ссылки
		РаботаСОчередью.Положить(Очередь, Элемент);
		//  Рекурсивный спуск
		Порядок = ОпределитьПорядок(Элемент[СвойствоПодчиненныхЭлементов], СвойствоПорядка, СвойствоПодчиненныхЭлементов, Очередь, Словарь, СвойствоЗначенияСловара, Порядок);
		//  Контроль циклической ссылки
		РаботаСОчередью.Взять(Очередь);
		//  Порядок
		Порядок = Порядок + 1;
		Элемент[СвойствоПорядка] = Порядок;
	КонецЦикла;
	Возврат Порядок;
КонецФункции

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

Процедура БыстраяСортировкаПо(Элементы, ПоляСравнения, НижнийПредел, ВерхнийПредел) Экспорт
	Если НЕ ЗначениеЗаполнено(Элементы) Тогда
		Возврат;
	КонецЕсли;
    Начало = НижнийПредел;
    Конец = ВерхнийПредел;
    Б = Элементы[Цел((Начало + Конец)/2)];
	Пока Истина Цикл
		А = Элементы[Начало];
        Пока СравнитьПо(А, Б, ПоляСравнения) < 0 Цикл // Элементы[Начало] < Б
            Начало = Начало + 1;                   
			А = Элементы[Начало];
		КонецЦикла;
		А = Элементы[Конец];
        Пока СравнитьПо(А, Б, ПоляСравнения) > 0 Цикл // Элементы[Конец] > Б
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
        БыстраяСортировкаПо(Элементы, ПоляСравнения, НижнийПредел, Конец);        
	КонецЕсли; 
    Если Начало < ВерхнийПредел Тогда                      
        БыстраяСортировкаПо(Элементы, ПоляСравнения, Начало, ВерхнийПредел);        
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

Функция ОтобразитьСвойстваЭлементов(Элементы, Свойства) Экспорт
	СловарьОтображения = ОбщийКлиентСервер.СловарьОтображенияСвойств(Свойства);
	НовыеЭлементы = Новый Массив;
	Для Каждого Элемент Из Элементы Цикл
		НовыеЭлементы.Добавить(ОбщийКлиентСервер.ОтобразитьСвойства(Элемент, СловарьОтображения));
	КонецЦикла;
	Возврат НовыеЭлементы;
КонецФункции

#КонецОбласти