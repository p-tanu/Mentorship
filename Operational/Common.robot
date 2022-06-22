*** Keywords ***

Wait For And Click On Element
   [Arguments]    ${argx}
   Scroll Element Into View  ${argx}
   Wait Until Page Contains Element  ${argx}  timeout=10s
   Click Element  ${argx}

User Clicks On Cart
    Wait Until Page Contains Element  ${CartButton}
    Click Link  ${CartButton}