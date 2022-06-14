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
    Sleep  5s
    ${abc} =  Run Keyword And Return Status  Element Should Be Visible  ${xyz}
    Run Keyword If  ${abc}  Click Element  ${xyz}


    #Click Element  ${SS}


    # IF   "${BOX}" == "True"
    #     Log To Console  ${Dataa}
    #     Click Element  xpath:(//span[@class = 'a-button-inner'])[23]
    
    # ELSE
    #     Click Element  xpath://*[text()=' ${Dataa} ']

    # END
   

   
    

