from .models import Board
from rest_framework import serializers

class BoardSerializer(serializers.ModelSerializer):
    class Meta:
        model = Board
        fields = ('board_id','board_title','board_content','add_dtm')
class BoardDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = Board
        fields = ('board_id','board_title','board_content','add_dtm','mod_dtm')
class BoardCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Board
        fields = ('board_title','board_content','add_dtm')

class BoardUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Board
        fields = ('board_id','board_title','board_content','mod_dtm')