from .models import Board
from rest_framework.decorators import api_view
from .serializers import BoardSerializer, BoardDetailSerializer, BoardCreateSerializer,BoardUpdateSerializer
from rest_framework.generics import ListAPIView, RetrieveAPIView, UpdateAPIView, DestroyAPIView, CreateAPIView

class getBoardList(ListAPIView):
    queryset = Board.objects.all().order_by('-add_dtm')
    serializer_class = BoardSerializer

class getBoardDetail(RetrieveAPIView):
    lookup_field = 'board_id'
    queryset = Board.objects.all()
    serializer_class = BoardDetailSerializer

class modBoard(UpdateAPIView):
    lookup_field = 'board_id'
    queryset = Board.objects.all()
    serializer_class = BoardUpdateSerializer

class delBoard(DestroyAPIView):
    lookup_field = 'board_id'
    queryset = Board.objects.all()
    serializer_class = BoardSerializer

class addBoard(CreateAPIView):
    queryset = Board.objects.all()
    serializer_class = BoardCreateSerializer
