from django.shortcuts import render, get_object_or_404, render_to_response
from django.http import HttpResponse
from .models import ReportReportsonFiles, Crime

# csrf token for valid forms
from django.template.context_processors import csrf

# Create your views here.

def search(request):
    # reports = ReportReportsonFiles.objects.all()     
    context = {}
    context.update(csrf(request))
    return render(request, 'search/report_search.html');
'''
def search_reports(request):
    if request.method == "POST":
        print('POSTED')
        _crime = request.POST['crime']
        _reportNum = request.POST['reportNum']
    else:
        _crime = ''
        _reportNum = ''

    # print(ReportReportsonFiles.objects.all()[0].cname.cname)
    reports = ReportReportsonFiles.objects.filter()
    if _reportNum:
        reports = reports.filter(reportnum__contains=_reportNum )
    if _crime:
        reports = reports.filter(cname__cname=_crime)
    # reports = ReportReportsonFiles.objects.filter(cname__cname__contains=_crime)
    return render(request, 'search/ajax_search.html', { 'reports': reports })
'''
#http://stackoverflow.com/questions/3134691/python-string-formats-with-sql-wildcards-and-like
def search_reports(request):
	values = []
	if request.method == "POST":
		print('POSTED')
		_crime = request.POST['crime']
		_reportNum = request.POST['reportNum']
	else:
		_crime = ''
		_reportNum = ''
		
	if _reportNum and _crime:
		reports = ReportReportsonFiles.objects.raw('SELECT * FROM report_reportson_files R, crime C WHERE C.cname = R.cname AND R.reportnum LIKE %s AND C.cname LIKE %s', ['%' + _reportNum + '%', '%' + _crime + '%']);
	elif _reportNum:
		reports = ReportReportsonFiles.objects.raw('SELECT * FROM report_reportson_files R, crime C WHERE C.cname = R.cname AND R.reportnum LIKE %s', ['%' + _reportNum + '%']);
	elif _crime:
		reports = ReportReportsonFiles.objects.raw('SELECT * FROM report_reportson_files R, crime C WHERE C.cname = R.cname AND C.cname LIKE %s', ['%' + _crime + '%']);
	if _reportNum or _crime:
		for r in reports:
			values.append([r.reportnum, r.cdatetime, r.caddress, r.cdescription, r.cname, r.clerkssn]);
	return render(request, 'search/ajax_search.html', { 'reports': reports })

'''
#	http://blog.appliedinformaticsinc.com/how-to-perform-raw-sql-queries-in-django/
from django.db import connection

def search_reports(request):
	if request.method == "POST":
		print('POSTED')
		_crime = request.POST['crime']
		_reportNum = request.POST['reportNum']
	else:
		_crime = ''
		_reportNum = ''
	
	cursor = connection.cursor();
	if _reportNum and _crime:
		cursor.execute('SELECT * FROM report_reportson_files R, Crime C WHERE C.cname = R.cname AND R.reportNum LIKE "%%s%" AND C.cname LIKE "%%s%"', [_reportNum, _crime]);
	elif _reportNum:
		cursor.execute('SELECT * FROM report_reportson_files R, Crime C WHERE C.cname = R.cname AND R.reportNum LIKE "%%s%"', [_reportNum, _crime]);
	elif _crime:
		cursor.execute('SELECT * FROM report_reportson_files R, Crime C WHERE C.cname = R.cname AND C.cname LIKE "%%s%"', [_reportNum, _crime]);
	reports = cursor.fetchall();
	return render(request, 'search/ajax_search.html', { 'reports': reports })
'''
#def getCrimeList(request):
#    crimes = Crime.objects.all().values_list('cname', flat=True);
#    return render(request, 'search/crimeOptions.html', {'crimes': crimes})

#http://stackoverflow.com/questions/20325168/how-to-retrive-values-form-rawqueryset-in-django
#https://docs.djangoproject.com/en/1.11/topics/db/sql/
#http://blog.appliedinformaticsinc.com/how-to-perform-raw-sql-queries-in-django/
def getCrimeList(request):
	values = [];
	crimes = Crime.objects.raw('SELECT * FROM crime');
	for c in crimes:
		values.append(c.cname);
	return render(request, 'search/crimeOptions.html', {'crimes': values})
	
	
	
	
	
