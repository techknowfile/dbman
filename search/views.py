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

def getCrimeList(request):
    crimes = Crime.objects.all().values_list('cname', flat=True);
    return render(request, 'search/crimeOptions.html', {'crimes': crimes})
