*** Settings ***
Library             DateTime
Library             SeleniumLibrary    implicit_wait=0:01:00    screenshot_root_directory=../FF_REGRESSION_SUITE/Output
Library        OperatingSystem
Library     String
Library     Collections
Suite Setup    Perform suite setpup

*** Keywords ***

Perform suite setpup
    ${options}=    Evaluate    sys.modules['selenium.webdriver.chrome.options'].Options()    sys
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --disable-software-rasterizer
    Call Method    ${options}    add_argument    --no-sandbox
    ${driver}=    Create Webdriver    Chrome    options=${options}
    Set Window Size    1920    1080
    Delete All Cookies




Click when element is visible
    [Arguments]    ${element_to_be_clicked}
    ${if_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${element_to_be_clicked}
    ...    ${MAX_TIMEOUT}
    ...    ${RETRY_FREQUENCY}
    IF    ${if_visible}
        Wait until keyword succeeds
        ...    ${MAX_TIMEOUT}
        ...    ${RETRY_FREQUENCY}
        ...    Click Element
        ...    ${element_to_be_clicked}
    ELSE
        Reload Page
        Wait Until Element Is Visible    ${element_to_be_clicked}    ${MAX_TIMEOUT}    ${RETRY_FREQUENCY}
        Wait until keyword succeeds
        ...    ${MAX_TIMEOUT}
        ...    ${RETRY_FREQUENCY}
        ...    Click Element
        ...    ${element_to_be_clicked}
    END


Input text if needed
    [Arguments]    ${locator}    ${input_text}
        Run Keyword And Ignore Error    Wait Until Element Is Visible    ${locator}    ${MAX_TIMEOUT}    ${RETRY_FREQUENCY}
        Run Keyword And Ignore Error    Scroll Element Into View    ${locator}
        Run Keyword And Ignore Error    Clear Element Text    ${locator}
        Input Text    ${locator}    ${input_text}

Compare if needed and continue on failure
    [Arguments]    ${locator}    ${expected_text}
    TRY
        Run Keyword And Ignore Error
        ...    Wait Until Element Is Visible
        ...    ${locator}
        ...    20s
        ${fetched_text}=    Run Keyword And Continue On Failure    get text    ${locator}
        Run Keyword And Continue On Failure    Should Be Equal    ${fetched_text}    ${expected_text}
    EXCEPT
    Log    ${TEST_NAME}:Assertion failure when comparing- ${fetched_text}!=${expected_text}   level=ERROR
    END

Select from dropdown
    [Arguments]    ${dropdown_arrow}     ${drop_down_value}    ${text_to_be_search}
        
        Click when element is visible without reload    ${dropdown_arrow}
        Press Keys        ${dropdown_arrow}    ${text_to_be_search}

        Wait Until Element Is Visible    ${drop_down_value}    15s
        Click when element is visible without reload    ${drop_down_value} 
    
    
Click when element is visible without reload
    [Arguments]    ${element_to_be_clicked}
    ${if_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${element_to_be_clicked}
    ...    ${MAX_TIMEOUT}
    ...    ${RETRY_FREQUENCY}
    Wait until keyword succeeds
    ...    ${MAX_TIMEOUT}
    ...    ${RETRY_FREQUENCY}
    ...    Click Element
    ...    ${element_to_be_clicked}

Get text when element is visible
    [Arguments]    ${locator}
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Visible
    ...    ${locator}
    ...    ${MAX_TIMEOUT}
    ...    ${RETRY_FREQUENCY}
    ${fetched_text}=    Run Keyword And Continue On Failure    get text    ${locator}
    RETURN    ${fetched_text}

login application
    Click when element is visible    ${pup-up_close} 
    Click when element is visible    ${login}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${email}     20s
    Input text if needed    ${email}    optimyautomationtester@gmail.com
    Input text if needed    ${password}     yRMhojb7
    Click when element is visible    ${login_button}

Start the application
        Click when element is visible    ${submit_application}
        Execute Javascript    window.scrollTo(0,1500)
        Click when element is visible    ${submit_application_final}

Fill the form
    Input text if needed    ${first_name}     Niha
    Input text if needed    ${last_name}     Sri
    Input text if needed    ${address}     Bengalore
    Input text if needed    ${postal}     1100
    Execute Javascript    window.scrollTo(0,100)

    Select from dropdown    ${country}    ${input_country}     IN
    Execute Javascript    window.scrollTo(0,1000)
    ${file_path}    Normalize Path    ${EXECDIR}/my_photo.jpg
    Choose File    //input[@type="file"]      ${file_path}

    Execute Javascript    window.scrollTo(0,500)
    Scroll Element Into View    ${gender}
    Click when element is visible without reload    ${gender}
    Execute Javascript    window.scrollTo(0,500)
    Select from dropdown   ${role_drop_down}      ${option_value}        Automation tester
    Execute Javascript    window.scrollTo(0,500)
    Click when element is visible without reload    ${JIRA}
    Execute Javascript    window.scrollTo(0,500)
    Click when element is visible without reload    ${Python}
    Click when element is visible without reload    ${Robot_framework} 
    Execute Javascript    window.scrollTo(0,-document.body.scrollHeight)
    Input text if needed    ${text_area}     ${skillset}  
    Click when element is visible without reload    ${next_button} 

Validations on final page
    Compare if needed and continue on failure    ${assert_firstname}    Niha
    Compare if needed and continue on failure    ${assert_lastname}    Sri
    Execute Javascript    window.scrollTo(0,500)
    Compare if needed and continue on failure    ${assert_address}    Bengalore

    Compare if needed and continue on failure    ${assert_postal}    1100
    Compare if needed and continue on failure    ${assert_country}    India
    Compare if needed and continue on failure    ${assert_firstname}    Niha
    Compare if needed and continue on failure    ${assert_firstname}    Niha
    Compare if needed and continue on failure    ${assert_firstname}    Niha
    Compare if needed and continue on failure    ${assert_firstname}    Niha
    ${assert_file}=    Get text when element is visible    ${assert_photo} 
    Compare if needed and continue on failure    ${assert_photo}    \${assert_file}
    Compare if needed and continue on failure    ${assert_gender}     Female
    Compare if needed and continue on failure    ${assert_role}     Automation tester
    Compare if needed and continue on failure    ${assert_skill_i}     JIRA
    Compare if needed and continue on failure    ${assert_skill_ii}     Python
    Compare if needed and continue on failure    ${assert_skill_iii}     Robot framework
    Execute Javascript    window.scrollTo(0,-document.body.scrollHeight)
    Click when element is visible without reload    ${validate_submit_button} 



*** Variables ***
${pup-up_close}        //button[@aria-label="Close"]
${login}    //a[text()='Login']
${submit_application}    //div[@class="page-main__content-wrapper"]//a
${submit_application_final}    //h2[contains(text(),'Applications in the process of submission')]/parent::section/div/a
${first_name}    //input[@aria-label="First name"]
${last_name}    //input[@aria-label="Last name"]
${address}    //textarea[@aria-label="Unit no/House no, Street"]
${postal}    //input[@aria-label="Select postal code"]
${country}    //select[@aria-label="Country"]
${input_country}    //select[@aria-label="Country"]//option[@value='IN']
${browse}    //span[@class="qq-uploader-selector--default"]/following-sibling::input
${gender}    //label[@aria-label="Female"]/div/div
${role_drop_down}    //select[@aria-label="Select a role you're applying for"]
${option_value}        //option[@value="7026c894-4e85-5e16-910a-b19ca1013c74"]
${email}    //label[@for="login-email"]/following-sibling::input
${password}    //input[@id="login-password"]
${login_button}    //button[@type="submit"]
${JIRA}    //label[@aria-label="JIRA"]/div/div
${Python}    //label[@aria-label="Python"]/div/div
${Robot_framework}    //label[@aria-label="Robot Framework"]/div/div
${text_area}    //html[@dir="ltr"]
${next_button}    //button[@id="navButtonNextMobile"]
${assert_firstname}  //strong[text()='First name']/parent::p/parent::div/div/div/div
${assert_lastname}  //strong[text()='Last name']/parent::p/parent::div/div/div/div
${assert_address}  //strong[text()='Unit no/House no, Street']/parent::p/parent::div/div/div/p
${assert_postal}  //strong[text()='Select postal code']/parent::p/parent::div/div/div/p
${assert_country}  //strong[text()='Country']/parent::p/parent::div/div/div/p

${assert_photo}    //strong[text()='Photo']/parent::p/parent::div/div//ul/li/a
${assert_gender}  //strong[text()='Gender']/parent::p/parent::div/div/ul/li
${assert_role}  //legend[text()='Role']/parent::fieldset/div/p/following-sibling::div/p
${assert_skill_i}  //div[@class="question question-checkbox view"]/div/ul/li[1]
${assert_skill_ii}  //div[@class="question question-checkbox view"]/div/ul/li[2]
${assert_skill_iii}  //div[@class="question question-checkbox view"]/div/ul/li[3]
${assert_role_dsicription}  //div[@class="question question-richtext view"]/div/div/p
${validate_submit_button}  //button[@id="submitButton"]


${MAX_TIMEOUT}          20s
${RETRY_FREQUENCY}      2s
${skillset}    working as an automation engineer


*** Test Cases ***

My QA test assesment
    Set Window Size    1920    1080
    Go To    https://automationinterface1.front.staging.optimy.net/en/
    login application
    Start the application
    Fill the form
    Validations on final page
    [Teardown]    Close All Browsers













