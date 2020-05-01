*** Settings ***
Documentation   Simple example using SeleniumLibrary.
Library         SeleniumLibrary
Library         Process
Library         OperatingSystem
Library         String
Library         CSVLib      

Resource          ../Resources/Utilities.robot        

*** Variables ***
${OCR_FOLDER}       /Users/aboma/workspace/work/robotframework-demo/Tests/ocr-scripts/
${RAW_DATA_FOLDER}  /Users/aboma/workspace/work/robotframework-demo/Tests/raw-data
${PREPROCESSED_DATA_FOLDER}  /Users/aboma/workspace/work/robotframework-demo/Tests/preprocessed
${OUTPUT_FOLDER}  /Users/aboma/workspace/work/robotframework-demo/Tests/output
${SOLUTIONS_FOLDER}  /Users/aboma/workspace/work/robotframework-demo/Tests/solutions

*** Test Cases ***
# Test Single List from CSV
# 	${singlelist}=		Read CSV As Single List		${SOLUTIONS_FOLDER}/solutions-01.csv
# 	log to console		${singlelist}

# Test List from CSV
# 	${singlelist}=		Read CSV As List		${SOLUTIONS_FOLDER}/solutions-01.csv
# 	log to console		${singlelist}

# Test Dictionary from CSV
# 	${singlelist}=		Read CSV As Dictionary		${SOLUTIONS_FOLDER}/solutions-01.csv    Input   Expected    ,
# 	log to console		${singlelist}


Run OCR Test
    @{files}    List Files In Directory     ${RAW_DATA_FOLDER}  *.png   absolute
    :FOR     ${FILE}    IN  @{files}
    \   Execute Tesseract Script    ${FILE}


*** Keywords ***
Execute Tesseract Script
    [Arguments]     ${filepath}

    ${path}     ${filename}     Split Path    ${filepath}
    ${name}     ${extension}    Split Extension     ${filename}     
    ${result}     Run Process     python    ${OCR_FOLDER}tesseract.py  -i ${filepath}    -o ${OUTPUT_FOLDER}/${name}-output.txt    shell=yes
    # Log Results  ${result}