*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary
Library           SeleniumScreenshots
Library           ./img-compare.py

Suite Setup         Setup Suite
Suite Teardown      Close Browser
*** Variables ***
${LOGIN URL}      https://ng-bootstrap.github.io/#/components/dropdown/examples
${BROWSER}        Chrome

*** Test Cases ***
Dropdown Test
    ${button}=      Set Variable    css:button#dropdownBasic1
    Capture Element Screenshot      ${button}   button.png
    Click Button    ${button}
    
    ${dropdown}=    Set Variable    css:div.dropdown-menu.show
    Capture Element Screenshot      ${dropdown}   dropdown.png   

    Capture and crop page screenshot    dropdown-full.png   ${button}   ${dropdown}

    Sleep   2s

    Capture Element Screenshot      css:div.dropdown-menu.show>button.dropdown-item     options.png

Test Duplicate
    ${result}=      Is Duplicate Image      button2.png     button3.png
    log to console      ${result}

*** Keywords ***
Setup Suite
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Wait Until Page Contains    Toggle dropdown
    Sleep   1s
    Set Screenshot Directory   /Users/aboma/workspace/work/robotframework-demo/Results
    