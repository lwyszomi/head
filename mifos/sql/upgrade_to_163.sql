ALTER TABLE SYSTEM_CONFIGURATION DROP COLUMN SCHEDULE_MEETING_ON_HOLIDAY;
ALTER TABLE SYSTEM_CONFIGURATION DROP COLUMN DAYS_FOR_CAL_DEFINITION;

/* see ClientRules.getNameSequence() for configured nameSequence */
ALTER TABLE SYSTEM_CONFIGURATION DROP COLUMN NAME_SEQUENCE;

UPDATE DATABASE_VERSION SET DATABASE_VERSION = 163 WHERE DATABASE_VERSION = 162;
