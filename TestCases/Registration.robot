*** Settings ***
Library        SeleniumLibrary
Library        DateTime
Resource       ../resources/variables.robot
Resource       ../resources/keywords.robot

*** Test Cases ***
Registration With Valid Data
    ${EMAIL}=    Generate Timestamped Email
    Open Registration Page
    Enter a valid full name
    Input Text      id=Email        ${EMAIL} 
    Input Text      id=Phone           ${PHONE}
    Input Text      //*[@id="CreatePassword"][1]    ${PASSWORD}
    Input Text      //*[@id="CreatePassword"][2]   ${CONFIRM_PASSWORD}     
    Click Button    //*[@id="create_customer"]/div/button 
    Wait Until Keyword Succeeds    10x    3s    Location Should Be    ${DASHBOARD_URL}
    ${current_url}=    Get Location
    Should Be Equal    ${current_url}    ${DASHBOARD_URL}
    Close Browser

Registration With Existing Email
    Open Registration Page
    Enter a valid full name
    Input Text      id=Email        ${EMAIL}  
    Input Text      id=Phone        ${PHONE}
     Input Text      //*[@id="CreatePassword"][1]    ${PASSWORD}
    Input Text      //*[@id="CreatePassword"][2]   ${CONFIRM_PASSWORD}     
    Click Button    //*[@id="create_customer"]/div/button 
    Page Should Contain    This email address is already associated with an account. If this account is yours, you can reset your password

    ${errorMessage}=    Get Text    //*[@id="create_customer"]/div[1]
    Should Be Equal As Strings    ${errorMessage}    This email address is already associated with an account. If this account is yours, you can reset your password

Registration With Mismatched Passwords
    ${EMAIL}=    Generate Timestamped Email
    Open Registration Page
    Enter a valid full name
    Input Text      id=Phone        ${PHONE}
    Input Text      //*[@id="CreatePassword"][1]    ${PASSWORD}
    Input Text      //*[@id="CreatePassword"][2]   ${CONFIRM_PASSWORD_MISMATCH}  
    Execute JavaScript    window.document.querySelector('.btn-gray.btn-full').click();

    ${alertText}=    Handle Alert    accept
    Should Be Equal As Strings    ${alertText}    Passwords do not match.

    Close Browser

Registration With Empty Email
    Open Registration Page
    Enter a valid full name
    Input Text      id=Email        ${EMPTY}  
    Input Text      id=Phone        ${PHONE}
    Input Text      //*[@id="CreatePassword"][1]    ${PASSWORD}
    Input Text      //*[@id="CreatePassword"][2]   ${CONFIRM_PASSWORD}     
    Execute JavaScript    window.document.querySelector('.btn-gray.btn-full').click();
    Page Should Contain    Email can't be blank.

    ${errorMessage}=    Get Text    //*[@id="create_customer"]/div[1]
    Should Be Equal As Strings    ${errorMessage}    Email can't be blank.

Registration With Empty Password
    ${EMAIL}=    Generate Timestamped Email
    Open Registration Page
    Enter a valid full name
    Input Text      id=Email        ${EMAIL}  
    Input Text      id=Phone        ${PHONE}
    Input Text      //*[@id="CreatePassword"][1]    ${EMPTY}
    Input Text      //*[@id="CreatePassword"][2]    ${EMPTY}    
    Execute JavaScript    window.document.querySelector('.btn-gray.btn-full').click();
    Page Should Contain    Password can't be blank.

    ${errorMessage}=    Get Text    //*[@id="create_customer"]/div[1]
    Should Be Equal As Strings    ${errorMessage}    Password can't be blank.