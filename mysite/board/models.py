from django.db import models

# Create your models here.
class Board(models.Model):
    board_id = models.AutoField(primary_key=True)
    board_title = models.CharField(max_length=100)
    board_content = models.TextField(null=True, blank=True)
    add_dtm = models.DateTimeField(auto_now_add=True)
    mod_dtm = models.DateTimeField(auto_now=True)

    #file = models.FileField
    #file_name = models.CharField(db_column='', max_length=200)
    #user_name = models.CharField(max_length=100)
    #user_id = models.CharField(max_length=100)

    #def __str__(self):
    #class Meta:
        #managed = False
        #db_table='board'
