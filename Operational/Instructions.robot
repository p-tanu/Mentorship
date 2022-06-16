*** Settings ***
Library  SeleniumLibrary
Library  Collections


*** Keywords ***
Open Amazon Website
    Open Browser  ${Url}   ${Browser}
    Maximize Browser Window

Given User Clicks On Electronics Options
    
    Click Link  ${Electronics} 

Then User Searches For Particular Item
    [Arguments]  ${ARG}
    Input Text  ${Searchbar}  ${ARG}
    Click Element  ${SearchButton}

And User Clicks On The Item 
    Click Element  ${ItemNeeded}    
    
  
Then User Adds The Item In Cart  
    Switch Window  New
    Scroll Element Into View  ${AddToCart}
    Click Element  ${AddToCart}

Given User Clicks On Cart
    Click Link  ${CartButton}


Then Users Checks For Recently Added Item
    [Arguments]  ${ARG}
    Page Should Contain  ${ARG}


Given User Clicks On Fashion Option
    Click Link  ${Fashion}
    
Then User Searches For Item
    Input Text  ${Searchbar}  ${shirt}
    Click Element  ${SearchButton}

Then User Should Be Able To Click On The Particular Item
  #  Scroll Element Into View  ${Prod}
    Click Element  ${Prod}

Then User Clicks On Size Chart
    Switch Window  New
    Scroll Element Into View  ${Sizechart}
    Click Element  ${Sizechart}

Then User Must Be Able To Fetch Data From Table 
    ${rowCount}=    Get Element Count    ${Rows}
    Log To Console  ${rowCount}
    FOR  ${rowIndex}  IN RANGE     2  ${rowCount} + 1
        ${curText}=    Get Text   xpath://table[@id='fit-sizechartv2-0-table-0']//tr[${rowIndex}]/td[4]
    IF   '${curText}' == '${cellText}'
        ${Dataa}  Get Text    xpath://table[@id='fit-sizechartv2-0-table-0']//tr[${rowIndex}]//td[1] 
    ELSE 
        Log To Console  ${curText}
        END
    END
    Log To Console  ${Dataa}
    Click Element   ${CloseChart}
    # Wait For And Click On Element
    IF    "${Dataa}" == "S"
        ${BS} =    Set Variable  0
    ELSE IF    "${Dataa}" == "M"
        ${BS} =    Set Variable  1
    ELSE IF    "${Dataa}" == "L"
        ${BS} =    Set Variable  2
    ELSE IF    "${Dataa}" == "XL"
        ${BS} =    Set Variable  3
    ELSE
        ${BS} =    Set Variable  4
    END
    Log To Console  ${BS}
    ${AA} =  Run Keyword And Return Status  Element Should Be Visible  ${PQR}
    Run Keyword If  ${AA}  Click Element  xpath://span[@id='size_name_${BS}']
    ...  ELSE   Click Element  xpath://*[text()=' ${Dataa} ']

    # IF   "${BOX}" == "True"
    #     Log To Console  ${Dataa}
    #     Click Element  xpath:(//span[@class = 'a-button-inner'])[23]
    
    # ELSE
    #     Click Element  xpath://*[text()=' ${Dataa} ']

    # END
   
    Sleep  2s
    Wait For And Click On Element  ${AddToCart}
    Wait For And Click On Element  ${CartButton}
    

   
    

