***Settings***
Library  SeleniumLibrary
Library  String
Library  Dialogs
Library  Collections
Library  OperatingSystem
#Library  DataDriver  
Resource  ../Operational/Instructions.robot
Resource  ../Operational/LocatorVariables.robot
Resource  ../Operational/Common.robot
Suite Setup  Open Amazon Website
Test Template  A Product Into The Cart Based On Given Parameters


***Test Cases***    Param    InputMeasurements
TC1    Chest    37
TC2    Shoulder    17.5    
TC3    Length    29





***Keywords***
A Product Into The Cart Based On Given Parameters
    [Arguments]  ${Param}  ${InputMeasurements}
    User Searches For An Item And Clicks On It
    Then Selects Size Of Product  ${Param}  ${InputMeasurements}
    User Clicks On Cart