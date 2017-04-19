from django import forms
from .models import ReportReportsonFiles

class reportForm(forms.ModelForm):

    class Meta:
        model = ReportReportsonFiles
        fields = ('caddress', 'cdescription', 'cname')
    def __init__(self, *args, **kwargs):
        super(reportForm, self).__init__(*args, **kwargs)
        self.fields['caddress'].label = "Address"
        self.fields['cdescription'].label = "Description"
        self.fields['cname'].label = "Crime"
