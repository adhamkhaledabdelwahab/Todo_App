const taskTableName = 'tasks';
const createTaskTableQuery = 'CREATE TABLE $taskTableName ('
    '$taskColumnId INTEGER PRIMARY KEY AUTOINCREMENT, '
    '$taskColumnTitle STRING, '
    '$taskColumnDesc TEXT, '
    '$taskColumnDate STRING, '
    '$taskColumnStartTime STRING, '
    '$taskColumnEndTime STRING, '
    '$taskColumnReminder INTEGER, '
    '$taskColumnRepeat INTEGER, '
    '$taskColumnColor INTEGER, '
    '$taskColumnIsCompleted INTEGER, '
    '$taskColumnIsFavourite INTEGER, '
    '$taskColumnIsNotified INTEGER, '
    '$taskColumnIsSeen INTEGER, '
    '$taskColumnUniqueName STRING UNIQUE, '
    '$taskColumnAudioPath STRING'
    ')';
const taskColumnId = 'id';
const taskColumnTitle = 'title';
const taskColumnDate = 'date';
const taskColumnDesc = 'description';
const taskColumnStartTime = 'startTime';
const taskColumnEndTime = 'endTime';
const taskColumnRepeat = 'repeat';
const taskColumnReminder = 'reminder';
const taskColumnColor = 'color';
const taskColumnIsCompleted = 'isCompleted';
const taskColumnIsFavourite = 'isFavourite';
const taskColumnIsNotified = 'isNotified';
const taskColumnIsSeen = 'isSeen';
const taskColumnUniqueName = 'uniqueName';
const taskColumnAudioPath = 'audioPath';
