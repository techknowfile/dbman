from django.conf.urls import include, url
from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'getCrimeList*', views.getCrimeList, name="getCrimeList"),
    url(r'^$', views.search_reports, name='search_reports'),
]
