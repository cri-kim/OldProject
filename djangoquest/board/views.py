from django.http import HttpResponse

def getList(request):
    return HttpResponse("board List");
def getDetailView(request):
    return HttpResponse("board getDetailView");
def modBoard(request):
    return HttpResponse("board modBoard");
def delBoard(request):
    return HttpResponse("board delBoard");
def getfile(request):
    return HttpResponse("board getfile");
def addBoard(request):
    return HttpResponse("board addBoard");