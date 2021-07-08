import requests
from bs4 import BeautifulSoup
#외부 라이브러리갖고옴

#https://www.fastcampus.co.kr/category_dev_open/
URL = "https://www.fastcampus.co.kr/category_dev_open/"
response = requests.get(url=URL)

#print(response)
#print(response.text)
#정상 응답 200 나옴

soup = BeautifulSoup(response.text, "html.parser")
get_all_course = soup.find_all("div", {"class" : "course"})
def parsing_course(el):
    title = el.find("strong").text
    start = el.find("a").text
    url = el.find("a")["href"]
    print("강의명 : {}".format(title))
    print("개강일 : {}".format(start))
    print("강의 소개 페이지 url : {}".format(url))
    print("\n")
# def parsing_course(el):
#     print(el)

#robots.txt 를 읽어 긁을 수 있는 것을 확인한다. disallow는 긁으면 안된다.(법적문제)
for i in get_all_course:
    parsing_course(i)
print("total length : {}".format(get_all_course.__len__()))