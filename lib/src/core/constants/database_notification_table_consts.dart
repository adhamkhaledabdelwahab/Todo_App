const notificationTableName = 'notifications';
const createNotificationTableQuery = 'CREATE TABLE $notificationTableName ('
    '$notificationColumnId INTEGER PRIMARY KEY AUTOINCREMENT, '
    '$notificationColumnTaskUniqueName STRING, '
    '$notificationColumnIsRead INTEGER, '
    '$notificationColumnNotifiedAt STRING '
    ')';

const notificationColumnId = 'id';

const notificationColumnTaskUniqueName = 'taskUniqueName';

const notificationColumnIsRead = 'isRead';

const notificationColumnNotifiedAt = 'notifiedAt';
