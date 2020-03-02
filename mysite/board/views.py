from django.contrib.auth.models import User, Group
from rest_framework import viewsets
from board.serializers import UserSerializer, GroupSerializer

class UserViewset(viewsets.ModelViewSet):
    """
    comment
    """
    queryset = User.objects.all().order_by('-date_joined')
    serializer_class = UserSerializer

class GroupViewset(viewsets.ModelViewSet):
    """
    comment
    """
    queryset = Group.objects.all()
    serializer_class = GroupSerializer