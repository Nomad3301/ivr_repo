# Архипов Сергей - "Small game"
# Пользовательские сценарии

## Группа: 11-И-1
## Электронная почта: sergo.arkhipov@gmail.com
## VK: https://vk.com/no_heomo

### Сценарий 1 - создание игрового персонажа
1. Пользователь выбирает опцию создания персонажа в главном меню игры
2. Пользователь вводит имя персонажа
3. Пользователь выбирает внешний вид персонажа из опций, предложенных системой
4. Пользователь определяет стартовые характеристики персонажа
5. При наведении курсора на названия характеристик система предоставляет подробную информацию о них
6. Пользователь нажимает кнопку "завершить создание персонажа"
7. Система выводит диалоговое окно, предлагающая подтвердить создание именно такого персонажа
8. Если пользователь подтверждает, он переходит к основному игровому окну, если нет - возвращается на экран создания персонажа.

### Сценарий 2 - сохранение игрового прогресса
1. Пользователь нажимает Esc, тем самым ставя игру на паузу
2. Выводится список функций на паузе, пользователь выбирает "сохранить игру"
3. Выводится окно со списком файлов сохранения
4. Пользователь либо создает новый файл, либо перезаписывает старый
5. В случае создания нового файла, система генерирует его имя и создает файл в папке с игрой
6. Значения внутриигровых переменных переносятся в созданный файл
7. В случае перезаписывания старого, система спрашивает действительно ли пользователь хочет удалить старый файл сохранения и создать вместо него новый
8. В случае подтверждения, имя выбранного пользователем файла генерируется заново и происходит п. 6
9. В противном случае, игрок возвращается к окну со списком файлов сохранения

### Сценарий 3 - загрузка игрового прогресса
1. Пользователь либо в главном меню, либо в меню паузы выбирает опцию "загрузить игру"
2. Система выводит список файлов сохранений, лежащих в папке с файлом игры
3. Пользователь выбирает один из них
4. Система генерирует игровую ситуацию в которой значения всех переменных равны соответствующим значениям из файла сохранения
5. Пользователь продолжает игру в основном игровом окне, с той же ситуации, которая была в игре при создании этого файла сохранения

### Сценарий 4 - дедуктивный анализ
1. Пользователь нажимает клавишу отвечающую за открытие системы дедуктивного анализа
2. Открывается сооветствующее окно, в зависимости от значений переменных генерируется определенное количество интерактивных элементов, соответствующих фактам которыми обладает персонаж игрока
3. Пользователь перетаскивая и объединяя эти элементы генерирует цепочки рассуждений
4. В случае успешной цепочки рассуждений пользователь получает новую информацию, которую может использовать в дальнейшем

### Сценарий 5 - взаимодействие с внутриигровым персонажем
1. Пользователь подводит своего персонажа к другому внутриигровому персонажу, используя клавиши отвечающие за передвижение
2. Пользователь нажимает клавишу отвечающую за взаимодействие с внутриигровыми объектами
3. Открывается диалоговое окно с этим персонажем, в зависимости от значений переменных определяемых предыдущими событиями в контексте игры пользователю предоставляется выбор из определенных реплик, который чередуется с реакциями на выбранные реплкики внутриигрового персонажа
4. Пользователь доходит до некоторой логической точки в диалоге и выбирает опцию "завершить диалог"
5. Пользователь снова попадает в основное игровое окно