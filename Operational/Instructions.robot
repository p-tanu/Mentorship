*** Settings ***
Library  SeleniumLibrary


*** Keywords ***
Open Amazon Website
    Open Browser  ${Url}   ${Browser}
    Maximize Browser Window

Given User Clicks On Electronics Options
    Click Link  ${Electronics} 

Then User Searches For Particular Item And Clicks On It
    [Arguments]  ${ARG}
    Input Text  ${Searchbar}  ${ARG}
    Click Element  ${SearchButton}
    Click Element  xpath://*[text()='${ARG}']

 
Then User Adds The Item In Cart
    Switch Window  New
    Scroll Element Into View  ${AddToCart}
    Click Element  ${AddToCart}

Given User Clicks On Cart
    Click Link  ${CartButton}


Then Users Checks For Recently Added Item
    [Arguments]  ${ARG}
    Page Should Contain  ${ARG}
   