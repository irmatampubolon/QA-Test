*** Settings ***
Library        SeleniumLibrary
Library        DateTime
Resource       ../resources/variables.robot

*** Keywords ***
Open Registration Page
    Open Browser    ${URL}    ${BROWSER}

Generate Timestamped Email
    ${timestamp}=    Get Current Date    result_format=%Y%m%d%H%M%S
    ${EMAIL}=    Set Variable    irmaaaa${timestamp}@mailinator.com
    [Return]    ${EMAIL}

Enter a valid full name
    Input Text      id=FirstName   ${FULLNAME}