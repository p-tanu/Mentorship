*** Settings ***
Resource  ../Operational/Instructions.robot
Resource  ../Operational/LocatorVariables.robot
Resource  ../Operational/Common.robot

Suite Setup  Open Amazon Website
#Suite Teardown  Close Browser

*** Test Cases ***
User Should Be Able To Add An Item In The Cart

    [Tags]  First
    Given User Clicks On Electronics Options
    Then User Searches For Particular Item  ${ARG}
    And User Clicks On The Item 
    Then User Adds The Item In Cart
    Given User Clicks On Cart
    Then Users Checks For Recently Added Item  ${ARG}

User Should Be Able To Fetch The Data From The Table
    [Tags]  Second
    Given User Clicks On Fashion Option
    Then User Searches For Item  
    Then User Should Be Able To Click On The Particular Item
    Then User Clicks On Size Chart
    Then User Must Be Able To Fetch Data From Table 
    


    


