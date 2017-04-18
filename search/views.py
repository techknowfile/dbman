from django.shortcuts import render, get_object_or_404, render_to_response
from django.http import HttpResponse
from .models import ReportReportsonFiles, Crime, InvestigationRelatesto, Assignedto, Person, Workson, SuspectIson, StatusHasstatusHasoption, Clerk

# csrf token for valid forms
from django.template.context_processors import csrf

# Create your views here.
def login(request):
    return render(request, 'search/login.html')

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
    # crimes = Crime.objects.all().values_list('cname', flat=True);
    # return render(request, 'search/crimeOptions.html', {'crimes': crimes})
	values = [];
	crimes = Crime.objects.raw('SELECT * FROM crime');
	for c in crimes:
		values.append(c.cname);
	return render(request, 'search/crimeOptions.html', {'crimes': values})

def reportDetails(request, reportNum):
    report = ReportReportsonFiles.objects.raw('SELECT * FROM report_reportson_files as reports WHERE reportnum = %s', [reportNum])[0]
    investigation = InvestigationRelatesto.objects.raw('SELECT * FROM investigation_relatesto WHERE reportnum = %s', [reportNum])[0]
    detectiveObj = Assignedto.objects.raw('SELECT * FROM assignedto WHERE iNumber = %s', [investigation.inumber])[0]
    detectivePerson = detectiveObj.ssn.ssn
    officerObj = Workson.objects.raw('SELECT * FROM workson WHERE reportnum = %s', [reportNum])[0].badgenum
    officerPerson = officerObj.ssn
    suspectObj = SuspectIson.objects.raw('SELECT * FROM suspect_ison WHERE iNumber = %s', [investigation.inumber])[0]
    suspectPerson = suspectObj.ssn
    suspectStatus = StatusHasstatusHasoption.objects.raw('SELECT * FROM status_hasstatus_hasoption WHERE ssn = %s', [suspectPerson.ssn])[0]
    
    context = {}
    context['investigation'] = investigation
    context['report'] = report
    context['detective'] = detectivePerson
    context['suspect'] = suspectPerson
    context['officer'] = officerObj
    context['officerName'] = officerPerson.name
    context['suspectStatus'] = suspectStatus
    return render (request, 'search/reportDetails.html', context)

def createReport(request, username, password):
    user = User.objects.raw('SELECT ssn FROM user WHERE username = %s AND password = %s', [username, password])[0]
    print("USER.ssn:", user.ssn)
    clerkObj = Clerk.objects.raw('SELECT * FROM clerk WHERE ssn = %s', user.ssn)[0]
    if clerkObj:
        clerk = clerkObj.ssn 
        return render(request, 'search/createReport.html', {'clerk': clerk})
    else:
        print("NOOOOPEEE")
