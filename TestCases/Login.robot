*** Settings ***
Library        SeleniumLibrary

*** Variables ***
${BROWSER}            Chrome
${URL}                https://thermos.com/account/register
${DASHBOARD_URL}      https://thermos.com
${FULLNAME}           Irma Naomi
${EMAIL}              irma4@mailinator.com
${PHONE}              08123456789
${PASSWORD}           123456
${CONFIRM_PASSWORD}   123456

*** Test Cases ***
Register Page
    Open Browser    ${URL}    ${BROWSER}
    Input Text      id=FirstName   ${FULLNAME}
    Input Text      id=Email        ${EMAIL} 
    Input Text      id=Phone           ${PHONE}
    Input Text      id=CreatePassword     ${PASSWORD}
    Input Text      id=CreatePassword    ${CONFIRM_PASSWORD}     
    Click Button    //*[@id="create_customer"]/div/button 
    Wait Until Page Contains    ${DASHBOARD_URL}
    ${current_url}=    Get Location
    Should Be Equal    ${current_url}    ${DASHBOARD_URL}
    Close Browser