*** Settings ***
Library  SeleniumLibrary
Library  String
Library  OperatingSystem
Library  Collections
Library  ../gs.py

*** Keywords ***
Open Amazon Website
    Open Browser  ${Url}   ${Browser}
    Maximize Browser Window

User Clicks On Electronics Options
    Click Link  ${Electronics} 

User Searches For Particular Item And Clicks On It
    [Arguments]  ${ARG}
    Input Text  ${Searchbar}  ${ARG}
    Click Element  ${SearchButton}
    Click Element  xpath://*[text()='${ARG}']

User Adds The Item In Cart
    Switch Window  New
    Scroll Element Into View  ${AddToCart}
    Click Element  ${AddToCart}

Users Checks For Recently Added Item
    [Arguments]  ${ARG}
    Page Should Contain  ${ARG}

User Searches For An Item And Clicks On It
    ${TextFile} =  Get File  Input.txt
    ${List} =  Split to lines  ${TextFile}
    ${Stringg} =  Convert To String  ${TextFile}
    Log To Console  ${List}
    ${result} =    Split String    ${Stringg}    _
    Log To Console  ${result}
    ${Shirt} =  Get From List  ${result}  0
    ${Param} =  Get From List  ${result}  1
    ${InputMeasurements} =  Get From List  ${result}  2
    Log To Console  ${Shirt}
    Log To Console  ${Param}
    Log To Console  ${InputMeasurements}
    Set Suite Variable    ${Param}
    Set Suite Variable    ${InputMeasurements}
    Input Text  ${Searchbar}  ${Shirt}
    Click Element  ${SearchButton}
    Click Element  ${Prod}

Opens Size Chart
    Switch Window  New
    Click Element  ${Chart}
    ${rowCount}=    Get Element Count    ${Rows}
    ${colCount}=    Get Element Count    ${Columns}
    Log To Console  ${colCount}
    Log To Console  ${rowCount} 
    #${InputMeasurements} =  Get Value From User  Enter Measurements
    FOR   ${colIndex}  IN RANGE    1  ${colCount} + 1
        ${colHeader}=    Get Text  xpath://table[@id='fit-sizechartv2-0-table-0']//tr[1]//th[${colIndex}] 
        Run Keyword If  '${Param}' == '${colHeader}'  Exit For Loop
    END
    Log To Console  ${Param}
    Log To Console  ${InputMeasurements}  
    FOR   ${rowIndex}  IN RANGE    2  ${rowCount} + 1
        ${curText}=    Get Text   xpath://table[@id='fit-sizechartv2-0-table-0']//tr[${rowIndex}]/td[${colIndex}]
        IF    ${curText} == ${InputMeasurements}     
            ${BrandSize}=   Get Text    xpath://table[@id='fit-sizechartv2-0-table-0']//tr[${rowIndex}]/td[1]
            Set Suite Variable    ${BrandSize}
            Log To Console  ${BrandSize}
        ELSE 
            Log To Console  ${curText}
        END
    END
    
Closes Size Chart
    Click Element  ${CloseChart}
    Sleep  5s

Selects A Size And Adds It To The Cart
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
    Sleep  3s
    Wait For And Click On Element  ${AddToCart}
    Wait For And Click On Element  ${CartButton}


User Fetches Data From Google Sheet 
    [Arguments]  ${arg1}
    ${Result1} =  Ret Data  ${arg1}   
    Log To Console  ${Result1}
    Set Suite Variable    ${Result1}
    

User Adds Product In Cart
    ${Length} =  Get Length  ${Result1}
    Log To Console  ${Length}
    FOR   ${Item}  IN RANGE    0  ${Length}
        ${Product} =  Get From List  ${Result1}  ${Item}
        Log To Console  ${Product}
        ${Prod_Name} =  Get From List  ${Product}  0
        ${Prod_Param} =  Get From List  ${Product}  1
        ${Prod_Measurements} =  Get From List  ${Product}  2
        Log To Console  ${Prod_Name}
        Log To Console  ${Prod_Param}
        Log To Console  ${Prod_Measurements}
        Input Text  ${Searchbar}  ${Prod_Name}
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
            Run Keyword If  '${Prod_Param}' == '${colHeader}'  Exit For Loop
        END
        Log To Console  ${Prod_Param}
        Log To Console  ${Prod_Measurements}  
        FOR   ${rowIndex}  IN RANGE    2  ${rowCount} + 1
            ${CurText}=    Get Text   xpath://table[@id='fit-sizechartv2-0-table-0']//tr[${rowIndex}]/td[${colIndex}]
            IF    "${CurText}" == "${Prod_Measurements}"      
                ${BrandSize}=   Get Text    xpath://table[@id='fit-sizechartv2-0-table-0']//tr[${rowIndex}]/td[1]
                Set Suite Variable    ${BrandSize}
                Log To Console  ${BrandSize}
            ELSE 
                Log To Console  ${CurText}
            END
        END
        Click Element  ${CloseChart}
        Sleep  5s
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
        Sleep  2s
        Click Element  ${AddToCart}
    END
