***Settings***





***Keywords***
User Searches For An Item And Clicks On It
    Input Text  ${Searchbar}  ${Shirt}
    Click Element  ${SearchButton}
    Click Element  ${Prod}



Then Selects Size For ${Param} and ${InputMeasurements}
    Switch Window  New
    Click Element  ${Chart}
    ${rowCount}=    Get Element Count    ${Rows}
    ${colCount}=    Get Element Count    ${Columns}
    Log To Console  ${colCount}
    Log To Console  ${rowCount}
    # ${TextFile} =  Get File  Input.txt
    # ${List} =  Split to lines  ${TextFile}
    # Log To Console  ${List}
    # ${Param} =  Get From List  ${List}  0
    # ${InputMeasurements} =  Get From List  ${List}  1
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