*** Settings ***
Documentation         Curso Robot Do Zero to Hero
...
...                   Exemplo de automação de apis utilizando
...                   somente um arquivo

Library               RequestsLibrary

*** Variables ***
${URL}                https://my-json-server.typicode.com/yuryalencar/fake-api
${GET_EMPLOYEE_ID}    1

*** Test Cases ***
Teste na Requisição GET para Empregados (StatusCode)
  GET                 ${URL}/employees     expected_status=200

Teste na Requisição GET para o Empregado Yury
  ${response}=        GET                 ${URL}/employees/${GET_EMPLOYEE_ID}            expected_status=200

  Should Be Equal As Strings              ${GET_EMPLOYEE_ID}                  ${response.json()}[id]
  Should Be Equal As Strings              Yury Alencar                        ${response.json()}[name]
  Should Be Equal As Strings              Automation & QA Tech Lead           ${response.json()}[job]
  Should Be Equal As Strings              07091238095                         ${response.json()}[document]
