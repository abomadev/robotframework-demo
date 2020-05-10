*** Settings ***

*** Variables ***

*** Keywords ***
Log Results
    [Arguments]     ${result}
    Log To Console     Full Result: ${result} 
    Log To Console     STDOUT: ${result.stdout} 
    Log To Console     STDERR: ${result.stderr} 
    Log To Console     STDOUTPATH: ${result.stdout_path} 
    Log To Console     STDERRPATH: ${result.stderr_path} 

Aggregate Results
    log to Console  Running Suit Teardown
    Run Process     python    rebot   --name Combined    ${OUTPUT DIR}/output*

    # Run  rebot --name Combined ${OUTPUT DIR}/output*

# Run OCR Test
#     @{files}    List Files In Directory     ${RAW_DATA_FOLDER}  *.png   absolute
#     :FOR     ${FILE}    IN  @{files}
#     \   Execute Tesseract Script    ${FILE}