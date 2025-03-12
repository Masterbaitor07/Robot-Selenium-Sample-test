*** Settings ***
Library  SeleniumLibrary
Library  LambdaTestStatus.py

*** Variables ***
${BROWSER}          Chrome
${BROWSER_VERSION}  119.0
${REMOTE_URL}       http://utkarshb:jBia0rbsZOK9wZH2hal1A6IlVB7SCPuMdLwAq3CprQOqWzJWwI@hub.lambdatest.com/wd/hub
${TIMEOUT}          30000
${IMPLICIT_WAIT}    9seconds

&{lt_options}       browserName=${BROWSER}      browserVersion=${BROWSER_VERSION}  
...                 name=RobotFramework Lambda Test    buildName=Robot Build

*** Keywords ***
Open test browser
    [Timeout]   ${TIMEOUT}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].${BROWSER}Options()    sys, selenium.webdriver
    Call Method    ${options}    set_capability    LT:Options    ${lt_options}
    Open Browser    https://lambdatest.github.io/sample-todo-app/
    ...    browser=${BROWSER}
    ...    remote_url=${REMOTE_URL}
    ...    options=${options}
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}

Close test browser
    Run keyword if    '${REMOTE_URL}' != ''
    ...    Report Lambdatest Status
    ...    ${TEST_NAME}
    ...    ${TEST_STATUS}
    Close All Browsers
