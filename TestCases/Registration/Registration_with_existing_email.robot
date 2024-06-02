*** Settings ***
Library           SeleniumLibrary


*** Variables ***
${BROWSER}            Chrome
${URL}                https://thermos.com/account/register
${FULLNAME}           Irma Naomi
${EMAIL}              irma2@mailinator.com
${PHONE}              08123456789
${PASSWORD}           123456
${CONFIRM_PASSWORD}   123456

*** Test Cases ***
Registration With Existing Email
    Open Browser    ${URL}    ${BROWSER}
    Input Text      id=FirstName   ${FULLNAME}
    Input Text      id=Email        irmatampubolon1801@gmail.com    # Use an existing email
    Input Text      id=Phone        ${PHONE}
    Input Text      id=CreatePassword     ${PASSWORD}
    Input Text      id=CreatePassword    ${CONFIRM_PASSWORD}     
    Click Button    xpath=//element[@type='submit']
    # Assuming that the error message will be displayed in a element with id 'error_message'
    Wait Until Element Is Visible     css:.errors
    ${errorMessage}=    Get Text    css:.errors
    Should Be Equal As Strings    ${errorMessage}    This email address is already associated with an account.