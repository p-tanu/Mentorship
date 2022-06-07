*** Settings ***
Resource  ../Operational/Instructions.robot
Resource  ../Operational/LocatorVariables.robot

Suite Setup  Open Amazon Website
#Suite Teardown  Close Browser

*** Test Cases ***
User Should Be Able To Add An Item In The Cart
    Given User Clicks On Electronics Options
    Then User Searches For Particular Item And Clicks On It  ${Extra}  
    Then User Adds The Item In Cart
    Given User Clicks On Cart
    Then Users Checks For Recently Added Item  ${Extra}  

User Should Be Able To Add Another Item In The Cart
    Given User Clicks On Electronics Options
    Then User Searches For Particular Item And Clicks On It  ${any}  
    Then User Adds The Item In Cart
    Given User Clicks On Cart
    Then Users Checks For Recently Added Item  ${any} 