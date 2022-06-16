*** Settings ***
Resource  ../Operational/Instructions.robot
Resource  ../Operational/LocatorVariables.robot
Resource  ../Operational/Common.robot

Suite Setup  Open Amazon Website
#Suite Teardown  Close Browser

*** Test Cases ***
User Should Be Able To Add An Item In The Cart
    Given User Clicks On Electronics Options
    Then User Searches For Particular Item And Clicks On It  ${Extra}  
    Then User Adds The Item In Cart
    User Clicks On Cart
    Then Users Checks For Recently Added Item  ${Extra}  

User Should Be Able To Add Another Item In The Cart
    Given User Clicks On Electronics Options
    Then User Searches For Particular Item And Clicks On It  ${any}  
    Then User Adds The Item In Cart
    User Clicks On Cart
    Then Users Checks For Recently Added Item  ${any} 

User Should Be Able To Add A Product Into The Cart Based On Any Parameter In Size Chart
    [Tags]  First
    User Searches For An Item And Clicks On It
    Then Opens Size Chart  ${InputMeasurements}
    And Closes Size Chart
    And Selects A Size And Adds It To The Cart
    User Clicks On Cart 


    
    