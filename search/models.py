# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from __future__ import unicode_literals

from django.db import models


class Assignedto(models.Model):
    ssn = models.ForeignKey('Detective', models.DO_NOTHING, db_column='ssn')
    inumber = models.ForeignKey('InvestigationRelatesto', models.DO_NOTHING, db_column='iNumber', primary_key=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'assignedto'
        unique_together = (('ssn', 'inumber'),)


class Clerk(models.Model):
    ssn = models.ForeignKey('User', models.DO_NOTHING, db_column='ssn', primary_key=True)

    class Meta:
        managed = False
        db_table = 'clerk'


class Crime(models.Model):
    cname = models.CharField(db_column='cName', primary_key=True, max_length=60)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'crime'

    def __str__(self):
        return self.cname

class Detective(models.Model):
    ssn = models.ForeignKey('Person', models.DO_NOTHING, db_column='ssn', primary_key=True)

    class Meta:
        managed = False
        db_table = 'detective'


class DjangoMigrations(models.Model):
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


class InvestigationRelatesto(models.Model):
    inumber = models.IntegerField(db_column='iNumber', primary_key=True)  # Field name made lowercase.
    reportnum = models.ForeignKey('ReportReportsonFiles', models.DO_NOTHING, db_column='reportNum', unique=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'investigation_relatesto'


class OfficerEmployedby(models.Model):
    ssn = models.ForeignKey('Person', models.DO_NOTHING, db_column='ssn', unique=True)
    badgenum = models.IntegerField(db_column='badgeNum', primary_key=True)  # Field name made lowercase.
    rank = models.CharField(max_length=30, blank=True, null=True)
    pname = models.ForeignKey('Precinct', models.DO_NOTHING, db_column='pName', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'officer_employedby'


class Person(models.Model):
    ssn = models.IntegerField(primary_key=True)
    birthdate = models.DateField(blank=True, null=True)
    name = models.CharField(max_length=60, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'person'


class Precinct(models.Model):
    pname = models.CharField(db_column='pName', primary_key=True, max_length=30)  # Field name made lowercase.
    phonenum = models.CharField(db_column='phoneNum', unique=True, max_length=12, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'precinct'


class ReportReportsonFiles(models.Model):
    reportnum = models.IntegerField(db_column='reportNum', primary_key=True)  # Field name made lowercase.
    cdatetime = models.DateTimeField(db_column='cDatetime', blank=True, null=True)  # Field name made lowercase.
    caddress = models.CharField(db_column='cAddress', max_length=60, blank=True, null=True)  # Field name made lowercase.
    cdescription = models.CharField(db_column='cDescription', max_length=500, blank=True, null=True)  # Field name made lowercase.
    cname = models.ForeignKey(Crime, models.DO_NOTHING, db_column='cName', blank=True, null=True)  # Field name made lowercase.
    clerkssn = models.ForeignKey(Clerk, models.DO_NOTHING, db_column='clerkSsn', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'report_reportson_files'


class StandardUser(models.Model):
    ssn = models.ForeignKey('User', models.DO_NOTHING, db_column='ssn', primary_key=True)

    class Meta:
        managed = False
        db_table = 'standard_user'


class StatusHasstatusHasoption(models.Model):
    ssn = models.ForeignKey('SuspectIson', models.DO_NOTHING, db_column='ssn')
    inumber = models.ForeignKey('SuspectIson', models.DO_NOTHING,
                                db_column='iNumber',
                                related_name='statushasstatusoption_inumber')  # Field name made lowercase.
    soname = models.ForeignKey('Statusoption', models.DO_NOTHING, db_column='soName', blank=True, null=True)  # Field name made lowercase.
    date = models.DateField()

    class Meta:
        managed = False
        db_table = 'status_hasstatus_hasoption'


class Statusoption(models.Model):
    soname = models.CharField(db_column='soName', primary_key=True, max_length=60)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'statusoption'


class SuspectIson(models.Model):
    ssn = models.ForeignKey(Person, models.DO_NOTHING, db_column='ssn')
    inumber = models.ForeignKey(InvestigationRelatesto, models.DO_NOTHING,
                                db_column='iNumber',
                                related_name='suspectison_inumber', primary_key=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'suspect_ison'
        unique_together = (('ssn', 'inumber'),)


class User(models.Model):
    ssn = models.ForeignKey(Person, models.DO_NOTHING, db_column='ssn', primary_key=True)
    username = models.CharField(unique=True, max_length=20)
    password = models.CharField(max_length=20)

    class Meta:
        managed = False
        db_table = 'user'


class Workson(models.Model):
    reportnum = models.ForeignKey(ReportReportsonFiles, models.DO_NOTHING, db_column='reportNum', primary_key=True)  # Field name made lowercase.
    badgenum = models.ForeignKey(OfficerEmployedby, models.DO_NOTHING, db_column='badgeNum', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'workson'
