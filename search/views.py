from django.shortcuts import render, get_object_or_404, render_to_response
from django.http import HttpResponse
from .models import ReportReportsonFiles

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
        # _crime = request.POST['crime']
        _reportNum = request.POST['reportNum']
    else:
        # _crime = ''
        _reportNum = ''

    reports = ReportReportsonFiles.objects.filter(reportnum=_reportNum)
    # reports = ReportReportsonFiles.objects.filter(cname__cname__contains=_crime)
    return render(request, 'search/ajax_search.html', { 'reports': reports })


