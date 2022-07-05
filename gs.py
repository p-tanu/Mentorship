from __future__ import print_function
from robot.api.deco import library,keyword
import os.path
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
import json
from google.oauth2 import service_account

SCOPES = ['https://www.googleapis.com/auth/spreadsheets']
SERVICE_ACCOUNT_FILE = 'keys.json'
creds = None
creds = service_account.Credentials.from_service_account_file(
                        SERVICE_ACCOUNT_FILE, scopes=SCOPES)
@library
class gs:
        def __init__(self) -> None:
                pass
        @keyword
        def Ret_Data(self):
                # The ID and range of a sample spreadsheet.
                SAMPLE_SPREADSHEET_ID = '11MPMQEjBYY8Rh_vxclJABaQir7jmz3v0J_jbCWFBFkQ'
                SAMPLE_RANGE_NAME = 'Data!A2:C3'
                service = build('sheets', 'v4', credentials=creds)
                # Call the Sheets API
                sheet = service.spreadsheets()
                result = sheet.values().get(spreadsheetId=SAMPLE_SPREADSHEET_ID,range=SAMPLE_RANGE_NAME).execute()
                #print(result)
                #print(type(result))
                #global res
                #results_path = os.environ["res"]
                res= result.get("values")
                print(res)
                #print(type(res))
                return res

        
# res = json.loads(result)
# print(res)
# type(res)



