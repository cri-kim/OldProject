from django.contrib import admin
from django.urls import path, include
from rest_framework import routers
from board import views

router = routers.DefaultRouter()
router.register(r'users', views.UserViewset)
router.register(r'groups', views.GroupViewset)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include(router.urls)),
    path('api-auth/',include('rest_framework.urls', namespace='rest_framework'))
]
