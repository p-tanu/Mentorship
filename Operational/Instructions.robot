*** Settings ***
Library  SeleniumLibrary
Library  String


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



Then Users Checks For Recently Added Item
    [Arguments]  ${ARG}
    Page Should Contain  ${ARG}


User Searches For An Item And Clicks On It
    Input Text  ${Searchbar}  ${Shirt}
    Click Element  ${SearchButton}
    Click Element  ${Prod}



Then Opens Size Chart
    [Arguments]  ${ARGS}
    Switch Window  New
    Click Element  ${Chart}
    ${rowCount}=    Get Element Count    ${Rows}
    ${colCount}=    Get Element Count    ${Columns}
    Log To Console  ${colCount}
    Log To Console  ${rowCount}
    FOR   ${rowIndex}  IN RANGE    2  ${rowCount} + 1
        ${curText}=    Get Text   xpath://table[@id='fit-sizechartv2-0-table-0']//tr[${rowIndex}]/td[4]
        IF    '${curText}' == '${ARGS}'      
            ${BrandSize}=   Get Text    xpath://table[@id='fit-sizechartv2-0-table-0']//tr[${rowIndex}]/td[1]
            Set Suite Variable    ${BrandSize}
            Log To Console  ${BrandSize}
        ELSE 
            Log To Console  ${curText}
        END
    END
    
    #Log Source



And Closes Size Chart
    Click Element  ${CloseChart}
    Sleep  5s


And Selects A Size And Adds It To The Cart
    IF    "${BrandSize}" == "S"
        ${BS} =    Set Variable  0
    ELSE IF    "${BrandSize}" == "M"     
        ${BS} =    Set Variable  1
    ELSE IF    "${BrandSize}" == "L"
        ${BS} =    Set Variable  2
    ELSE IF    "${BrandSize}" == "XL"
        ${BS} =    Set Variable  3
    ELSE    
        ${BS} =    Set Variable  4
    END
    Log To Console  ${BS}
    ${AA} =  Run Keyword And Return Status  Element Should Be Visible  ${PQR}
    Run Keyword If  ${AA}  Click Element  xpath://span[@id='size_name_${BS}']
    ...  ELSE   Click Element  xpath://*[text()=' ${BrandSize} ']
    Sleep  5s
    Click Element  ${AddToCart}
   





   