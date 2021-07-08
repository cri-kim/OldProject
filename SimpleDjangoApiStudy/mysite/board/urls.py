from django.conf.urls import url, include
from . import views
from django.conf import settings
from django.conf.urls.static import static

app_name = 'board'

urlpatterns = [
    #url('api-auth/', include('board.urls')),
    url(r'^$', views.getBoardList.as_view(), name='board'),
    url(r'^board/$', views.getBoardList.as_view(), name='board_list'),
    url(r'^board/add/$', views.addBoard.as_view(), name='board_add'),
    url(r'^board/(?P<board_id>\d+)/$', views.getBoardDetail.as_view(), name='board_detail'),
    url(r'^board/(?P<board_id>\d+)/mod/$', views.modBoard.as_view(), name='board_mod'),
    url(r'^board/(?P<board_id>\d+)/del/$', views.delBoard.as_view(), name='board_del')
]

urlpatterns += static(settings.DEV_URL, document_root=settings.DEV_ROOT)