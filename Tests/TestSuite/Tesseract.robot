*** Settings ***
Documentation   Simple example using SeleniumLibrary.
Library         SeleniumLibrary
Library         Process
Library         OperatingSystem
Library         String
Library         DataDriver    file=../solutions/solutions-01.csv   dialect=unix

Resource          ../../Resources/Utilities.robot  
Test Template     Execute Tesseract Script

Suite Teardown       Aggregate Results

*** Variables ***
# Folders
${RESULTS_FOLDER}       ${CURDIR}/../scripts
${SCRIPTS_FOLDER}       ${CURDIR}/../scripts
${RAW_DATA_FOLDER}  ${CURDIR}/../raw-data
${PREPROCESSED_DATA_FOLDER}  ${CURDIR}/../preprocessed
${OUTPUT_FOLDER}  ${CURDIR}/../output
${SOLUTIONS_FOLDER}  ${CURDIR}/../solutions

# Script
${OCR_SCRIPT}   tesseract.py
${PREPROCESSOR_SCRIPT}   preprocessor.py
${VALIDATOR_SCRIPT}   validator.py

${preprocess}     ${EMPTY}

*** Test Cases ***
Expect ${filename} to print ${solution}     Test.png    Test

*** Keywords ***
Execute Tesseract Script
    [Arguments]     ${filename}     ${solution}

    # Run preprocessor script
    Run Keyword If      '${preprocess}' != '${EMPTY}'   Run Preprocessor  ${filename}   ${preprocess}

    # Determine where to grab the input file from
    ${input}     Set Variable If	'${preprocess}' == '${EMPTY}'	    ${RAW_DATA_FOLDER}/${filename}      ${PREPROCESSED_DATA_FOLDER}/${filename}

    # Run the OCR algorithm
    ${name}     ${extension}    Split Extension     ${filename}     
    ${result}     Run Process     python    ${SCRIPTS_FOLDER}/${OCR_SCRIPT}  -i ${input}    -o ${OUTPUT_FOLDER}/${name}.txt    shell=yes
    
    # Run validator
    ${percentage}     Run Process     python    ${SCRIPTS_FOLDER}/${VALIDATOR_SCRIPT}   ${result.stdout}    ${solution}
    
    # Log Match percentage if not exact match
    Should Be Equal     ${result.stdout}    ${solution}     Match percentage: ${percentage.stdout}%

Run Preprocessor
    [Arguments]     ${filename}     ${filters_list}

    ${filters}  Replace String      ${filters_list}     ,   ${SPACE}

    ${result}     Run Process     python    ${SCRIPTS_FOLDER}/${PREPROCESSOR_SCRIPT}  -i ${RAW_DATA_FOLDER}/${filename}     -f ${filters}    -o ${PREPROCESSED_DATA_FOLDER}/${filename}    shell=yes