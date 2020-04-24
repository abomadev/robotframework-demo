*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***

*** Test Cases ***
Valid Login
    Open Browser    https://www.google.com      chrome
    Close Browser

*** Keywords ***
    Open Browser