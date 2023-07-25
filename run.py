import json

import requests
from bs4 import BeautifulSoup

URL = "https://j-archive.com/"

response = requests.get(URL)
soup = BeautifulSoup(response.text, "html.parser")

table = soup.find_all("table", class_="final_round")[1]
category = table.find("td", class_="category_name").text
clue = table.find("td", class_="clue_text").text
answer = table.find("em", class_="correct_response").text

print(json.dumps({"category": category, "clue": clue, "answer": answer}))
