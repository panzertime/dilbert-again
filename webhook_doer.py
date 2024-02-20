from datetime import datetime, timedelta
import requests
from os import getenv

import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

apiUrl = getenv("WEBHOOK_URL", "get a webhook URL from Slack")


todaysDate = datetime.today().strftime('%Y-%m-%d')
ninetySixDate = (datetime.today() - timedelta(days=(365.2422*28))).strftime('%Y-%m-%d')
description = "Today in Dilbert History for " + todaysDate + ": comic from " + ninetySixDate + " courtesy <https://dilbert.transglobal.world|Dilbert Website 2000>"


imageUrl = "https://dilberts.s3.amazonaws.com/" + ninetySixDate + ".gif"
check = requests.head(imageUrl)
if check.status_code != 200:
    imageUrl = imageUrl[:-4] + ".jpg"

body = {}
body["blocks"] = []
textPart = {}
imagePart = {}
textPart["type"] = "section"
textPart["text"] = {}
textPart["text"]["type"] = "mrkdwn"
textPart["text"]["text"] = description
imagePart["type"] = "image"
imagePart["image_url"] = imageUrl
imagePart["alt_text"] = "Dilbert comic from " + ninetySixDate

body["blocks"].append(textPart)
body["blocks"].append(imagePart)

bot = requests.post(apiUrl, json=body, verify=False)
