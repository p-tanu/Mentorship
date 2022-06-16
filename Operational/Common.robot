*** Keywords ***

User Clicks On Cart
    Wait Until Page Contains Element  ${CartButton}
    Click Link  ${CartButton}


Wait For Element
    [Arguments]  ${ARGSS}
    Wait Until Page Contains Element  ${ARGSS}