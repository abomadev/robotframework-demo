*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary
Library           SeleniumScreenshots

Suite Teardown      Close Browser
*** Variables ***
${LOGIN URL}      https://ng-bootstrap.github.io/#/components/dropdown/examples
${BROWSER}        Chrome

*** Test Cases ***
Dropdown Test
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Wait Until Page Contains    Toggle dropdown
    Sleep   1s
    Set Screenshot Directory   /Users/aboma/workspace/work/robotframework-demo/Results
    ${button}=      Set Variable    css:button#dropdownBasic1
    Capture Element Screenshot      ${button}   button.png
    Click Button    ${button}
    
    ${dropdown}=    Set Variable    css:div.dropdown-menu.show
    Capture Element Screenshot      ${dropdown}   dropdown.png

    Capture and crop page screenshot    dropdown-full.png   ${button}   ${dropdown}

*** Keywords ***
