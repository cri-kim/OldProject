from django.urls import path
from . import views

urlpatterns=[
    path('list', views.getList),
    path('view', views.getDetailView),
    path('mod', views.modBoard),
    path('del', views.delBoard),
    path('file', views.getfile),
    path('add', views.addBoard)
]