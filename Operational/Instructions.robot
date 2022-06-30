*** Settings ***
Library  SeleniumLibrary
Library  String
Library  Dialogs
Library  Collections
Library  OperatingSystem
Library  BuiltIn


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



Then Selects Size Of Product
    [Arguments]  ${Param}  ${InputMeasurements}
    Switch Window  New
    Click Element  ${Chart}
    ${rowCount}=    Get Element Count    ${Rows}
    ${colCount}=    Get Element Count    ${Columns}
    Log To Console  ${colCount}
    Log To Console  ${rowCount}
    FOR   ${colIndex}  IN RANGE    1  ${colCount} + 1
        ${colHeader}=    Get Text  xpath://table[@id='fit-sizechartv2-0-table-0']//tr[1]//th[${colIndex}] 
        Run Keyword If  '${Param}' == '${colHeader}'  Exit For Loop
    END
    Log To Console  ${Param}
    Log To Console  ${InputMeasurements}  
    FOR   ${rowIndex}  IN RANGE    2  ${rowCount} + 1
        ${curText}=    Get Text   xpath://table[@id='fit-sizechartv2-0-table-0']//tr[${rowIndex}]/td[${colIndex}]
        IF    "${curText}" == "${InputMeasurements}"      
            ${BrandSize}=   Get Text    xpath://table[@id='fit-sizechartv2-0-table-0']//tr[${rowIndex}]/td[1]
            Set Suite Variable    ${BrandSize}
            Log To Console  ${BrandSize}
        ELSE 
            Log To Console  ${curText}
        END
    END
#And Closes Size Chart
    Click Element  ${CloseChart}
    Sleep  5s
#And Selects A Size And Adds It To The Cart
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
    ${Cond} =  Run Keyword And Return Status  Element Should Be Visible  ${Box}
    Run Keyword If  ${Cond}  Click Element  xpath://span[@id='size_name_${BS}']
    ...  ELSE   Click Element  xpath://*[text()=' ${BrandSize} ']
    Sleep  5s
    
    Click Element  ${AddToCart}
   

User Selects A Product
    ${TextFile} =  Get File  Input.txt
    ${List} =    Split String    ${TextFile}    \n
    Log To Console  ${List}
    ${Length} =  Get Length  ${List}
    Log To Console  ${Length}
    FOR   ${Item}  IN RANGE    0  ${Length}
        ${Ele} =  Get From List  ${List}  ${Item}
        Log To Console  ${Ele}
        ${result} =    Split String    ${Ele}    _
        Log To Console  ${result}
        ${Shirt} =  Get From List  ${result}  0
        ${Param} =  Get From List  ${result}  1
        ${InputMeasurements} =  Get From List  ${result}  2
        Log To Console  ${Shirt}
        Log To Console  ${Param}
        Log To Console  ${InputMeasurements}
        Input Text  ${Searchbar}  ${Shirt}
        Click Element  ${SearchButton}
        Sleep  7s
        Click Element  ${Prod}
        Switch Window  New
        Click Element  ${Chart}
        ${rowCount}=    Get Element Count    ${Rows}
        ${colCount}=    Get Element Count    ${Columns}
        Log To Console  ${colCount}
        Log To Console  ${rowCount}
        FOR   ${colIndex}  IN RANGE    1  ${colCount} + 1
            ${colHeader}=    Get Text  xpath://table[@id='fit-sizechartv2-0-table-0']//tr[1]//th[${colIndex}] 
            Run Keyword If  '${Param}' == '${colHeader}'  Exit For Loop
        END
        Log To Console  ${Param}
        Log To Console  ${InputMeasurements}  
        FOR   ${rowIndex}  IN RANGE    2  ${rowCount} + 1
            ${curText}=    Get Text   xpath://table[@id='fit-sizechartv2-0-table-0']//tr[${rowIndex}]/td[${colIndex}]
            IF    "${curText}" == "${InputMeasurements}"      
                ${BrandSize}=   Get Text    xpath://table[@id='fit-sizechartv2-0-table-0']//tr[${rowIndex}]/td[1]
                Set Suite Variable    ${BrandSize}
                Log To Console  ${BrandSize}
            ELSE 
                Log To Console  ${curText}
            END
        END
        Click Element  ${CloseChart}
        Sleep  7s
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
        ${Cond} =  Run Keyword And Return Status  Element Should Be Visible  ${Box}
        Run Keyword If  ${Cond}  Click Element  xpath://span[@id='size_name_${BS}']
        ...  ELSE   Click Element  xpath://*[text()=' ${BrandSize} ']
        Sleep  5s
        Click Element  ${AddToCart}
    END
    



   