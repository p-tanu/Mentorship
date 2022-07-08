*** Settings ***
Resource  ../Operational/Instructions.robot
Resource  ../Operational/LocatorVariables.robot
Resource  ../Operational/Common.robot
Resource  ../Input.txt

Suite Setup  Open Amazon Website
#Suite Teardown  Close Browser

*** Test Cases ***
#Argument 1
User Should Be Able To Add An Item In The Cart
    [Tags]  Argument_1
    Given User Clicks On Electronics Options
    When User Searches For Particular Item And Clicks On It  ${Extra}  
    And User Adds The Item In Cart
    And User Clicks On Cart
    Then Users Checks For Recently Added Item  ${Extra}  

User Should Be Able To Add Another Item In The Cart
    [Tags]  Argument_2
    Given User Clicks On Electronics Options
    When User Searches For Particular Item And Clicks On It  ${any}  
    And User Adds The Item In Cart
    And User Clicks On Cart
    Then Users Checks For Recently Added Item  ${any} 

#Input.txt File
User Should Be Able To Add A Product Into The Cart Based On Any Parameter In Size Chart
    [Tags]  InputFile
    Given User Searches For An Item And Clicks On It
    When Opens Size Chart  
    And Closes Size Chart
    And Selects A Size And Adds It To The Cart
    Then User Clicks On Cart

#Google Sheet
User Should Be Able To Add Product
    [Tags]  DataDriven
    Given User Fetches Data From Google Sheet  ${Range}
    When User Adds Product In Cart
    Then User Clicks On Cart