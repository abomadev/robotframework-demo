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